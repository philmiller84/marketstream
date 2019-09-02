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
    public class FillsRequest
    {
        //  "order_id": d50ec984-77a8-460a-b958-66f114b0de9b"
        //  "product_id": "ETH-BTC"
        public string order_id;
        public string product_id;
    }

    public class FillsResponse : OrderEntry
    {
        //  "trade_id": 74,
        //  "product_id": "BTC-USD",
        //  "price": "10.00",
        //  "size": "0.01",
        //  "order_id": "d50ec984-77a8-460a-b958-66f114b0de9b",
        //  "created_at": "2014-11-07T22:19:28.578544Z",
        //  "liquidity": "T",
        //  "fee": "0.00025",
        //  "settled": true,
        //  "side": "buy"
        public string trade_id;
        public string order_id;
        public string created_at;
        public string liquidity;
        public decimal fee;
        public bool settled;
    }
}

namespace Models
{
    public class Fill
    {
        [Key]
        public int FillId { get; set; }
        public int OrderId { get; set; }

        public decimal Price { get; set; }
        public decimal Size { get; set; }

        [ForeignKey("OrderId")]
        public Order Order { get; set; }
    }
 }
