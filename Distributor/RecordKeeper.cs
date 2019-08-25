using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
//using System.Data.Entity;

namespace Distributor
{
    class RecordKeeper
    {
        public void AddL1Data(Models.Ticker t)
        {
            using (var db = new Models.MarketData())
            {
                //var dbQuery = (from q in db.Tickers where q.Sequence == t.Sequence select q).FirstOrDefault();
                var dbQuery = db.Tickers.OrderByDescending(x => x.Sequence).FirstOrDefault();

                if (dbQuery == null || !(dbQuery.BidPrice == t.BidPrice && dbQuery.AskPrice == t.AskPrice))
                {
                    db.Tickers.Add(t);
                    Console.WriteLine("Sending to DB: {0}", t.ToString());
                    db.SaveChanges();
                }
            }
        }

    }

}