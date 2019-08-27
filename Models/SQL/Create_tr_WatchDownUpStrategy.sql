CREATE TRIGGER [dbo].[tr_WatchDownUpStrategy]  ON dbo.DownUpStrategies AFTER INSERT
AS  
DECLARE @DownUpStrategyID AS int 
DECLARE @StrategyID AS int
DECLARE @BuyPrice AS decimal(18,2)
DECLARE @MinimumThreshold AS decimal(18,10)

SELECT @DownUpStrategyId 	= DownUpStrategyId,		
	   @StrategyID			= StrategyID,
       @BuyPrice 		= BuyPrice,
       @MinimumThreshold 		= MinimumThreshold 	
FROM INSERTED	   

--Logic to calculate the size of the order will need to be computed more accurately
DECLARE @Size AS decimal(18,10)
DECLARE @Funds AS decimal(18,2)=100
DECLARE @MaxOpenOrders AS int=5

SELECT TOP 1 @Funds = Value FROM dbo.Funds WHERE AllocationType = 1 --0 is reserve funds, 1 allocation type is funds for use

IF @Funds > 0 AND @MaxOpenOrders > 0 AND @BuyPrice > 0
BEGIN
	DECLARE @pendingStatus int = -1
	DECLARE @readyStatus int = 0
	
	DECLARE @limitBuy int = 1
	DECLARE @limitSell int = 2
	
	DECLARE @outputInto AS TABLE (StrategyID INT, OrderID INT)
	
	SET @Size = @Funds / @MaxOpenOrders / @BuyPrice 
	INSERT dbo.Orders
	OUTPUT @StrategyID, INSERTED.OrderId INTO @outputInto
	VALUES (NULL, @BuyPrice, @Size, @limitBuy, @readyStatus)
	
	INSERT dbo.Orders
	OUTPUT @StrategyID, INSERTED.OrderId INTO @outputInto
	VALUES (NULL, @BuyPrice + @MinimumThreshold, @Size, @limitSell, @pendingStatus)


	INSERT INTO StrategyOrderJoins
	SELECT StrategyID, OrderID
	FROM @outputInto
END
GO