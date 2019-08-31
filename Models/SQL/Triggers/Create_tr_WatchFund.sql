CREATE TRIGGER [dbo].[tr_WatchFund]  ON dbo.Funds AFTER INSERT, UPDATE
AS  
DECLARE @Value as DECIMAL(18,10)

SELECT @Value = VALUE
FROM INSERTED


declare @sequence bigint
select top 1 @sequence = sequence from tickers order by sequence desc
declare @seqstr varchar(20) = CONVERT(varchar(20), @sequence)

IF @Value < 0
	RAISERROR(N'Funds dropped below 0 at sequence %s',
				18, --Severity
				1, 
				@seqstr
				);
GO