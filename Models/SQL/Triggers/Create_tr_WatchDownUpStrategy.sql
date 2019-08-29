CREATE TRIGGER [dbo].[tr_WatchDownUpStrategy]  ON dbo.DownUpStrategies AFTER INSERT
AS  
DECLARE @StrategyID AS int
DECLARE @BuyPrice AS decimal(18,2)
DECLARE @MinimumThreshold AS decimal(18,10)

SELECT @StrategyID			= StrategyID,
       @BuyPrice 			= BuyPrice,
       @MinimumThreshold	= MinimumThreshold 	
FROM INSERTED	   

GO