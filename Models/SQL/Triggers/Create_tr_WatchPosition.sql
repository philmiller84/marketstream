CREATE TRIGGER [dbo].[tr_WatchPosition]  ON dbo.Positions AFTER INSERT, UPDATE
AS  
DECLARE @Value AS Decimal(18,10)

GO