CREATE TRIGGER [dbo].[tr_WatchFills]  ON dbo.Fills AFTER INSERT
AS  
DECLARE @FillId AS int 
DECLARE @Price AS decimal(18,2)
DECLARE @Size AS decimal(18,10)
DECLARE @ExternalOrderId AS varchar(255) 



DECLARE @cancelledStatus AS INT = -2
DECLARE @pendingStatus AS INT = -1 
DECLARE @readyStatus AS INT = 0
DECLARE @filledStatus AS INT = 2


SELECT @FillId 	= FillId,		
	   @Price	= Price,
       @Size 	= Size,
       @ExternalOrderId = ExternalOrderId
FROM INSERTED	   

UPDATE dbo.Orders SET Status = @filledStatus WHERE @ExternalOrderId = ExternalId
IF @@ROWCOUNT > 0 AND dbo.GetLogLevel() >= 1 EXEC dbo.sp_log_event 1, N'[tr_WatchFills]', N'Set order filled. TODO: Will have to change for partial fills!!!!  **********'


GO