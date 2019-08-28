
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[V_Orders'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[V_Orders]
AS
SELECT       o.OrderId 
FROM            dbo.Orders o
'