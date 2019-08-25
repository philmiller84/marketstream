CREATE TRIGGER [dbo].[tr_WatchTicker]  ON dbo.Tickers AFTER INSERT
AS  
INSERT INTO [dbo].[Trends]


SELECT Sequence			--[StartSequence]
      ,NULL				--[EndSequence]
      ,bidPrice			--[StartBidPrice]		
      ,NULL				--[EndBidPrice]
      ,askPrice			--[StartAskPrice]
      ,NULL				--[EndAskPrice]
	  ,NULL				--[Type]
FROM inserted

GO  
