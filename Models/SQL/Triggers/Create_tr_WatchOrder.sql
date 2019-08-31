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

DECLARE @PreviousStatus AS int
SELECT @PreviousStatus = Status FROM DELETED

IF @Type = 1  AND ((@PreviousStatus IS NULL OR @PreviousStatus < 1) AND @Status IN (1, 2)) --limit buy order on exchange
	UPDATE dbo.Funds SET Value = Value - (@Size * @Price) 
IF @Type = 2 AND ((@PreviousStatus IS NULL OR @PreviousStatus < 2) AND @Status = 2)
	UPDATE dbo.Funds SET Value = Value + (@Size * @Price) 

IF @PreviousStatus < 2 AND @Status = 2 --completed order
BEGIN
	--Adjust position
	IF NOT EXISTS (SELECT 1 FROM dbo.Positions) INSERT dbo.Positions VALUES(0)

	UPDATE dbo.Positions SET Size = CASE WHEN @Type = 1 THEN Size + @Size WHEN @Type = 2 THEN Size - @Size ELSE Size END

	--For completed buy orders, update the related sell order for DownUpStrategy
	IF @Type = 1
	BEGIN
		;
		UPDATE o2
		SET Status = 1
		FROM dbo.StrategyOrderJoins so
		JOIN dbo.Strategies  s ON so.StrategyId = s.StrategyId
		JOIN dbo.Orders o ON so.OrderId = o.OrderId
		JOIN dbo.StrategyOrderJoins so2 ON so2.StrategyId = s.StrategyId
		JOIN dbo.Orders o2 ON so2.OrderId = o2.OrderId
		WHERE so.OrderId = @OrderID AND o2.Status < 1 AND o2.Type = 2
	END

	;--Mark strategy complete if all orders complete
	WITH StrategyStatus(OrderId, OrderStatus, StrategyId) AS
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
	SET Status = 2
	FROM dbo.Strategies  s
	JOIN StrategyStatus ON s.StrategyId = StrategyStatus.StrategyId
	WHERE NOT EXISTS (SELECT 1 FROM StrategyStatus WHERE OrderStatus <> 2)
END


GO