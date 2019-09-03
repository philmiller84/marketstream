using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models;
using System.Net;
using Newtonsoft.Json;

namespace Distributor
{
    class Program
    {
        static void Main(string[] args)
        {
            IPEndPoint remoteEP = new IPEndPoint(IPAddress.Parse("127.0.0.1"), 65432);

            SynchronousSocket.Client c = new SynchronousSocket.Client(remoteEP);

            var rec = new RecordKeeper();

            int rps = 1;

            while(true)
            {
                var ticker = c.Request("GET");

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

                System.Threading.Thread.Sleep(1000 / rps);
            }
        }
    }
}
