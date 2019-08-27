CREATE TRIGGER [dbo].[tr_WatchStrategy]  ON dbo.Strategies AFTER INSERT
AS  
DECLARE @StrategyID AS int 
DECLARE @Type 		AS int
DECLARE @Status 	AS int 

SELECT @StrategyId 	= StrategyId,		
       @Type 		= Type,
       @Status 		= Status 	
FROM INSERTED	   

--Logic to calculate the size of the order will need to be computed more accurately
--DECLARE @Price AS decimal(18,10)
--DECLARE @Size AS decimal(18,10)
--DECLARE @Funds AS decimal(18,10)=100
--DECLARE @MaxOpenOrders AS decimal(18,10)=5

--SELECT TOP 1 @Price = AskPrice FROM dbo.Tickers ORDER BY Sequence DESC

--SELECT TOP 1 @Funds = Value FROM dbo.Funds WHERE AllocationType = 1 --0 is reserve funds, 1 allocation type is funds for use

--IF @Funds > 0 AND @MaxOpenOrders > 0 AND @Price > 0
--BEGIN
--	SET @Size = @Funds / @MaxOpenOrders / @Price 

--	INSERT INTO dbo.Orders VALUES (NULL, @Price, @Size, 1, -1) --type 1 is simple run, status -1 is pending
--END

--Logic to calculate the size of the order will need to be computed more accurately
--DownUpStrategy
DECLARE @Price AS decimal(18,10)
SELECT TOP 1 @Price = AskPrice FROM dbo.Tickers ORDER BY Sequence DESC
IF @Price > 0
BEGIN
	DECLARE @Threshold AS decimal(18,10)=0.12
	INSERT INTO dbo.DownUpStrategies(StrategyID, BuyPrice, MinimumThreshold, SoldPrice) VALUES (@StrategyId, @Price, @Threshold, NULL) 
END

GO