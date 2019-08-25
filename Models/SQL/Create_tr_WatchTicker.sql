CREATE TRIGGER [dbo].[tr_WatchTicker]  ON dbo.Tickers AFTER INSERT
AS  
INSERT INTO [dbo].[Trends]


SELECT Sequence			--[MinSequence]
      ,NULL				--[MaxSequence]
      ,bidPrice			--[MinBidPrice]		
      ,NULL				--[MaxBidPrice]
      ,askPrice			--[MinAskPrice]
      ,NULL				--[MaxAskPrice]
	  ,NULL				--[Type]
FROM inserted

GO  
