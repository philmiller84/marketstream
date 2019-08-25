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
                var dbQuery = (from q in db.Tickers
                                  where q.Sequence == t.Sequence
                                  select q).FirstOrDefault();

                if (dbQuery == null)
                {
                    db.Tickers.Add(t);
                    db.SaveChanges();
                }
            }
        }

    }

}