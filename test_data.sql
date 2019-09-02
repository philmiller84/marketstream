delete from tickers
delete from trends
delete from StrategyOrderJoins
delete from DownUpStrategies
delete from orders
delete from fills
delete from strategies
--select * from funds
update funds set value = 200
--select * from Positions
update positions set size = 0
--select top 1 * from tickers order by sequence desc
--update dbo.analysis set value = 0 where description like 'moving average%count'
delete from dbo.Analysis

update StrategyProperties set value = .15 where propertyid = 1 --sell increment
update StrategyProperties set value = .01 where propertyid = 2 --downturn threshold
update StrategyProperties set value = 0 where propertyid = 3
update StrategyProperties set value = .10 where propertyid = 4
update StrategyProperties set value = 10 where propertyid = 5 -- max open orders

INSERT INTO Tickers Values(	1	,	10000	,	1	,	10020	,	1	)
INSERT INTO Tickers Values(	2	,	10001	,	1	,	10019	,	1	)
INSERT  INTO Tickers Values(	3	,	10002	,	1	,	10018	,	1	)
INSERT INTO Tickers Values(	4	,	10003	,	1	,	10017	,	1	)
INSERT INTO Tickers Values(	5	,	10004	,	1	,	10016	,	1	)
INSERT INTO Tickers Values(	6	,	10005	,	1	,	10015	,	1	)
INSERT INTO Tickers Values(	7	,	10006	,	1	,	10014	,	1	)
INSERT INTO Tickers Values(	8	,	10007	,	1	,	10013	,	1	)
INSERT INTO Tickers Values(	9	,	10008	,	1	,	10012	,	1	)
INSERT INTO Tickers Values(	10	,	10009	,	1	,	10011	,	1	)
INSERT INTO Tickers Values(	11	,	10010	,	1	,	10010	,	1	)
INSERT INTO Tickers Values(	12	,	10009	,	1	,	10011	,	1	)
INSERT INTO Tickers Values(	13	,	10008	,	1	,	10012	,	1	)
INSERT INTO Tickers Values(	14	,	10007	,	1	,	10013	,	1	)
INSERT INTO Tickers Values(	15	,	10006	,	1	,	10014	,	1	)
INSERT INTO Tickers Values(	16	,	10005	,	1	,	10015	,	1	)
INSERT INTO Tickers Values(	17	,	10004	,	1	,	10016	,	1	)
INSERT INTO Tickers Values(	18	,	10003	,	1	,	10017	,	1	)
INSERT INTO Tickers Values(	19	,	10002	,	1	,	10018	,	1	)
INSERT INTO Tickers Values(	20	,	10001	,	1	,	10019	,	1	)
INSERT INTO Tickers Values(	21	,	10000	,	1	,	10020	,	1	)
INSERT INTO Tickers Values(	22	,	9999	,	1	,	10021	,	1	)
INSERT INTO Tickers Values(	23	,	10000	,	1	,	10020	,	1	)
INSERT INTO Tickers Values(	24	,	10001	,	1	,	10019	,	1	)
INSERT INTO Tickers Values(	25	,	10002	,	1	,	10018	,	1	)
INSERT INTO Tickers Values(	26	,	10003	,	1	,	10017	,	1	)
INSERT INTO Tickers Values(	27	,	10004	,	1	,	10016	,	1	)
INSERT INTO Tickers Values(	28	,	10005	,	1	,	10015	,	1	)
INSERT INTO Tickers Values(	29	,	10006	,	1	,	10014	,	1	)
INSERT INTO Tickers Values(	30	,	10007	,	1	,	10013	,	1	)
INSERT INTO Tickers Values(	31	,	10008	,	1	,	10012	,	1	)
INSERT INTO Tickers Values(	32	,	10009	,	1	,	10011	,	1	)
INSERT INTO Tickers Values(	33	,	10010	,	1	,	10010	,	1	)


select * from strategyproperties

select * from orders
select * from trends
select * from analysis