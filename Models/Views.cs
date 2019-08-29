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
    [Table("V_Exposure")]
    public class VExposure
    {
        [Key]
        public Guid Id { get; set; }
        public decimal Value { get; set; }
        public decimal Size { get; set; }
    }

    [Table("V_Orders")]
    public class VOrders
    {
        [Key]
        public Guid Id { get; set; }
        public int OrderId { get; set; }

        [ForeignKey("OrderId")]
        public Order Order { get; set; }
    }
}
       
