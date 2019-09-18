CREATE TRIGGER [dbo].[tr_WatchSpread]  ON dbo.Spreads AFTER INSERT, UPDATE
AS  
DECLARE @SpreadId 		AS int 
DECLARE @StartSequence 	AS bigint 
DECLARE @EndSequence 	AS bigint 
DECLARE @BidPrice 		AS real 
DECLARE @AskPrice		AS real 
DECLARE @Status 		AS int 

SELECT @SpreadId 		= SpreadId,		
       @StartSequence 	= StartSequence,
       @EndSequence 	= EndSequence,
       @BidPrice 		= BidPrice,
       @AskPrice 		= AskPrice,
       @Status 		    = Status 	
FROM INSERTED	   

IF NOT EXISTS (SELECT 1 FROM DELETED) --OR EXISTS (SELECT 1 FROM INSERTED WHERE Status = 1)
BEGIN

	--if new record is not a locked Spread, check for previous entry

	--TODO: set minimum spread based on entity
	DECLARE @minimumSpread AS decimal(18,10) = 0.01
	DECLARE @isSpreadLocked AS int = 0
	SET @isSpreadLocked =  IIF(@AskPrice - @BidPrice > @minimumSpread, 0, 1)

	IF @isSpreadLocked = 0 --spread is not locked, create strategy
	BEGIN 
		EXEC [dbo].[sp_spread_strategy] @BidPrice, @AskPrice 
	END
END
GO