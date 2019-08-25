CREATE TRIGGER [dbo].[tr_WatchTicker]  ON dbo.Tickers AFTER INSERT
AS  
--check if current trend
DECLARE @t_id INTEGER=NULL
DECLARE @t_trendType INTEGER=NULL
SELECT @t_id = t.TrendId, @t_trendType = Type FROM [dbo].[Trends] t WHERE t.StartSequence IS NOT NULL AND t.EndSequence IS NULL

IF @t_id IS NOT NULL
BEGIN
	IF @t_trendType IS NULL
	BEGIN 
		UPDATE [dbo].[Trends]
		SET Type = CASE WHEN t.StartBidPrice < inserted.BidPrice THEN 1 ELSE -1 END,
		EndBidPrice = inserted.BidPrice,
		EndAskPrice = inserted.AskPrice
		FROM [dbo].[Trends] t, inserted
		WHERE t.TrendId = @t_id
	END
	ELSE
	BEGIN 
		-- can use function or complicated tables for threshold later
		DECLARE @thresholdValue FLOAT = 0.01
		DECLARE @isAbortTrend INTEGER=NULL
		SELECT @isAbortTrend = 
		CASE 
			WHEN @t_trendType = 1
			THEN CASE WHEN inserted.bidPrice - t.EndBidPrice < 0 AND t.EndBidPrice - inserted.bidPrice > @thresholdValue THEN 1 ELSE 0 END
			WHEN @t_trendType = -1
			THEN CASE WHEN t.EndBidPrice - inserted.bidPrice < 0 AND inserted.bidPrice - t.EndBidPrice > @thresholdValue THEN 1 ELSE 0 END
		END
		FROM [dbo].[Trends] t, inserted
		WHERE t.TrendId = @t_id

		UPDATE [dbo].[Trends]
		SET EndBidPrice = inserted.BidPrice,
		EndAskPrice = inserted.AskPrice,
		EndSequence = CASE WHEN @isAbortTrend = 1 THEN inserted.Sequence END
		FROM [dbo].[Trends] t, inserted
		WHERE t.TrendId = @t_id
	END
END
ELSE
BEGIN
--if no current trend, start trend
INSERT INTO [dbo].[Trends]
SELECT Sequence			--[StartSequence]
      ,NULL				--[EndSequence]
      ,bidPrice			--[StartBidPrice]		
      ,NULL				--[EndBidPrice]
      ,askPrice			--[StartAskPrice]
      ,NULL				--[EndAskPrice]
	  ,NULL				--[Type]
FROM inserted
END

GO  
