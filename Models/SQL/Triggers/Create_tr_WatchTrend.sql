CREATE TRIGGER [dbo].[tr_WatchTrend]  ON dbo.Trends AFTER INSERT, UPDATE
AS  
DECLARE @TrendId 		AS int 
DECLARE @StartSequence 	AS bigint 
DECLARE @EndSequence 	AS bigint 
DECLARE @StartBidPrice 	AS real 
DECLARE @EndBidPrice 	AS real 
DECLARE @StartAskPrice 	AS real 
DECLARE @EndAskPrice 	AS real 
DECLARE @Type 			AS int
DECLARE @Status 		AS int 

SELECT @TrendId 		= TrendId,		
       @StartSequence 	= StartSequence 	,
       @EndSequence 	= EndSequence 	,
       @StartBidPrice 	= StartBidPrice 	,
       @EndBidPrice 	= EndBidPrice 	,
       @StartAskPrice 	= StartAskPrice 	,
       @EndAskPrice 	= EndAskPrice 	,
       @Type 			= Type 			,
       @Status 		    = Status 	
FROM INSERTED	   

IF NOT EXISTS (SELECT 1 FROM DELETED) --OR EXISTS (SELECT 1 FROM INSERTED WHERE Status = 1)
BEGIN

	--if new record has upward trend, check for previous entry
	IF @Type = 1 --new record is a upward trend, check previous 
	BEGIN DECLARE @PreviousTrendType AS int = 0
		SELECT @PreviousTrendType = CASE WHEN TrendId = @TrendId THEN  LAG(Type) OVER (ORDER BY TrendId) ELSE @PreviousTrendType END
		FROM dbo.Trends
	END
	----if new record has downward trend, enter sell order for down-up-strategy
	--ELSE IF @Type = -1
	--BEGIN
	--	--TODO: Check for profit here
	--	--TODO: Refactor this to centralized control of strategy. NOT SURE HOW YET!!!
	--	UPDATE dbo.Orders 
	--	SET Status = 0 WHERE Status = -1 AND Type = 2
	--	AND Price <= @StartBidPrice
	--END

	IF @PreviousTrendType = -1 --previous was an downward trend, create pending strategy
	BEGIN --type 0 is the down up, status -1 is pending	
		EXEC [dbo].[sp_down_up_strategy]  
	END
END
GO