CREATE TRIGGER [dbo].[tr_WatchOrder] ON dbo.Orders AFTER INSERT, UPDATE
AS  
DECLARE @OrderID AS int 
DECLARE @Size 		AS decimal(18,10)
DECLARE @Type 		AS int
DECLARE @Status 	AS int 

SELECT @OrderID 	= OrderId,
       @Size 		= Size,
       @Type 		= Type,
       @Status 		= Status 	
FROM INSERTED	   
	
IF @Status = 2
BEGIN
	;
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

	IF NOT EXISTS (SELECT 1 FROM dbo.Positions)
		INSERT dbo.Positions VALUES(0)

	UPDATE dbo.Positions SET Size = CASE WHEN @Type = 1 THEN Size + @Size WHEN @Type = 2 THEN Size - @Size ELSE Size END

END
GO