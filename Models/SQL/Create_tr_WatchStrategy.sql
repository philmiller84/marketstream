CREATE TRIGGER [dbo].[tr_WatchStrategy]  ON dbo.Strategies AFTER INSERT
AS  
DECLARE @StrategyID AS int 
DECLARE @Type 		AS int
DECLARE @Status 	AS int 

SELECT @StrategyId 	= StrategyId,		
       @Type 		= Type,
       @Status 		= Status 	
FROM INSERTED	   

--TODO: Logic to calculate the size of the order will need to be computed more accurately
--DownUpStrategy
DECLARE @Price AS decimal(18,10)
SELECT TOP 1 @Price = AskPrice FROM dbo.Tickers ORDER BY Sequence DESC
IF @Price > 0
BEGIN
	DECLARE @Threshold AS decimal(18,10)=0.12
	INSERT INTO dbo.DownUpStrategies(StrategyID, BuyPrice, MinimumThreshold, SoldPrice) VALUES (@StrategyId, @Price, @Threshold, NULL) 
END

GO