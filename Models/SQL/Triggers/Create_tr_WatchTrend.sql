CREATE TRIGGER [dbo].[tr_WatchTrend]  ON dbo.Trends AFTER INSERT, UPDATE
AS  
DECLARE @TrendId 		AS int 
DECLARE @StartSequence 	AS bigint 
DECLARE @EndSequence 	AS bigint 
DECLARE @StartBidPrice 	AS real 
DECLARE @EndBidPrice 	AS real 
DECLARE @StartAskPrice 	AS real 
DECLARE @EndAskPrice 	AS real 
DECLARE @Type 			AS int
DECLARE @Status 		AS int 

SELECT @TrendId 		= TrendId,		
       @StartSequence 	= StartSequence 	,
       @EndSequence 	= EndSequence 	,
       @StartBidPrice 	= StartBidPrice 	,
       @EndBidPrice 	= EndBidPrice 	,
       @StartAskPrice 	= StartAskPrice 	,
       @EndAskPrice 	= EndAskPrice 	,
       @Type 			= Type 			,
       @Status 		    = Status 	
FROM INSERTED	   

IF NOT EXISTS (SELECT 1 FROM DELETED) --OR EXISTS (SELECT 1 FROM INSERTED WHERE Status = 1)
BEGIN

	--if new record has upward trend, check for previous entry
	IF @Type = 1 --new record is a upward trend, check previous 
	BEGIN DECLARE @PreviousTrendType AS int = 0
		SELECT @PreviousTrendType = CASE WHEN TrendId = @TrendId THEN  LAG(Type) OVER (ORDER BY TrendId) ELSE @PreviousTrendType END
		FROM dbo.Trends
	END
	----if new record has downward trend, enter sell order for down-up-strategy
	--ELSE IF @Type = -1
	--BEGIN
	--	--TODO: Check for profit here
	--	--TODO: Refactor this to centralized control of strategy. NOT SURE HOW YET!!!
	--	UPDATE dbo.Orders 
	--	SET Status = 0 WHERE Status = -1 AND Type = 2
	--	AND Price <= @StartBidPrice
	--END

	IF @PreviousTrendType = -1 --previous was an downward trend, create pending strategy
	BEGIN --type 0 is the down up, status -1 is pending	

		DECLARE @Funds AS decimal(18,10)=0
		SELECT @Funds = Value FROM dbo.Funds WHERE AllocationType = 1 --allocation type is funds for use

		--Get open strategies
		DECLARE @OpenStrategies AS int = 0
		SELECT @OpenStrategies = COUNT(*) FROM dbo.Strategies s
		WHERE s.Status <> 2

		DECLARE @MaxOpenOrders AS int
		SELECT @MaxOpenOrders = sp.Value FROM dbo.StrategyProperties sp WHERE sp.StrategyType = 0 AND sp.Description = 'Max Open Orders'
			
		DECLARE @AskPrice AS decimal(18,10)
		SELECT TOP 1 @AskPrice = AskPrice FROM dbo.Tickers ORDER BY Sequence DESC

		--Minimum order cost is price of coin * minimum size of order
		DECLARE @MinOrderCost AS decimal(18,2) = 20
		SELECT @MinOrderCost = @AskPrice * g.Value
		FROM dbo.Globals g
		WHERE g.Description = 'Minimum Order Size'  -- for Bitcoin (.001)

		IF (@AskPrice > 0) AND (@Funds > @MinOrderCost) AND (@MaxOpenOrders > @OpenStrategies) 
		BEGIN
			--TODO: Logic to calculate the size of the order will need to be computed more accurately
			DECLARE @StrategyType INT = 0 --DownUpStrategy
			DECLARE @pendingStatus int = -1, @readyStatus int = 0
			DECLARE @limitBuy int = 1, @limitSell int = 2

			DECLARE @StrategyIdTbl AS TABLE(StrategyId INT)
			DECLARE @StrategyId AS INT = 0
			INSERT dbo.Strategies OUTPUT INSERTED.StrategyId INTO @StrategyIdTbl VALUES (@StrategyType, @PendingStatus)
			SELECT TOP 1 @StrategyId = strategyid from @StrategyIdTbl

			DECLARE @MinimumThreshold AS decimal(18,10)
			SELECT @MinimumThreshold =  sp.Value 
			FROM dbo.StrategyProperties sp
			WHERE sp.StrategyType = @StrategyType AND sp.Description = 'Sell Increment'

			INSERT INTO dbo.DownUpStrategies 
			SELECT TOP 1 s.StrategyId, @AskPrice, @MinimumThreshold 
			FROM @StrategyIdTbl s

			DECLARE @Size AS decimal(18,10) = @Funds / (@MaxOpenOrders - @OpenStrategies) / @AskPrice 

			
			DECLARE @outputInto AS TABLE (StrategyID INT, OrderID INT)
			--Buy order
			INSERT dbo.Orders OUTPUT @StrategyId, INSERTED.OrderId INTO @outputInto
			VALUES(NULL, @AskPrice, @Size, @limitBuy, @readyStatus)			

			--Sell order	
			INSERT dbo.Orders OUTPUT @StrategyId, INSERTED.OrderId INTO @outputInto 
			VALUES (NULL, @AskPrice + @MinimumThreshold, @Size, @limitSell, @pendingStatus)
		
			--Join record
			INSERT INTO StrategyOrderJoins SELECT StrategyID, OrderID FROM @outputInto
		END
	END
END


GO