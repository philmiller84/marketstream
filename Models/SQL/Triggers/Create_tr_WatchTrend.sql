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


		IF (@MaxOpenOrders > @OpenStrategies) AND (@AskPrice > 0)
		BEGIN 		
			--Minimum order cost is price of coin * minimum size of order
			DECLARE @MinOrderSize AS decimal(18,10) = 1
			SELECT @MinOrderSize = g.Value FROM dbo.Globals g WHERE g.Description = 'Minimum Order Size'  -- for Bitcoin (.001) 
			DECLARE @MinOrderCost AS decimal(18,2) = @AskPrice * @MinOrderSize
		
			DECLARE @Size AS decimal(18,10) = @Funds / (@MaxOpenOrders - @OpenStrategies) / @AskPrice 
			SELECT @Size = ROUND(@Size, ABS(LOG10(g.value)),1)
			FROM dbo.Globals g 
			WHERE g.Description = 'Minimum Size Increment' AND g.Value > 0

			IF ( @Size >= @MinOrderSize) AND (@Funds > @MinOrderCost)
			BEGIN
				--TODO: Logic to calculate the size of the order will need to be computed more accurately
				DECLARE @StrategyType INT = 0 --DownUpStrategy
				DECLARE @pendingStatus int = -1, @readyStatus int = 0
				DECLARE @limitBuy int = 1, @limitSell int = 2
			
				DECLARE @MinimumThreshold AS decimal(18,10)
				SELECT @MinimumThreshold =  sp.Value 
				FROM dbo.StrategyProperties sp
				WHERE sp.StrategyType = @StrategyType AND sp.Description = 'Sell Increment'

				IF dbo.GetLogLevel() >= 1 EXEC dbo.sp_log_event 1, N'[tr_WatchTrend]', N'Create Strategy Entry'
				---------------------
				DECLARE @StrategyIdTbl AS TABLE(StrategyId INT)
				DECLARE @StrategyId AS INT = 0
				INSERT dbo.Strategies OUTPUT INSERTED.StrategyId INTO @StrategyIdTbl VALUES (@StrategyType, @PendingStatus)
				SELECT TOP 1 @StrategyId = strategyid from @StrategyIdTbl

				IF dbo.GetLogLevel() >= 1 EXEC dbo.sp_log_event 1, N'[tr_WatchTrend]', N'Create DownUpStrategy Entry'
				---------------------
				INSERT INTO dbo.DownUpStrategies 
				SELECT TOP 1 s.StrategyId, @AskPrice, @MinimumThreshold 
				FROM @StrategyIdTbl s

				IF dbo.GetLogLevel() >= 1 EXEC dbo.sp_log_event 1, N'[tr_WatchTrend]', N'Create Buy Order'
				---------------------
				DECLARE @outputInto AS TABLE (StrategyID INT, OrderID INT)
				INSERT dbo.Orders OUTPUT @StrategyId, INSERTED.OrderId INTO @outputInto
				VALUES(NULL, @AskPrice, @Size, @limitBuy, @readyStatus)			

				IF dbo.GetLogLevel() >= 1 EXEC dbo.sp_log_event 1, N'[tr_WatchTrend]', N'Create Sell Order'
				---------------------
				INSERT dbo.Orders OUTPUT @StrategyId, INSERTED.OrderId INTO @outputInto 
				VALUES (NULL, @AskPrice + @MinimumThreshold, @Size, @limitSell, @pendingStatus)
		
				IF dbo.GetLogLevel() >= 1 EXEC dbo.sp_log_event 1, N'[tr_WatchTrend]', N'Create Join record'
				---------------------
				INSERT INTO StrategyOrderJoins SELECT StrategyID, OrderID FROM @outputInto
			END
		END
	END
END
GO