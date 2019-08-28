using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

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
	
