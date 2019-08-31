CREATE TRIGGER [dbo].[tr_WatchTicker]  ON dbo.Tickers AFTER INSERT
AS  

--Store in variables
DECLARE	@bidPrice AS decimal(18, 2)
DECLARE	@bidSize  AS decimal(18, 10)
DECLARE	@askPrice AS decimal(18, 2)
DECLARE	@askSize  AS decimal(18, 10)
DECLARE	@Sequence AS bigint 

SELECT @bidPrice = bidPrice,
	   @bidSize  = bidSize ,
	   @askPrice = askPrice,
	   @askSize  = askSize ,
	   @Sequence = Sequence
	   FROM inserted

--TODO: TEMPORARY!!! Process any fills due to price movement
INSERT INTO dbo.Fills
SELECT OrderId, Price, Size  FROM dbo.Orders --TODO: Status 1 is OPEN ORDER, 0 is READY ORDER => THIS SHOULD BE OPEN ORDERS ONLY!!! ****
WHERE Status = 1 AND  ((Type = 1 AND @askPrice <= Price) OR (Type = 2 AND @bidPrice >= Price))

--Create trend entries
EXEC [dbo].[sp_add_trend] @bidPrice, @bidSize,	@askPrice,	@askSize, @Sequence 

--Update buy orders for DownUpStrategy
UPDATE dbo.Orders SET Status = 1 FROM dbo.Orders o WHERE o.Type = 1 AND o.Status = 0 AND o.Price >= @askPrice

GO