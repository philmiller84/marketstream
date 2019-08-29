USE [Models.MarketData]
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
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
            
	-- CREATE TREND ENTRY -- 
	--check if current trend
	DECLARE @t_id INTEGER=NULL
	DECLARE @t_trendType INTEGER=NULL

	-- Status values: NULL (undefined), 0 (started), 1 (finished)

	SELECT @t_id = t.TrendId, @t_trendType = Type FROM [dbo].[Trends] t WHERE t.StartSequence IS NOT NULL AND t.Status = 0

	IF @t_id IS NULL
	BEGIN
	--if no current trend, start trend
	INSERT INTO [dbo].[Trends]
	SELECT @Sequence				--[StartSequence]
		  ,@Sequence				--[EndSequence]
		  ,@bidPrice				--[StartBidPrice]		
		  ,@bidPrice				--[EndBidPrice]
		  ,@askPrice				--[StartAskPrice]
		  ,@askPrice				--[EndAskPrice]
		  ,NULL					--[Type]
		  ,0					--[Status]
	END
	ELSE IF @t_id IS NOT NULL
	BEGIN
		IF @t_trendType IS NOT NULL -- we have a trend
		BEGIN 
			--TODO: can use function or complicated tables for threshold later
			DECLARE @thresholdValue AS decimal(18,10)

			SELECT @thresholdValue = sp.Value
			FROM dbo.StrategyProperties sp
			WHERE sp.StrategyType = 0 AND sp.Description = 'Downturn Threshold - Real value'

			DECLARE @isAbortTrend INTEGER=0

			SELECT @isAbortTrend = 
			CASE 
				WHEN @t_trendType = 1
					THEN CASE WHEN @bidPrice - t.EndBidPrice < 0 AND t.EndBidPrice - @bidPrice > @thresholdValue THEN 1 ELSE 0 END
				WHEN @t_trendType = -1
					THEN CASE WHEN t.EndBidPrice - @bidPrice < 0 AND @bidPrice - t.EndBidPrice > @thresholdValue THEN 1 ELSE 0 END
			END
			FROM [dbo].[Trends] t
			WHERE t.TrendId = @t_id

			IF @isAbortTrend = 1 -- aborting trend
			BEGIN
				--Update existing trend
				UPDATE [dbo].[Trends] SET Status = 1 FROM [dbo].[Trends] t WHERE t.TrendId = @t_id

				-- Create new trend element
				INSERT INTO [dbo].[Trends]
				SELECT t.EndSequence		--[StartSequence]
					  ,@Sequence			--[EndSequence]
					  ,t.EndBidPrice		--[StartBidPrice]		
					  ,@bidPrice			--[EndBidPrice]
					  ,t.EndAskPrice		--[StartAskPrice]
					  ,@askPrice			--[EndAskPrice]
					  ,CASE 
						WHEN t.EndBidPrice < @bidPrice 
						THEN 1 
						ELSE -1
						END				--[Type]
					  ,0				--[Status]
				FROM [dbo].[Trends] t
				WHERE t.TrendId = @t_id
			END
			ELSE --IF @isAbortTrend = 0 --not abort
			BEGIN 
				UPDATE [dbo].[Trends]
				SET EndBidPrice = @BidPrice,
					EndAskPrice	= @AskPrice,
					EndSequence	= @Sequence
				FROM [dbo].[Trends] t
				WHERE t.TrendId = @t_id
			END 
		END
		ELSE -- @t_trendType IS NULL
		BEGIN 
			UPDATE [dbo].[Trends]
			SET Type =
				CASE WHEN t.StartBidPrice < @BidPrice 
					THEN 1 
				WHEN  t.StartBidPrice > @BidPrice 
					THEN -1 
				ELSE 
					NULL 
				END,
			Status = 0,
			EndBidPrice = @BidPrice,
			EndAskPrice = @AskPrice,
			EndSequence = @Sequence
			FROM [dbo].[Trends] t
			WHERE t.TrendId = @t_id
		END
	END

	return @retcode
END