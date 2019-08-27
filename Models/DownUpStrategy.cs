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
    public class DownUpStrategy
    {
        [Key]
        public int DownUpStrategyId { get; set; }
        [ForeignKey("Strategy")]
        public int StrategyID { get; set; }
        public decimal BuyPrice { get; set; }
        public decimal MinimumThreshold { get; set; }
        //public decimal SellTarget { get; set; }
        public decimal SoldPrice { get; set; }
    }
}
