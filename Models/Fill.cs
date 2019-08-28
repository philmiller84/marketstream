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
