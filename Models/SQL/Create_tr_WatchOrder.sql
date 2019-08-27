CREATE TRIGGER [dbo].[tr_WatchOrder] ON dbo.Orders AFTER INSERT
AS  
DECLARE @OrderID AS int 
DECLARE @Type 		AS int
DECLARE @Status 	AS int 

SELECT @OrderID 	= OrderId,
       @Type 		= Type,
       @Status 		= Status 	
FROM INSERTED	   




GO