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

--TODO: Make this controlled by exchange messages 
--TODO: Status 1 is OPEN ORDER, 0 is READY ORDER => THIS SHOULD BE OPEN ORDERS ONLY!!! ****
DECLARE @OrdersToFill TABLE (OrderId INT, Price decimal(18,2), Size decimal(18,10))
INSERT @OrdersToFill SELECT OrderId, Price, Size FROM dbo.Orders WHERE Status = 1 AND  ((Type = 1 AND @askPrice <= Price) OR (Type = 2 AND @bidPrice >= Price))

IF EXISTS (SELECT 1 FROM @OrdersToFill)
BEGIN
	INSERT INTO dbo.Fills SELECT OrderId, Price, Size  FROM @OrdersToFill
	IF @@ROWCOUNT > 0 AND dbo.GetLogLevel() >= 1 EXEC dbo.sp_log_event 1, N'[tr_WatchTicker]', N'Processed fills due to price movement TODO: Make this controlled by exchange messages. '
END


IF dbo.GetLogLevel() >= 1 EXEC dbo.sp_log_event 1, N'[tr_WatchTicker]', N'Create trend entries'
EXEC [dbo].[sp_add_trend] @bidPrice, @bidSize,	@askPrice,	@askSize, @Sequence 

DECLARE @OrdersToUpdate TABLE (OrderId INT)
INSERT @OrdersToUpdate SELECT o.OrderId FROM dbo.Orders o WHERE o.Type = 1 AND o.Status in (-1, 0) AND o.Price >= @askPrice --TODO: This is hacky, it is forcing pending and ready orders to be open

IF EXISTS(SELECT 1 FROM @OrdersToUpdate)
BEGIN
	UPDATE o SET Status = 1 FROM dbo.Orders o JOIN @OrdersToUpdate u ON o.OrderId = u.OrderId
	IF @@ROWCOUNT > 0 AND dbo.GetLogLevel() >= 1 EXEC dbo.sp_log_event 1, N'[tr_WatchTicker]', N'Updated buy orders for DownUpStrategy'
END

GO