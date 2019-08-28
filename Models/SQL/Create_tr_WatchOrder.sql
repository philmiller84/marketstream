CREATE TRIGGER [dbo].[tr_WatchOrder] ON dbo.Orders AFTER INSERT, UPDATE
AS  
DECLARE @OrderID AS int 
DECLARE @Type 		AS int
DECLARE @Status 	AS int 

SELECT @OrderID 	= OrderId,
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
END




GO