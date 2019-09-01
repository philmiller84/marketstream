CREATE TRIGGER [dbo].[tr_WatchFills]  ON dbo.Fills AFTER INSERT
AS  
DECLARE @FillId AS int 
DECLARE @Price AS decimal(18,2)
DECLARE @Size AS decimal(18,10)
DECLARE @OrderId AS int 

SELECT @FillId 	= FillId,		
	   @Price	= Price,
       @Size 	= Size,
       @OrderId = OrderId
FROM INSERTED	   

UPDATE dbo.Orders SET Status = 2 WHERE @orderId = OrderId
IF @@ROWCOUNT > 0 AND dbo.GetLogLevel() >= 1 EXEC dbo.sp_log_event 1, N'[tr_WatchFills]', N'Set order filled. TODO: Will have to change for partial fills!!!!  **********'


GO