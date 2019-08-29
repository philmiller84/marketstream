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


IF @Type = 1  AND @Status IN (1,2) --limit buy order on exchange
	UPDATE dbo.Funds SET Value = Value - (@Size * @Price) 
IF @Type = 2 AND @Status IN(2)
	UPDATE dbo.Funds SET Value = Value + (@Size * @Price) 

IF @Status = 2 --completed order
BEGIN
	--Adjust position
	IF NOT EXISTS (SELECT 1 FROM dbo.Positions) INSERT dbo.Positions VALUES(0)
	UPDATE dbo.Positions SET Size = CASE WHEN @Type = 1 THEN Size + @Size WHEN @Type = 2 THEN Size - @Size ELSE Size END

	;--Mark strategy complete
	WITH StrategyStatus(OrderId, OrderStatus, StrategyId) AS
	(
		SELECT o2.OrderId, o2.Status, s.StrategyId
		FROM dbo.StrategyOrderJoins so
		JOIN dbo.StrategyOrderJoins so2 ON so.StrategyId = so2.StrategyId
		JOIN dbo.Orders o2 ON so2.OrderId = o2.OrderId
		JOIN dbo.Strategies  s ON so.StrategyId = s.StrategyId
		WHERE so.OrderId = @OrderID
	)
	UPDATE dbo.Strategies  
	SET Status = 2
	FROM dbo.Strategies  s
	JOIN StrategyStatus ON s.StrategyId = StrategyStatus.StrategyId
	WHERE NOT EXISTS (SELECT 1 FROM StrategyStatus WHERE OrderStatus <> 2)
END
GO