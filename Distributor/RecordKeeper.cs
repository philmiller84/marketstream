using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models;
//using System.Data.Entity;

namespace Distributor
{
    class RecordKeeper
    {
		public MarketData db;
		public RecordKeeper(MarketData marketData) { db = marketData; InitializeData(); }

		public void AddL1Data(Ticker t)
		{
			var dbQuery = db.Tickers.OrderByDescending(x => x.Sequence).FirstOrDefault();

			if (dbQuery != null && !(dbQuery.BidPrice == t.BidPrice && dbQuery.AskPrice == t.AskPrice))
			{
				db.Tickers.Add(t);
				Console.WriteLine("Sending to DB: {0}", t.ToString());
				db.SaveChanges();
			}
		}

		private void InitializeData()
		{
			var analysisRecords = db.Analysis;
			db.Analysis.RemoveRange(analysisRecords);

			var strategyPropertiesRecords = db.StrategyProperties;
			db.StrategyProperties.RemoveRange(strategyPropertiesRecords);
		}

    }

}