using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models;

namespace Differentiator
{
    class Program
    {
        public void FetchL1Data()
        {
            var db = new Models.MarketData();
            var tickerQuery = from t in db.Tickers select t;
            var tList = tickerQuery.ToList();
            var viewQuery = from o in db.VOrders select o.OrderId;

            foreach(var o in viewQuery.ToList())
            {

                Console.WriteLine("Order {0}",
                    o.ToString());
            }

            foreach(var t in tList)
            {
                Console.WriteLine("Sequence {0}:\tBidPrice: {1}\tAskPrice: {2}",
                    t.Sequence.ToString(),
                    t.BidPrice.ToString(),
                    t.AskPrice.ToString());
            }

        }

        static void Main(string[] args)
        {
            var p = new Program();
            p.FetchL1Data();
        }
    }
}
