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
    public class Strategy
    {
        public int StrategyId { get; set; }
        public int Type { get; set; }
        public int Status { get; set; }
    }

    public class StrategyOrderJoin
    {
        [Key, ForeignKey("Strategy")]
        public Strategy Strategy { get; set; }
        [Key, ForeignKey("Order")]
        public Order Order { get; set; }
    }

    public class StategyData : DbContext
    {
        public DbSet<Strategy> Strategies { get; set; }
        public DbSet<DownUpStrategy> DownUpStrategies { get; set; }
        public DbSet<StrategyOrderJoin> StrategyOrderJoins { get; set; }
    }
}
