using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Models;
using Newtonsoft.Json;

namespace Executor
{
    public class Action
    {
        public string Type;
        public String Message;
        public int Status;
        public int Response;
    }

    class Program
    {
        public void FetchL1Data()
        {
            var db = new Models.MarketData();
            var tickerQuery = from t in db.Tickers select t;
            var tList = tickerQuery.ToList();
            var viewQuery = from o in db.VOrders select o.OrderId;

            foreach(var o in viewQuery.ToList()) { Console.WriteLine("Order {0}", o.ToString()); } 
            foreach(var t in tList) { Console.WriteLine("Sequence {0}:\tBidPrice: {1}\tAskPrice: {2}", t.Sequence.ToString(), t.BidPrice.ToString(), t.AskPrice.ToString()); } 
        }

        static void Main(string[] args)
        {
            //Create queue for actions
            var actionQueue = new Queue<Action>();

            //Define order entry interval (will make it 5 per second, as per API limit)
            int rps = 5;

            var marketData = new Models.MarketData();

            //LOOP START - WHILE TRUE
            while (true)
            {
                //----Print to console the intended actions----

                //Check Orders table for ready orders
                var query = from o in marketData.Orders
                            where o.Type == 1 && o.Status < 1
                            select o;

                foreach(var o in query.ToList())
                {
                    //Generate Order Entry message
                    var msg = GetOrderEntryMessage(o);
                    actionQueue.Enqueue(new Action { Type = "ORDER_ENTRY", Message = msg });

                    //Generate Fill request message for order 
                    msg = GetFillRequestMessage(o);
                    actionQueue.Enqueue(new Action { Type = "FILL_REQUEST", Message = msg });
                }

                while(actionQueue.Count > 0)
                {
                    //Execute actions in Queue as per API interval
                    //If action fails, then wait interval and retry
                    var a = actionQueue.Dequeue();
                    while (ProcessAction(a) != 0)
                    {
                        Console.WriteLine("Failed to process action of type {0} and message {1}", a.Type, a.Message);
                        Thread.Sleep(1000 / rps);
                    }
                }

                //Print to console the value of positions + funds


                //TODO: NEED TO DEDUCT THE TRANSACTION FEES!!! THIS SHOULD BE DONE ON DATABASE SIDE. FOR NOW, JUST LEAVE AS IS, and ADJUST Funds between runs.

            } //LOOP END
        }

        private static int ProcessAction(Action a)
        {
            throw new NotImplementedException();
        }

        private static string GetFillRequestMessage(Order o)
        {
            var orderRequestMsg = new CBPRO.FillsRequest { order_id = o.ExternalId };
            return JsonConvert.SerializeObject(orderRequestMsg).ToString();
        }

        private static String GetOrderEntryMessage(Order o)
        {
            var orderEntryMsg = new CBPRO.OrderEntry { price = o.Price, side = (o.Type == 1 ? "buy" : "sell"), size = o.Size, product_id = "BTC-USD" };
            return JsonConvert.SerializeObject(orderEntryMsg).ToString();
        }
    }
}
