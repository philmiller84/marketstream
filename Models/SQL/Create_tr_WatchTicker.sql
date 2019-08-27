CREATE TRIGGER [dbo].[tr_WatchTicker]  ON dbo.Tickers AFTER INSERT
AS  

DECLARE	@bidPrice AS decimal(18, 2)
DECLARE	@bidSize  AS decimal(18, 2)
DECLARE	@askPrice AS decimal(18, 2)
DECLARE	@askSize  AS decimal(18, 2)
DECLARE	@Sequence AS bigint 

SELECT @bidPrice = bidPrice,
	   @bidSize  = bidSize ,
	   @askPrice = askPrice,
	   @askSize  = askSize ,
	   @Sequence = Sequence
	   FROM inserted

EXEC [dbo].[sp_add_trend] @bidPrice, @bidSize,	@askPrice,	@askSize, @Sequence 

GO