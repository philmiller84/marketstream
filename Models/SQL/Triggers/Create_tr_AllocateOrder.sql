CREATE TRIGGER [dbo].[tr_AllocateOrder] ON dbo.Orders INSTEAD OF UPDATE
AS  
DECLARE @OrderID AS int 
DECLARE @Price		AS decimal(18,2)
DECLARE @Size 		AS decimal(18,10)
DECLARE @Type 		AS int
DECLARE @Status 	AS int 

SELECT @OrderID 	= OrderId,
       @Price 		= Price,
       @Size 		= Size,
       @Type 		= Type,
       @Status 		= Status 	
FROM INSERTED

DECLARE @cancelledStatus AS INT = -2
DECLARE @pendingStatus AS INT = -1 
DECLARE @readyStatus AS INT = 0
DECLARE @filledStatus AS INT = 2

DECLARE @limitBuy INT = 1
DECLARE @limitSell INT = 2

DECLARE @generalUseFunds INT = 1

DECLARE @PreviousStatus AS int
SELECT @PreviousStatus = Status FROM DELETED

--Try to move the order to the ready state
IF @Type = @limitBuy AND @PreviousStatus <> @Status AND @Status = @readyStatus
BEGIN 
	IF NOT EXISTS (SELECT 1 FROM dbo.Funds WHERE AllocationType = @generalUseFunds AND Value - (@Size * @Price) >= 0)
		SET @Status  = @pendingStatus --Not enough funds, send order back to pending status
	ELSE
		UPDATE dbo.Funds 
		SET Value -= (@Size * @Price) 
		WHERE AllocationType = @generalUseFunds --allocate funds
END
ELSE IF @Type = @limitBuy AND @PreviousStatus <> @Status AND @Status = @cancelledStatus
BEGIN
	--TODO: Check for partial fills
	UPDATE dbo.Funds 
	SET Value += (@Size * @Price) 
	WHERE AllocationType = @generalUseFunds	
END
ELSE IF @Type = @limitSell AND @PreviousStatus <> @Status AND @Status = @filledStatus
BEGIN
	UPDATE dbo.Funds 
	SET Value += (@Size * @Price) 
	WHERE AllocationType = @generalUseFunds	
END

IF @PreviousStatus <> @Status AND @Status = @filledStatus --completed order
BEGIN
	--Adjust funds to remove fees
	IF dbo.GetLogLevel() >= 1 EXEC dbo.sp_log_event 1, N'[tr_AllocateOrder]', N'Adjust funds to remove fees'
	UPDATE dbo.Funds
	SET Value -= Fee
	FROM dbo.Fills f JOIN dbo.Orders o ON f.ExternalOrderId = o.ExternalId
	WHERE o.OrderId = @OrderID

	--Adjust position
	IF dbo.GetLogLevel() >= 1 EXEC dbo.sp_log_event 1, N'[tr_AllocateOrder]', N'Update Position'
	IF NOT EXISTS (SELECT 1 FROM dbo.Positions) INSERT dbo.Positions VALUES(0)
	UPDATE dbo.Positions SET Size = CASE WHEN @Type = @limitBuy THEN Size + @Size WHEN @Type = @limitSell THEN Size - @Size ELSE Size END
END

UPDATE o
SET o.ExternalId = ins.ExternalId,
	o.Price = ins.Price,
	o.Size = ins.Size,
	o.Type = ins.Type,
	o.Status = @Status
FROM [dbo].[Orders] o 
INNER JOIN INSERTED AS ins
ON o.OrderId = ins.OrderId 

GO