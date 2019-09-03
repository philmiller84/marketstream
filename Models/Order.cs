using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CBPRO
{
    public class OrderEntry
    {
        //  "size": "0.01",
        //  "price": "0.100",
        //  "side": "buy",
        //  "product_id": "BTC-USD" 

        public decimal size;
        public decimal price;
        public string side;
        public string product_id;
        public string local_order_id;
    }

    public class OrderEntryResponse : OrderEntry
    {
        //  "id": "d0c5340b-6d6c-49d9-b567-48c4bfca13d2",
        //  "price": "0.10000000",
        //  "size": "0.01000000",
        //  "product_id": "BTC-USD",
        //  "side": "buy",
        //  "stp": "dc",
        //  "type": "limit",
        //  "time_in_force": "GTC",
        //  "post_only": false,
        //  "created_at": "2016-12-08T20:02:28.53864Z",
        //  "fill_fees": "0.0000000000000000",
        //  "filled_size": "0.00000000",
        //  "executed_value": "0.0000000000000000",
        //  "status": "pending",
        //  "settled": false

        public string id;
        public string stp;
        public string type;
        public string time_in_force;
        public bool post_only;
        public string created_at;
        public decimal fill_fees;
        public decimal filled_size;
        public decimal executed_value;
        public string status;
        public bool settled;
    }
}

namespace Models
{
    public class Order
    {
        [Key]
        public int OrderId { get; set; }
        public string ExternalId { get; set; }
        public decimal Price { get; set; }
        public decimal Size { get; set; }
        public int Type { get; set; }
        public int Status { get; set; }
    }

    public class OrderAudit
    {
        [Key]
        public int AuditId { get; set; }
        public int OrderId { get; set; }
        public string Changes { get; set; }
        public string Modifer { get; set; }

        [ForeignKey("OrderId")]
        public Order Order { get; set; }
    }
}

/*
    Status:=
        -1 Pending (all negative numbers, used for strategy????)
         0 Ready
         1 Open Order
         2 Completed Order

    Type:=
         1 Limit Buy
         2 Limit Sell
*/
	
