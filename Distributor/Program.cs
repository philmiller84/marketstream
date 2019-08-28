using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models;
using Newtonsoft.Json;

namespace Distributor
{
    class Program
    {
        static void Main(string[] args)
        {
            SynchronousSocketClient s = new SynchronousSocketClient();
            var rec = new RecordKeeper();

            using (TradesData t = new TradesData())
            {

            }

                for (int i = 0; i < 1000; i++)
                {
                    var ticker = s.Request("GET");

                    if (!String.IsNullOrEmpty(ticker))
                    {
                        var topOfBook = JsonConvert.DeserializeObject<CBPRO.TopOfBook>(ticker);

                        var t = new Models.Ticker();
                        t.BidPrice = Convert.ToDecimal(topOfBook.bids[0][0]);
                        t.BidSize = Convert.ToDecimal(topOfBook.bids[0][1]);
                        t.AskPrice = Convert.ToDecimal(topOfBook.asks[0][0]);
                        t.AskSize = Convert.ToDecimal(topOfBook.asks[0][1]);
                        t.Sequence = topOfBook.sequence;

                        rec.AddL1Data(t);
                    }
                }
            
            //Console.WriteLine("FINISHED");
        }
    }
}
