CREATE TRIGGER [dbo].[tr_WatchOrder] ON dbo.Orders AFTER INSERT, UPDATE
AS  
DECLARE @OrderID AS int 
DECLARE @Price		AS decimal(18,2)
DECLARE @Size 		AS decimal(18,10)
DECLARE @Type 		AS int
DECLARE @Status 	AS int 

SELECT @OrderID 	= OrderId,
       @Price 		= Price,
       @Size 		= Size,
       @Type 		= Type,
       @Status 		= Status 	
FROM INSERTED	  

DECLARE @cancelledStatus AS INT = -2
DECLARE @pendingStatus AS INT = -1 
DECLARE @readyStatus AS INT = 0
DECLARE @openStatus AS INT = 1
DECLARE @filledStatus AS INT = 2

DECLARE @PreviousStatus AS int
SELECT @PreviousStatus = Status FROM DELETED

DECLARE @limitBuy INT = 1
DECLARE @limitSell INT = 2

IF @PreviousStatus <> @Status AND @Status = @cancelledStatus --completed order
BEGIN
	IF @Type = @limitBuy --TODO: Check for no Fills on the cancelled order!!! Maybe this should be done in dbo.Fills instead...produced by records from exchange
	BEGIN
		UPDATE o2
		SET Status = @cancelledStatus
		FROM dbo.StrategyOrderJoins so
		JOIN dbo.Strategies  s ON so.StrategyId = s.StrategyId
		JOIN dbo.Orders o ON so.OrderId = o.OrderId
		JOIN dbo.StrategyOrderJoins so2 ON so2.StrategyId = s.StrategyId
		JOIN dbo.Orders o2 ON so2.OrderId = o2.OrderId
		WHERE so.OrderId = @OrderID AND o2.Status <> @readyStatus AND o2.Type = @limitSell
		IF @@ROWCOUNT > 0 AND dbo.GetLogLevel() >= 1 EXEC dbo.sp_log_event 1, N'[tr_WatchOrder]', N'Updated order status to Cancelled Order for Sell Order'
	END
END
ELSE IF @PreviousStatus <> @Status AND (@Status = @filledStatus) OR  (@Status = @cancelledStatus) --completed or cancelled
BEGIN
	--For completed buy orders, update the related sell order for DownUpStrategy
	IF @Type = @limitBuy
	BEGIN
		UPDATE o2
		SET Status = @readyStatus
		FROM dbo.StrategyOrderJoins so
		JOIN dbo.Strategies  s ON so.StrategyId = s.StrategyId
		JOIN dbo.Orders o ON so.OrderId = o.OrderId
		JOIN dbo.StrategyOrderJoins so2 ON so2.StrategyId = s.StrategyId
		JOIN dbo.Orders o2 ON so2.OrderId = o2.OrderId
		WHERE so.OrderId = @OrderID AND o2.Status = @pendingStatus AND o2.Type = @limitSell
		IF @@ROWCOUNT > 0 AND dbo.GetLogLevel() >= 1 EXEC dbo.sp_log_event 1, N'[tr_WatchOrder]', N'Updated order status to Open Order for Sell Order'
	END

	---------------------
	; WITH StrategyStatus(OrderId, OrderStatus, StrategyId) AS
	(
		SELECT o2.OrderId, o2.Status, s.StrategyId
		FROM dbo.StrategyOrderJoins so 
		JOIN dbo.Strategies  s ON so.StrategyId = s.StrategyId
		JOIN dbo.Orders o ON so.OrderId = o.OrderId
		JOIN dbo.StrategyOrderJoins so2 ON so2.StrategyId = s.StrategyId
		JOIN dbo.Orders o2 ON o2.OrderId = so2.OrderId
		WHERE so.OrderId = @OrderID 
	)
	UPDATE dbo.Strategies  
	SET Status = OrderStatus
	FROM dbo.Strategies  s
	JOIN StrategyStatus ON s.StrategyId = StrategyStatus.StrategyId
	WHERE NOT EXISTS (SELECT 1 FROM StrategyStatus WHERE OrderStatus <> @filledStatus) 
	OR NOT EXISTS (SELECT 1 FROM StrategyStatus WHERE OrderStatus <> @cancelledStatus) 
	---------------------
	IF @@ROWCOUNT > 0 AND dbo.GetLogLevel() >= 1 EXEC dbo.sp_log_event 1, N'[tr_WatchOrder]', N' Marked strategy all orders finished (complete or cancelled)'
END


GO