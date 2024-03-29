CREATE procedure [dbo].[sp_down_up_strategy]  (
	@BidPrice AS decimal(18,2),
	@AskPrice AS decimal(18,2)
)
AS
BEGIN
    SET NOCOUNT ON

    /*
    ** Declarations.
    */
    DECLARE @retcode int=0
   
	DECLARE @Funds AS decimal(18,10)=0
	SELECT @Funds = Value FROM dbo.Funds WHERE AllocationType = 1 --allocation type is funds for use

	DECLARE @cancelledStatus AS INT = -2
	DECLARE @pendingStatus AS INT = -1 
	DECLARE @readyStatus AS INT = 0
	DECLARE @openStatus AS INT = 1
	DECLARE @filledStatus AS INT = 2

	--Get open strategies
	DECLARE @OpenStrategies AS int = 0
	SELECT @OpenStrategies = COUNT(*) FROM dbo.Strategies s WHERE s.Status NOT IN (@cancelledStatus, @filledStatus)

	DECLARE @DownUpStrategy INT = 0 --DownUpStrategy

	DECLARE @MaxOpenOrders AS int
	SELECT @MaxOpenOrders = sp.Value FROM dbo.StrategyProperties sp WHERE sp.StrategyType = @DownUpStrategy AND sp.Description = 'Max Open Orders'
			
	IF(@OpenStrategies >= @MaxOpenOrders) OR @AskPrice <= 0
		return @retcode

	DECLARE @MinimumThreshold AS decimal(18,10)
	SELECT @MinimumThreshold =  sp.Value FROM dbo.StrategyProperties sp WHERE sp.StrategyType = @DownUpStrategy AND sp.Description = 'Sell Increment'

	DECLARE @AvgBidPrice AS decimal(18,2)
	SELECT @AvgBidPrice =  a.Value FROM dbo.Analysis a WHERE a.Description = 'Moving Average Bid Price'

	DECLARE @TradingHaltPercentage AS decimal(18,2)
	SELECT @TradingHaltPercentage = sp.Value FROM dbo.StrategyProperties sp WHERE sp.StrategyType = @DownUpStrategy AND sp.Description = 'Trade Halt Percentage'

	DECLARE @PercentOpenOfMax AS decimal(18,2)
	SET @PercentOpenOfMax = CONVERT(DECIMAL(18,2),@OpenStrategies) / @MaxOpenOrders

	--Prevent strategy creation if there is a downward trend and price does not have upward pressure
	DECLARE @tradeHaltIncrement DECIMAL(18,10) = 1.00/@MaxOpenOrders 
	IF(@BidPrice + @MinimumThreshold > @AvgBidPrice) AND (@PercentOpenOfMax >= @TradingHaltPercentage)
	BEGIN
		UPDATE sp SET sp.Value = 1 FROM dbo.StrategyProperties sp WHERE sp.StrategyType = @DownUpStrategy AND sp.Description = 'Trade Halt Enabled'
		UPDATE sp SET sp.Value = IIF(sp.Value - @tradeHaltIncrement <= 0, @tradeHaltIncrement, sp.Value - @tradeHaltIncrement) FROM dbo.StrategyProperties sp WHERE sp.StrategyType = @DownUpStrategy AND sp.Description = 'Trade Halt Percentage'
		return @retCode
	END
	ELSE IF (@PercentOpenOfMax < @TradingHaltPercentage)
		UPDATE sp SET sp.Value = 0 FROM dbo.StrategyProperties sp WHERE sp.StrategyType = @DownUpStrategy AND sp.Description = 'Trade Halt Enabled'

	--If trade is currently halted, but we can enter due to upward pressure, reduce the percentage, and continue
	IF (@BidPrice + @MinimumThreshold <= @AvgBidPrice) AND EXISTS(SELECT 1 FROM dbo.StrategyProperties sp WHERE sp.StrategyType = @DownUpStrategy AND sp.Description = 'Trade Halt Enabled' AND sp.Value = 1)
		UPDATE sp SET sp.Value = IIF(sp.Value + @tradeHaltIncrement >= 1, 1, sp.Value + @tradeHaltIncrement) FROM dbo.StrategyProperties sp WHERE sp.StrategyType = @DownUpStrategy AND sp.Description = 'Trade Halt Percentage'

	--Check that the sell increment will lead to profit vs double the taker fees
	DECLARE @SellIncrement AS DECIMAL(18,2)
	SELECT @SellIncrement = sp.Value FROM dbo.StrategyProperties sp WHERE sp.StrategyType = @DownUpStrategy AND sp.Description = 'Sell Increment' 

	DECLARE @BuyTargetPrice AS DECIMAL(18,2) = @AskPrice
	DECLARE @expectedProfitPercentage AS DECIMAL(18,4) = @SellIncrement / (@BuyTargetPrice + @SellIncrement)

	DECLARE @TakerFee AS DECIMAL(18,4)
	SELECT @TakerFee = 1.000 * Value FROM dbo.Fees WHERE Description = 'Taker Fee - Percentage'

	IF @expectedProfitPercentage < (2.000 * @TakerFee) --spread not large enough for double taker fee, need to be market maker 
	BEGIN
		IF @expectedProfitPercentage <= @TakerFee --TODO: become market maker on both sides of strategy
			return @retcode
		ELSE -- @expectedProfitPercentage > @TakerFee  ==== Market maker at 1 cent less than ask for the limit buy order, BETTER BE QUICK!!!
			SET @BuyTargetPrice -= 0.01
	END

	--Minimum order cost is price of coin * minimum size of order
	DECLARE @MinOrderSize AS decimal(18,14) = 1
	SELECT @MinOrderSize = g.Value FROM dbo.Globals g WHERE g.Description = 'Minimum Order Size'  -- for Bitcoin (.001) 
	DECLARE @MinOrderCost AS decimal(18,2) = @BuyTargetPrice * @MinOrderSize
	
	DECLARE @Size AS decimal(18,14) = @Funds / CONVERT(DECIMAL(18,2),(@MaxOpenOrders - @OpenStrategies)) / @BuyTargetPrice 
	SELECT @Size = ROUND(@Size, ABS(LOG10(g.value)),1)
	FROM dbo.Globals g 
	WHERE g.Description = 'Minimum Size Increment' AND g.Value > 0

	IF ( @Size < @MinOrderSize) OR (@Funds <= @MinOrderCost)
		return @retcode

	--TODO: Logic to calculate the size of the order will need to be computed more accurately
	DECLARE @StrategyType INT = 0 --DownUpStrategy
	DECLARE @limitBuy int = 1, @limitSell int = 2
	
	IF dbo.GetLogLevel() >= 1 EXEC dbo.sp_log_event 1, N'[tr_WatchTrend]', N'Create Strategy Entry'
	DECLARE @StrategyIdTbl AS TABLE(StrategyId INT)
	DECLARE @StrategyId AS INT = 0
	INSERT dbo.Strategies OUTPUT INSERTED.StrategyId INTO @StrategyIdTbl VALUES (@StrategyType, @PendingStatus)
	SELECT TOP 1 @StrategyId = strategyid from @StrategyIdTbl

	IF dbo.GetLogLevel() >= 1 EXEC dbo.sp_log_event 1, N'[tr_WatchTrend]', N'Create DownUpStrategy Entry'
	INSERT INTO dbo.DownUpStrategies 
	SELECT TOP 1 s.StrategyId, @BuyTargetPrice, @MinimumThreshold 
	FROM @StrategyIdTbl s

	IF dbo.GetLogLevel() >= 1 EXEC dbo.sp_log_event 1, N'[tr_WatchTrend]', N'Create Buy Order'
	DECLARE @outputInto AS TABLE (StrategyID INT, OrderID INT)
	INSERT dbo.Orders OUTPUT @StrategyId, INSERTED.OrderId INTO @outputInto
	VALUES(NULL, @BuyTargetPrice, @Size, @limitBuy, @pendingStatus)			

	IF dbo.GetLogLevel() >= 1 EXEC dbo.sp_log_event 1, N'[tr_WatchTrend]', N'Create Sell Order'
	INSERT dbo.Orders OUTPUT @StrategyId, INSERTED.OrderId INTO @outputInto 
	VALUES (NULL, @BuyTargetPrice + @MinimumThreshold, @Size, @limitSell, @pendingStatus)

	IF dbo.GetLogLevel() >= 1 EXEC dbo.sp_log_event 1, N'[tr_WatchTrend]', N'Create Join record'
	INSERT INTO StrategyOrderJoins SELECT StrategyID, OrderID FROM @outputInto

	return @retcode
END