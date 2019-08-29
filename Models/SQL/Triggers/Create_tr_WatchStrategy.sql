CREATE TRIGGER [dbo].[tr_WatchStrategy]  ON dbo.Strategies AFTER INSERT
AS  
DECLARE @StrategyID AS int 
DECLARE @Type 		AS int
DECLARE @Status 	AS int 

SELECT @StrategyId 	= StrategyId,		
       @Type 		= Type,
       @Status 		= Status 	
FROM INSERTED	   


GO