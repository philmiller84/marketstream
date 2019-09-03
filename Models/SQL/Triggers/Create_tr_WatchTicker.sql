CREATE TRIGGER [dbo].[tr_WatchTicker]  ON dbo.Tickers AFTER INSERT
AS  

--Store in variables
DECLARE	@bidPrice AS decimal(18, 2)
DECLARE	@bidSize  AS decimal(18, 10)
DECLARE	@askPrice AS decimal(18, 2)
DECLARE	@askSize  AS decimal(18, 10)
DECLARE	@Sequence AS bigint 

SELECT @bidPrice = bidPrice,
	   @bidSize  = bidSize ,
	   @askPrice = askPrice,
	   @askSize  = askSize ,
	   @Sequence = Sequence
	   FROM inserted

--Order statuses
DECLARE @cancelledStatus AS INT = -2
DECLARE @pendingStatus AS INT = -1 
DECLARE @readyStatus AS INT = 0
DECLARE @openStatus AS INT = 1
DECLARE @filledStatus AS INT = 2

DECLARE @limitBuy INT = 1
DECLARE @limitSell INT = 2

--Pending Request type
DECLARE @fillsRequest AS INT = 8 --FIX tag 8 is Execution Report

--------------------------------------------------------------------------------------------------
--TODO: Make this controlled by exchange messages 
DECLARE @OrdersToFill TABLE (OrderId INT, Price decimal(18,2), Size decimal(18,10))
INSERT @OrdersToFill 
SELECT OrderId, Price, Size 
FROM dbo.Orders 
WHERE Status = @openStatus  
AND ((Type = @limitBuy AND @askPrice <= Price) OR (Type = @limitSell AND @bidPrice >= Price))

IF EXISTS (SELECT 1 FROM @OrdersToFill)
BEGIN
	INSERT INTO dbo.PendingRequests 
	SELECT @fillsRequest, o.ExternalId, NULL
	FROM dbo.Orders o, @OrdersToFill f
	WHERE o.OrderId = f.OrderId

	--INSERT INTO dbo.Fills SELECT OrderId, Price, Size  FROM @OrdersToFill
	IF @@ROWCOUNT > 0 AND dbo.GetLogLevel() >= 1 EXEC dbo.sp_log_event 1, N'[tr_WatchTicker]', N'Processed fills due to price movement'
END
--------------------------------------------------------------------------------------------------
IF dbo.GetLogLevel() >= 1 EXEC dbo.sp_log_event 1, N'[tr_WatchTicker]', N'Create trend entries'

EXEC [dbo].[sp_add_trend] @bidPrice, @bidSize,	@askPrice,	@askSize, @Sequence 
--------------------------------------------------------------------------------------------------
DECLARE @OrdersToUpdate TABLE (OrderId INT)
INSERT @OrdersToUpdate SELECT o.OrderId FROM dbo.Orders o WHERE o.Type = @limitBuy AND o.Status = @pendingStatus AND o.Price >= @askPrice 

IF EXISTS(SELECT 1 FROM @OrdersToUpdate)
BEGIN
	UPDATE o 
	SET Status = @readyStatus 
	FROM dbo.Orders o JOIN @OrdersToUpdate u ON o.OrderId = u.OrderId
	
	IF @@ROWCOUNT > 0 AND dbo.GetLogLevel() >= 1 EXEC dbo.sp_log_event 1, N'[tr_WatchTicker]', N'Updated buy orders for DownUpStrategy'
END

GO