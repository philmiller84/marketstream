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

--if new record has upward trend, check for previous entry
IF NOT EXISTS (SELECT 1 FROM DELETED) --OR EXISTS (SELECT 1 FROM INSERTED WHERE Status = 1)
BEGIN
	--new record, not an update
	IF @Type = 1 --current is a upward trend, check previous
	DECLARE @PreviousTrendType AS int = 0
	--DECLARE @PreviousTrendID AS int = 0
	SELECT @PreviousTrendType = CASE WHEN TrendId = @TrendId THEN  LAG(Type) OVER (ORDER BY TrendId) ELSE @PreviousTrendType END
	--	@PreviousTrendID = CASE WHEN TrendId = @TrendId THEN  LAG(TrendId) OVER (ORDER BY TrendId) ELSE @PreviousTrendID END 
	FROM dbo.Trends
	 
	IF @PreviousTrendType = -1 --previous was an downward trend, create pending strategy
	BEGIN --type 0 is the simple spread, status -1 is pending	
		INSERT INTO dbo.Strategies VALUES (0,-1) --, @TrendId, @PreviousTrendId)
	END
END

GO