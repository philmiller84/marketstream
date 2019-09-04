using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Models;
using System.Net;
using Newtonsoft.Json;

namespace Executor
{
    public class Action
    {
        public string Type;
        public String Message;
        public int Status;
        public string Response;
    }

    class Program
    {
        // Create Socket Server
        public static SynchronousSocket.Client client;

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
            IPEndPoint remoteEP = new IPEndPoint(IPAddress.Parse("127.0.0.1"), 65433);
            client = new SynchronousSocket.Client(remoteEP);

            //Create queue for actions
            var actionQueue = new Queue<Action>();

            //Define order entry interval (will make it 5 per second, as per API limit)
            int rps = 5;

            var marketData = new Models.MarketData();

			const int CANCELLED_ORDER = -2;
			const int READY_ORDER = 0;
			const int OPEN_ORDER = 1;
			const int FILLED_ORDER = 2;

            //LOOP START - WHILE TRUE
            while (true)
            {
				//----Print to console the intended actions----

				//Check Orders table for ready orders
				var readyOrdersList = (from o in marketData.Orders where o.Status == READY_ORDER select o).ToList();

				foreach (var o in readyOrdersList)
				{
					//Generate Order Entry message
					var msg = GetOrderEntryMessage(o);
					actionQueue.Enqueue(new Action { Type = "ORDER_ENTRY", Message = msg });

					while (actionQueue.Count > 0)
					{
						//Execute actions in Queue as per API interval
						//If action fails, then wait interval and retry
						var a = actionQueue.Dequeue();
						if(ProcessAction(a) != 0)
							Console.WriteLine("Failed to process action of type {0} and message {1}", a.Type, a.Message);

						var response = JsonConvert.DeserializeObject<CBPRO.OrderEntryResponse>(a.Response);
						o.ExternalId = response.id;
						switch(response.status)
						{
							case "404":
								o.Status = CANCELLED_ORDER;
								break;
							case "active":
							case "open":
								o.Status = OPEN_ORDER;
								break;
							case "done":
								o.Status = FILLED_ORDER;
								break;
						}

						marketData.SaveChanges();
						Thread.Sleep(1000 / rps);
					}
				}


				//Check for Pending Request
				const int EXECUTION_REQUEST = 8;
				var pendingRequestsList = (from p in marketData.PendingRequests where p.Type == EXECUTION_REQUEST select p).ToList();

				foreach (var p in pendingRequestsList)
				{
					//Generate Fill request message for order 
					var msg = GetFillRequestMessage(p);
					actionQueue.Enqueue(new Action { Type = "FILL_REQUEST", Message = msg });

					while (actionQueue.Count > 0)
					{
						//Execute actions in Queue as per API interval
						//If action fails, then wait interval and retry
						var a = actionQueue.Dequeue();
						if (ProcessAction(a) != 0)
							Console.WriteLine("Failed to process action of type {0} and message {1}", a.Type, a.Message);

						p.Response = JsonConvert.DeserializeObject<CBPRO.FillsResponse>(a.Response).settled ? "Filled" : "Open";

						var updQry = (from o in marketData.Orders
									  where o.ExternalId == p.EntityId
									  select o).FirstOrDefault().Status = ((p.Response == "Filled") ? 2 : 1);

						marketData.PendingRequests.Remove(p);
						marketData.SaveChanges();

						Thread.Sleep(1000 / rps);
					}

				}
				//Print to console the value of positions + funds

				//TODO: NEED TO DEDUCT THE TRANSACTION FEES!!! THIS SHOULD BE DONE ON DATABASE SIDE. FOR NOW, JUST LEAVE AS IS, and ADJUST Funds between runs.

			} //LOOP END
        }

        private static int ProcessAction(Action a)
        {
            var initialResponse = client.Request(a.Type);

			if (initialResponse != "ACK")
				return -1;

			a.Response = client.Request(a.Message);

            return 0;
        }

        private static string GetFillRequestMessage(PendingRequest p)
        {
            var fillsRequest = new CBPRO.FillsRequest { order_id = p.EntityId };
            return JsonConvert.SerializeObject(fillsRequest).ToString();
        }

        private static String GetOrderEntryMessage(Order o)
        {
            var orderEntryMsg = new CBPRO.OrderEntry { local_order_id =o.OrderId.ToString(), price = o.Price, side = (o.Type == 1 ? "buy" : "sell"), size = o.Size, product_id = "BTC-USD" };
            return JsonConvert.SerializeObject(orderEntryMsg).ToString();
        }
    }
}
