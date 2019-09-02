CREATE procedure [dbo].[sp_add_trend] (
	@bidPrice decimal(18, 2),
	@bidSize decimal (18, 2),
	@askPrice decimal (18, 2),
	@askSize decimal (18, 2),
	@Sequence bigint 
) 
AS
BEGIN

    SET NOCOUNT ON

    /*
    ** Declarations.
    */
    DECLARE @retcode int=0
            
	-------------------= CREATE TRENDS =-------------------- 

	--Check if current trend
	DECLARE @t_id INTEGER=NULL
	DECLARE @t_trendType INTEGER=NULL
	SELECT @t_id = t.TrendId, @t_trendType = Type FROM [dbo].[Trends] t WHERE t.StartSequence IS NOT NULL AND t.Status = 0 --Status values:= NULL (undefined), 0 (started), 1 (finished)

	--if no current trend, start trend
	IF @t_id IS NULL
		INSERT INTO [dbo].[Trends]
		SELECT @Sequence				--[StartSequence]
			,@Sequence				--[EndSequence]
			,@bidPrice				--[StartBidPrice]		
			,@bidPrice				--[EndBidPrice]
			,@askPrice				--[StartAskPrice]
			,@askPrice				--[EndAskPrice]
			,NULL					--[Type]
			,0					--[Status]
	ELSE IF @t_id IS NOT NULL -- we have a trend!!!
	BEGIN
			
		DECLARE @isAbortTrend INTEGER=0

		IF @t_trendType IS NULL -- Trend not defined yet, define it here
		BEGIN
			UPDATE [dbo].[Trends] SET Type = CASE WHEN t.StartBidPrice < @BidPrice THEN 1 WHEN  t.StartBidPrice > @BidPrice THEN -1 ELSE NULL END FROM [dbo].[Trends] t WHERE t.TrendId = @t_id
		END
		ELSE --We had a trend defined before, check for abort
		BEGIN 
			--TODO: can use function or complicated tables for threshold later
			DECLARE @thresholdValue AS decimal(18,10)

			SELECT @thresholdValue = sp.Value
			FROM dbo.StrategyProperties sp
			WHERE sp.StrategyType = 0 AND sp.Description = 'Downturn Threshold'

			SELECT @isAbortTrend = CASE WHEN @t_trendType = 1 THEN IIF(@bidPrice < t.EndBidPrice AND t.EndBidPrice - @bidPrice >= @thresholdValue, 1, 0)
										WHEN @t_trendType = -1 THEN IIF(t.EndBidPrice < @bidPrice AND @bidPrice - t.EndBidPrice >= @thresholdValue, 1, 0) 
								   END
			FROM [dbo].[Trends] t
			WHERE t.TrendId = @t_id

			IF @isAbortTrend = 1 -- aborting trend
			BEGIN
				--Update existing trend
				UPDATE [dbo].[Trends] SET Status = 1 FROM [dbo].[Trends] t WHERE t.TrendId = @t_id

				--Get Bid Spread for previous trend
				DECLARE @TrendSpread INT = 0
				SELECT @TrendSpread = 
					CASE 
						WHEN t.Type = 1 THEN ABS(t.EndBidPrice - t.StartBidPrice) 
						WHEN t.Type = -1 THEN ABS(t.StartAskPrice - t.EndAskPrice) 
					END 
				FROM dbo.Trends t WHERE t.TrendId = @t_id 

				--Calculate Moving Averages
				DECLARE @movingAverageTrendCount INT
				SELECT @movingAverageTrendCount = Value FROM dbo.Analysis WHERE Description = 'Moving Average Trend Count'
				DECLARE @averageTrendThreshold INT 
				SELECT @averageTrendThreshold = ABS(t.EndBidPrice - @bidPrice)
				FROM [dbo].[Trends] t
				WHERE t.TrendId = @t_id

				IF @movingAverageTrendCount IS NULL 
				BEGIN 
					SET @movingAverageTrendCount = 0
					INSERT dbo.Analysis VALUES ('Moving Average Trend Count', 0)
					INSERT dbo.Analysis VALUES ('Moving Average Bid Price', 0)
					INSERT dbo.Analysis VALUES ('Moving Average Spread', 0)
					INSERT dbo.Analysis VALUES ('Moving Average Trend Spread', 0)
					INSERT dbo.Analysis VALUES ('Moving Average Trend Threshold', 0)
				END

				DECLARE @movingAverageTrendRecordsMax INT = 0
				SELECT @movingAverageTrendRecordsMax = sp.Value FROM dbo.StrategyProperties sp WHERE sp.StrategyType = 0 AND sp.Description = 'Moving Average Trend Records Max'

				IF @movingAverageTrendCount < @movingAverageTrendRecordsMax
				BEGIN
					--Increment the count and store
					SET @movingAverageTrendCount += 1
					UPDATE dbo.Analysis SET Value = @movingAverageTrendCount WHERE Description = 'Moving Average Trend Count'
				END

				UPDATE dbo.Analysis SET Value += (@bidPrice - Value)/@movingAverageTrendCount WHERE Description = 'Moving Average Bid Price'
				UPDATE dbo.Analysis SET Value += ((@askPrice - @bidPrice) - Value)/@movingAverageTrendCount WHERE Description = 'Moving Average Spread'
				UPDATE dbo.Analysis SET Value += (@TrendSpread  - Value )/@movingAverageTrendCount WHERE Description = 'Moving Average Trend Spread'
				UPDATE dbo.Analysis SET Value += (@averageTrendThreshold - Value )/@movingAverageTrendCount WHERE Description = 'Moving Average Trend Threshold'

				--Adjust Sell increment for new sell orders
				UPDATE sp 
				SET sp.Value = a.Value 
				FROM dbo.StrategyProperties sp, dbo.Analysis a 
				WHERE sp.StrategyType = 0 AND sp.Description = 'Sell Increment' AND a.Description = 'Moving Average Trend Spread'

				UPDATE sp
				SET sp.Value = a.Value
				FROM dbo.StrategyProperties sp, dbo.Analysis a
				WHERE sp.StrategyType = 0 AND sp.Description = 'Downturn Threshold' AND a.Description = 'Moving Average Trend Threshold'

				--TODO: Adjust existing sell orders
			
				---- Create new trend element: opposite trend
				INSERT INTO [dbo].[Trends]
				SELECT t.EndSequence		--[StartSequence]
					  ,@Sequence			--[EndSequence]
					  ,@bidPrice			--[StartBidPrice]		
					  ,@bidPrice			--[EndBidPrice]
					  ,@askPrice			--[StartAskPrice]
					  ,@askPrice			--[EndAskPrice]
					  ,IIF(t.Type = -1, 1, -1) --[Type]
					  ,0				--[Status]
				FROM [dbo].[Trends] t
				WHERE t.TrendId = @t_id
			END
		END

		IF @isAbortTrend = 0 --Update the prices for the existing trend
			UPDATE [dbo].[Trends]
			SET Status = 0,
				EndBidPrice = CASE
					WHEN Type = -1 THEN IIF(@BidPrice < EndBidPrice, @BidPrice, EndBidPrice) 
					WHEN Type = 1 THEN IIF(@BidPrice > EndBidPrice, @BidPrice, EndBidPrice) 
				END,
				EndAskPrice = @AskPrice,
				EndSequence = @Sequence
			FROM [dbo].[Trends] t
			WHERE t.TrendId = @t_id

	END

	return @retcode
END