delete from tickers
delete from trends
delete from StrategyOrderJoins
delete from DownUpStrategies
delete from orders
delete from pendingrequests
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
update StrategyProperties set value = .50 where propertyid = 4 -- trading halt percentage
update StrategyProperties set value = 10 where propertyid = 5 -- max open orders





INSERT INTO Tickers VALUES(10717221829,10193.01,0.54,10195.89,0.73       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717222028,10193.01,0.54,10193.02,32.54      )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717222372,10193.02,0.29,10195.31,0.06       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717222430,10193.01,0.54,10195.86,0.05       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717222489,10193.01,0.54,10193.02,0.01       )
WAITFOR DELAY '00:00:00.025'
--INSERT INTO Tickers VALUES(10717223354,10197.17,0.01,10197.18,2.71       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717223691,10193.01,0.54,10197.09,2.25       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717224225,10193.01,0.54,10196.67,2.17       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717224472,10193.01,0.54,10196.41,1.93       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717224633,10193.01,0.48,10196.24,0.8        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717224994,10193.01,0.48,10193.24,0.85       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717225145,10193.01,0.48,10193.2,0.45        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717225536,10195.26,0.89,10197.15,0.71       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717225786,10197.11,0.08,10198.84,0.81       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717226603,10193.01,0.48,10193.91,0.85       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717226825,10193.01,0.48,10193.88,0.85       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717226942,10193.01,0.48,10193.8,0.1         )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717227232,10193.42,0.35,10193.85,0.93       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717227385,10193.42,0.35,10193.84,2.22       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717227655,10193.44,2.23,10193.84,0.22       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717227776,10193.83,2.01,10193.84,0.22       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717228180,10195.43,1.5,10196.97,0.55        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717228427,10195.88,3.21,10198.95,0.02       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717228850,10193.83,0,10197.91,1.15          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717229408,10193.83,0.17,10197.39,6.57       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717229930,10193.01,0.53,10196.63,1.28       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717230070,10193.02,0.39,10196.54,0.56       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717230448,10194.89,0.33,10196.69,0.22       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717230905,10196.42,0.33,10199.24,0.71       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717231041,10196.42,0.08,10199.19,1.92       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717231348,10194.91,0.26,10198.68,2          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717231514,10194.91,0.26,10196.51,5.46       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717231640,10194.9,0.11,10196.44,1.5         )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717231946,10194.9,0.11,10196.28,0.94        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717232248,10194.9,2.36,10196.14,4.84        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717232308,10194.92,0.3,10196.51,0.99        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717232623,10196,0.53,10196.5,6.47           )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717232813,10196.02,0.26,10196.5,4.47        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717232973,10196.03,2.28,10196.5,5.22        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717233065,10196.04,0.54,10196.5,0.21        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717233230,10196.49,2.55,10196.5,0.21        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717233541,10196.69,0.75,10199.02,0.54       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717233837,10196.91,4.73,10198.99,0.93       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717234200,10198.98,0.53,10198.99,1.12       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717234824,10199.32,0.1,10200.99,0.54        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717235087,10199.68,2,10200.99,0.76          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717235510,10200.14,0.01,10200.99,0.25       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717235720,10200.14,0.51,10200.87,5.18       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717236505,10200.14,0.51,10200.15,37.09      )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717237428,10195.92,0.02,10199.18,2.25       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717238236,10196,0.02,10198.46,1.77          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717238757,10196,0.02,10196.43,0.27          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717239266,10195.92,0,10195.93,17.67         )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717239957,10190.91,0.05,10195.12,1.5        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717240812,10190.91,0.05,10191.28,4.25       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717241121,10190.91,0.02,10191.27,5          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717241247,10190.92,0.22,10190.93,0.01       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717242556,10191.28,1.56,10195.92,2.22       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717242892,10195.07,0.08,10195.72,0.05       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717243002,10195.08,0.22,10195.51,0.54       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717243250,10194.1,0.46,10195.51,0.54        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717243309,10194.11,0.22,10195.51,0.54       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717243377,10194.11,0.07,10195.5,2           )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717243805,10194.08,0.11,10194.09,23.21      )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717244984,10190.92,2.22,10194.06,1.71       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717245140,10190.91,0,10193.94,0.46          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717245495,10190.92,1.95,10193.2,0.69        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717245950,10190.01,0.22,10192.68,4.2        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717246442,10190.01,0.22,10192.31,1.43       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717246791,10190.01,0.22,10192.03,0.3        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717246902,10190.01,0.32,10191.96,6.2        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717247143,10190.01,0.32,10191.25,0.01       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717247328,10190.01,0.32,10191.1,2           )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717247413,10190.01,0.29,10191.02,4.2        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717247535,10190.01,0.31,10190.95,6.97       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717247698,10190.01,0.31,10190.02,34.08      )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717248823,10179.21,0.02,10183.09,1.7        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717249501,10179.22,1.58,10179.48,4.55       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717249854,10179.21,0,10179.22,5.88          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717250582,10178.23,0.54,10179.21,0.35       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717250855,10177.25,0.1,10178.19,1.56        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717251091,10177.25,0.1,10178.09,5.12        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717251373,10178.08,0.35,10178.09,0.9        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717251510,10178.2,2.97,10178.21,3.83        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717278172,10165.62,2.25,10166.9,0.54        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717278326,10165.68,3,10166.9,0.54           )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717278372,10165.68,3,10166.93,0.54          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717278517,10165.7,3,10167.56,0.23           )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717278799,10167.3,1.26,10168.84,0.92        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717278990,10167.51,0.01,10169.42,0.55       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717279182,10167.51,0.01,10169.39,1.25       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717279659,10166.57,0.01,10167.51,2.14       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717279891,10166.57,0.01,10167.15,1.67       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717279993,10166.57,0.01,10167.1,1.66        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717280409,10166.57,0.01,10166.73,5.73       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717280461,10166.57,0.01,10166.58,4.53       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717280733,10166.67,9.23,10166.68,0          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717281101,10167.23,32.4,10167.24,0.55       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717281233,10167.51,32.36,10167.52,0.61      )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717281654,10167.62,1.72,10168.63,0.32       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717282215,10168.83,2.23,10169.19,0.55       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717282409,10169.71,12.1,10169.72,0.55       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717282638,10169.99,29.52,10170,1.25         )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717284729,10171.87,2,10173.91,0.55          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717285245,10172.15,0.75,10173.32,0.55       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717285779,10172.35,0.75,10173.47,0.48       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717286093,10172.56,2.25,10173.47,0.48       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717286285,10173.07,2.47,10174.31,0.48       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717286401,10174.04,1.59,10174.35,0.46       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717286540,10174.34,1.61,10174.35,0.32       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717287754,10170.03,0.44,10170.04,5.01       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717288045,10170,1.81,10170.01,8.25          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717289801,10163.75,2.25,10169.31,0.46       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717290371,10165.27,0.23,10166.59,5          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717290447,10163.01,2.11,10166.58,4.59       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717290595,10163.03,2.25,10166.6,2           )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717290631,10163.03,2.25,10167.59,0.2        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717290753,10163.05,1.5,10167.55,2           )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717291315,10163.07,2.25,10167.24,1.02       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717292055,10163.07,2.25,10166.86,5.2        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717292497,10163.07,2.25,10166.58,4.31       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717293057,10163.01,0.75,10166.14,0.29       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717293423,10163.01,2.25,10163.12,5.01       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717293643,10163,0.9,10163.01,7.72           )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717294743,10163.19,3,10165.66,0.33          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717295278,10167.7,0.01,10169.44,6.62        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717295782,10167.7,0.01,10169.16,6.17        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717295974,10167.7,0.01,10169.07,0.63        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717296440,10163.48,3,10168.84,0.54          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717296770,10163.88,3,10168.8,0.46           )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717297111,10164.08,2.99,10168.76,1.19       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717297351,10166.84,0.01,10167.69,5          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717297616,10165.82,2.25,10167.71,0          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717297707,10165.86,2.25,10167.71,0          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717298037,10166.12,3,10169.96,0.54          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717298133,10166.14,1.5,10168.68,5           )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717298354,10166.14,1.5,10168.36,0           )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717298430,10166.14,1.5,10168.05,0           )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717298764,10166.21,3.01,10167.74,0          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717298873,10166.25,3.01,10167.74,5.3        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717299112,10168.98,0.02,10169.97,0.35       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717299619,10168.98,0.02,10169.75,4.06       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717299822,10168.98,0.01,10169.72,5.83       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717300055,10167.18,2.26,10170.01,7.99       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717300256,10167.24,0.76,10169.93,0.22       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717300565,10167.24,0.76,10169.79,5.8        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717301150,10166.18,0.06,10167.03,5.53       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717301293,10166.18,0.06,10167.01,0.5        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717301713,10169.89,0.01,10169.9,11.95       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717302329,10166.18,0.06,10166.19,8.7        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717303972,10165.14,0.01,10165.73,0.6        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717312550,10169.82,34.5,10169.83,0.21       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717312703,10169.91,1.5,10171.7,0            )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717312897,10169.97,3,10171.7,0              )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717313001,10170.22,0.01,10171.67,0.64       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717313169,10170.26,1.93,10174.94,0.74       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717313900,10168.82,0.09,10169.82,1.95       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717314636,10167,0.69,10167.01,13.86         )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717317958,10166,0.22,10166.86,2.01          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717318847,10166,0.22,10166.21,0.64          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717319036,10166,0.13,10166.01,14.8          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717319373,10164,0.19,10165.81,0.7           )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717319967,10163.99,2.38,10165.41,3.64       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717320495,10163.99,2.38,10165.08,5.75       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717320692,10164.13,0.19,10164.93,5.74       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717321111,10164.28,2.64,10165.31,0.79       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717321422,10165.3,1.77,10165.31,0.79        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717321858,10164.84,1.5,10165.31,0.79        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717322243,10165.47,1.5,10167.1,0.48         )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717323090,10165.88,0.94,10167.06,0.71       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717323667,10165.88,0.19,10166.84,4.33       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717323748,10165.88,0.19,10166.79,0.23       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717324491,10165.88,0.2,10166.4,6.05         )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717324525,10166,1.43,10166.4,6.05           )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717324697,10166,1.37,10166.38,3.6           )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717324793,10166,1.37,10166.37,5.42          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717324942,10166,1.37,10166.36,3.65          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717325353,10166,1.37,10166.01,17.87         )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717326748,10165.01,0.02,10165.52,0.6        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717327291,10165.01,0.01,10165.02,28.96      )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717328382,10161,0.07,10162.07,5             )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717328973,10161,0.02,10161.7,5.93           )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717329229,10161,0.02,10161.01,6.16          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717329484,10160,0,10160.49,6.26             )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717330502,10158.14,0.09,10158.15,7.44       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717332896,10158.46,3,10160,0.48             )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717333847,10159.99,33.32,10160,0.48         )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717337503,10159.33,0.34,10159.99,1.17       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717337816,10159.99,34.14,10160,0.61         )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717338707,10160.7,3,10165.33,0.61           )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717339212,10163.31,0.75,10165.33,0.61       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717339389,10163.35,1.2,10165.32,0.14        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717339792,10163.5,3,10165.32,0.09           )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717340225,10163.73,1.5,10165.32,0.09        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717340786,10164.02,0.75,10165.33,0.61       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717345298,10170.91,1.35,10170.92,14.77      )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717345532,10170.9,2.38,10170.91,26.8        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717346914,10169.91,1.9,10170.41,0.92        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717347220,10169.91,1.67,10169.92,29.71      )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717348331,10169.91,0.13,10170.64,0.46       )
INSERT INTO Tickers VALUES(10717348873,10169.91,0.12,10169.92,30.64      )
INSERT INTO Tickers VALUES(10717349529,10164.07,3.01,10169.72,1.6        )
INSERT INTO Tickers VALUES(10717349741,10164.09,3.01,10169.54,1.53       )
INSERT INTO Tickers VALUES(10717349886,10164.09,3.01,10169.52,0.85       )
INSERT INTO Tickers VALUES(10717350272,10166.89,0.76,10169.52,0.64       )
INSERT INTO Tickers VALUES(10717350351,10166.89,0.76,10169.51,0.06       )
INSERT INTO Tickers VALUES(10717350547,10166.91,1.51,10169.52,0.64       )
INSERT INTO Tickers VALUES(10717350619,10166.91,0.62,10169.51,0.62       )
INSERT INTO Tickers VALUES(10717350693,10166.9,2.01,10169.51,0.93        )
INSERT INTO Tickers VALUES(10717350901,10166.91,1.36,10169.51,0.75       )
INSERT INTO Tickers VALUES(10717351127,10167.97,1.99,10169.53,0.48       )
INSERT INTO Tickers VALUES(10717351330,10167.99,4.23,10169.53,0.48       )
INSERT INTO Tickers VALUES(10717351728,10164.07,0,10169.44,0.87          )
INSERT INTO Tickers VALUES(10717352132,10164.09,2.34,10169.24,1.21       )
INSERT INTO Tickers VALUES(10717352471,10164.11,2.25,10169.04,0.31       )
INSERT INTO Tickers VALUES(10717352525,10164.13,2.25,10169.04,1.06       )
INSERT INTO Tickers VALUES(10717352645,10164.2,2.25,10169.04,1.05        )
INSERT INTO Tickers VALUES(10717352690,10164.22,2.51,10169.04,1.05       )
INSERT INTO Tickers VALUES(10717352924,10164.33,2.51,10169.04,0.99       )
INSERT INTO Tickers VALUES(10717353442,10167.44,0.75,10169.48,1.7        )
INSERT INTO Tickers VALUES(10717353622,10168.47,1.01,10169.53,0.48       )
INSERT INTO Tickers VALUES(10717353796,10168.48,0,10169.84,2             )
INSERT INTO Tickers VALUES(10717354246,10166.02,2.51,10169.77,1.08       )
INSERT INTO Tickers VALUES(10717354610,10166.21,1.76,10167.96,0          )
INSERT INTO Tickers VALUES(10717354852,10166.26,0.75,10169.75,0.32       )
INSERT INTO Tickers VALUES(10717354923,10166.27,1.76,10169.73,0.31       )
INSERT INTO Tickers VALUES(10717355143,10166.28,0.76,10169.62,4.05       )
INSERT INTO Tickers VALUES(10717355817,10166.28,0.24,10169.12,0.01       )
INSERT INTO Tickers VALUES(10717356160,10166.28,0.23,10168.71,1.47       )
INSERT INTO Tickers VALUES(10717356504,10166.28,0.23,10168.48,4.14       )
INSERT INTO Tickers VALUES(10717357135,10166.28,0.23,10166.29,20.06      )
INSERT INTO Tickers VALUES(10717357675,10165.28,0.05,10165.95,8.85       )
INSERT INTO Tickers VALUES(10717357916,10165.28,0.05,10165.29,21.52      )
INSERT INTO Tickers VALUES(10717359038,10158.31,2.14,10164.51,2.45       )
INSERT INTO Tickers VALUES(10717359935,10158.31,0.75,10161.18,2          )
INSERT INTO Tickers VALUES(10717360190,10158.26,1.46,10161.05,5.93       )
INSERT INTO Tickers VALUES(10717360469,10158.26,0.75,10160.86,1.31       )
INSERT INTO Tickers VALUES(10717360916,10158.26,0.74,10160.57,0.42       )
INSERT INTO Tickers VALUES(10717361086,10158.28,2.2,10160.48,5.75        )
INSERT INTO Tickers VALUES(10717361512,10158.26,0.67,10160.23,0.99       )
INSERT INTO Tickers VALUES(10717361771,10158.26,1.36,10160.09,5.41       )
INSERT INTO Tickers VALUES(10717362446,10158.38,3,10165.16,1.31          )
INSERT INTO Tickers VALUES(10717362899,10158.62,3,10164.84,0.8           )
INSERT INTO Tickers VALUES(10717363464,10158.82,3,10164.46,2.55          )
INSERT INTO Tickers VALUES(10717364048,10158.94,2.25,10164.16,1.4        )
INSERT INTO Tickers VALUES(10717364098,10158.94,2.25,10164.14,1.8        )
INSERT INTO Tickers VALUES(10717364332,10158.94,2.25,10163.99,4.2        )
INSERT INTO Tickers VALUES(10717364527,10158.94,2.25,10163.92,0.54       )
INSERT INTO Tickers VALUES(10717364613,10158.94,2.25,10163.89,2.13       )
INSERT INTO Tickers VALUES(10717364659,10158.94,2.25,10163.87,1.32       )
INSERT INTO Tickers VALUES(10717364772,10161.42,0.02,10163.83,1.31       )
INSERT INTO Tickers VALUES(10717364920,10161.42,0.02,10163.79,0.47       )
INSERT INTO Tickers VALUES(10717365150,10162.61,3,10163.89,0.57          )
INSERT INTO Tickers VALUES(10717365420,10164.01,0.75,10165.28,0.22       )
INSERT INTO Tickers VALUES(10717365714,10164.09,0.94,10165.28,0.11       )
INSERT INTO Tickers VALUES(10717366168,10163.93,0.03,10165.04,0.57       )
INSERT INTO Tickers VALUES(10717366381,10163.93,0.02,10163.94,1.78       )
INSERT INTO Tickers VALUES(10717366948,10161.23,2,10163.38,1.04          )
INSERT INTO Tickers VALUES(10717367385,10161.25,0.73,10163.15,0.91       )
INSERT INTO Tickers VALUES(10717367476,10161.25,0.75,10163.09,1.25       )
INSERT INTO Tickers VALUES(10717367784,10162.39,2.26,10164.08,0.55       )
INSERT INTO Tickers VALUES(10717368003,10162.43,3.01,10164.08,0.55       )
INSERT INTO Tickers VALUES(10717368236,10163.9,0.02,10165.28,0.22        )
INSERT INTO Tickers VALUES(10717368546,10164.04,3.01,10165.25,0.59       )
INSERT INTO Tickers VALUES(10717368973,10163.04,0.06,10165.03,0.66       )
INSERT INTO Tickers VALUES(10717369323,10163.04,0.06,10164.82,2          )
INSERT INTO Tickers VALUES(10717369989,10163.04,0.06,10164.38,5.31       )
INSERT INTO Tickers VALUES(10717370430,10163.04,0.06,10164.12,0.42       )
INSERT INTO Tickers VALUES(10717370582,10163.04,0.06,10164.11,7.03       )
INSERT INTO Tickers VALUES(10717371187,10163.04,0.06,10163.78,2.09       )
INSERT INTO Tickers VALUES(10717371374,10163.04,0.06,10163.05,17.97      )
INSERT INTO Tickers VALUES(10717372119,10158.26,2.87,10162.32,0.54       )
INSERT INTO Tickers VALUES(10717372613,10158.26,2.92,10161.97,0.41       )
INSERT INTO Tickers VALUES(10717372984,10158.26,2.92,10161.64,5          )
INSERT INTO Tickers VALUES(10717373139,10158.26,2.99,10161.5,0.41        )
INSERT INTO Tickers VALUES(10717373623,10158.26,1.58,10161.15,1.22       )
INSERT INTO Tickers VALUES(10717373941,10158.26,2.92,10160.86,5.56       )
INSERT INTO Tickers VALUES(10717374024,10158.26,1.5,10160.78,5.99        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717374206,10158.26,1.4,10159.98,3.32        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717374261,10158.92,0.02,10159.59,3.76       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717374332,10158.26,1.43,10159.35,5.55       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717374428,10158.25,1.96,10159,0.03          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717374683,10158.25,1.04,10158.73,0.03       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717374995,10158.25,0.94,10158.54,7.91       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717375162,10158.25,0.94,10158.47,8.09       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717375404,10158.25,0.94,10158.26,16.11      )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717458141,10185.44,0.62,10186.59,0.42       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717458346,10185.46,0.73,10186.59,0.42       )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717458611,10185.58,2,10186.59,0.41          )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717458726,10185.59,1.82,10186.59,0.4        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717458937,10185.63,1.89,10186.59,0.4        )
WAITFOR DELAY '00:00:00.025'
INSERT INTO Tickers VALUES(10717459400,10189.99,4.99,10190,8.23          )

DECLARE @FundsValue DECIMAL(18,10)= 0
DECLARE @PositionValue DECIMAL(18,10)= 0
DECLARE @AllocatedOrdersValue DECIMAL(18,10)= 0
select top 1 @FundsValue = ISNULL(value, 0), @PositionValue = ISNULL(p.size,0) * t.bidPrice from Positions p, tickers t, funds order by sequence desc
select top 1 @AllocatedOrdersValue = ISNULL(SUM(o.price * o.size),0) from orders o where o.status = -1 and o.type = 1 


SELECT @FundsValue AS FundsValue, @PositionValue as PositionValue, @AllocatedOrdersValue AS AllocatedOrdersValue, @FundsValue + @PositionValue + @AllocatedOrdersValue AS Total

select * from strategyproperties
select * from analysis
select top 10 * from tickers order by sequence desc