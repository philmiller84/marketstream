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

    public class StategyData : DbContext
    {
        public DbSet<Strategy> Strategies { get; set; }
    }
}
