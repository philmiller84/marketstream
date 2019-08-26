CREATE TRIGGER [dbo].[tr_WatchTicker]  ON dbo.Tickers AFTER INSERT
AS  
--check if current trend
DECLARE @t_id INTEGER=NULL
DECLARE @t_trendType INTEGER=NULL

-- Status values: NULL (undefined), 0 (started), 1 (finished)

SELECT @t_id = t.TrendId, @t_trendType = Type FROM [dbo].[Trends] t WHERE t.StartSequence IS NOT NULL AND t.Status = 0

IF @t_id IS NULL
BEGIN
--if no current trend, start trend
INSERT INTO [dbo].[Trends]
SELECT Sequence				--[StartSequence]
      ,Sequence				--[EndSequence]
      ,bidPrice				--[StartBidPrice]		
      ,bidPrice				--[EndBidPrice]
      ,askPrice				--[StartAskPrice]
      ,askPrice				--[EndAskPrice]
	  ,NULL					--[Type]
	  ,0					--[Status]
FROM inserted
END
ELSE IF @t_id IS NOT NULL
BEGIN
	IF @t_trendType IS NOT NULL -- we have a trend
	BEGIN 
		-- can use function or complicated tables for threshold later
		DECLARE @thresholdValue FLOAT = 0.01
		DECLARE @isAbortTrend INTEGER=0

		SELECT @isAbortTrend = 
		CASE 
			WHEN @t_trendType = 1
				THEN CASE WHEN inserted.bidPrice - t.EndBidPrice < 0 AND t.EndBidPrice - inserted.bidPrice > @thresholdValue THEN 1 ELSE 0 END
			WHEN @t_trendType = -1
				THEN CASE WHEN t.EndBidPrice - inserted.bidPrice < 0 AND inserted.bidPrice - t.EndBidPrice > @thresholdValue THEN 1 ELSE 0 END
		END
		FROM [dbo].[Trends] t, inserted
		WHERE t.TrendId = @t_id

		IF @isAbortTrend = 1 -- aborting trend
		BEGIN
			--Update existing trend
			UPDATE [dbo].[Trends] SET Status = 1 FROM [dbo].[Trends] t WHERE t.TrendId = @t_id

			-- Create new trend element
			INSERT INTO [dbo].[Trends]
			SELECT t.EndSequence		--[StartSequence]
				  ,inserted.Sequence	--[EndSequence]
				  ,t.EndBidPrice		--[StartBidPrice]		
				  ,inserted.bidPrice	--[EndBidPrice]
				  ,t.EndAskPrice		--[StartAskPrice]
				  ,inserted.askPrice	--[EndAskPrice]
				  ,CASE 
					WHEN t.EndBidPrice < inserted.bidPrice 
					THEN 1 
					ELSE -1
					END				--[Type]
				  ,0				--[Status]
			FROM inserted, [dbo].[Trends] t
			WHERE t.TrendId = @t_id
		END
		ELSE --IF @isAbortTrend = 0 --not abort
		BEGIN 
			UPDATE [dbo].[Trends]
			SET EndBidPrice = inserted.BidPrice,
				EndAskPrice	= inserted.AskPrice,
				EndSequence	= inserted.Sequence
			FROM [dbo].[Trends] t, inserted
			WHERE t.TrendId = @t_id
		END 
	END
	ELSE -- @t_trendType IS NULL
	BEGIN 
		UPDATE [dbo].[Trends]
		SET Type =
			CASE WHEN t.StartBidPrice < inserted.BidPrice 
				THEN 1 
			WHEN  t.StartBidPrice > inserted.BidPrice 
				THEN -1 
			ELSE 
				NULL 
			END,
		Status = 0,
		EndBidPrice = inserted.BidPrice,
		EndAskPrice = inserted.AskPrice,
		EndSequence = inserted.Sequence
		FROM [dbo].[Trends] t, inserted
		WHERE t.TrendId = @t_id
	END
END

GO