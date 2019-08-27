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
    public class OrderData : DbContext
    {
        public DbSet<Order> Orders { get; set; }
    }
}

