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
	IF EXISTS (SELECT 1 FROM dbo.Funds WHERE AllocationType = @generalUseFunds AND Value - (@Size * @Price) >= 0)
		UPDATE dbo.Funds SET Value = Value - (@Size * @Price) WHERE AllocationType = @generalUseFunds --allocate funds
	ELSE 
		SET @Status  = @pendingStatus --Not enough funds, send order back to pending status
END
ELSE IF @Type = @limitBuy AND @PreviousStatus <> @Status AND @Status = @cancelledStatus
	UPDATE dbo.Funds SET Value = Value + (@Size * @Price) WHERE AllocationType = @generalUseFunds	
ELSE IF @Type = @limitSell AND @PreviousStatus <> @Status AND @Status = @filledStatus
	UPDATE dbo.Funds SET Value = Value + (@Size * @Price) WHERE AllocationType = @generalUseFunds	

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