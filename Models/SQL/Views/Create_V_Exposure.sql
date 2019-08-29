
CREATE VIEW [dbo].[V_Exposure] AS
WITH CurrentPrices(BidPrice, AskPrice) AS
(
SELECT TOP 1 t.BidPrice, t.AskPrice
FROM dbo.Tickers t
ORDER BY t.Sequence DESC
)
SELECT	NEWID() AS Id, (p.Size * cp.BidPrice) AS Value, p.Size AS Size
FROM	dbo.Positions p, CurrentPrices cp 
