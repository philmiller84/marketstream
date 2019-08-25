using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Trend
    {
        public int TrendId { get; set; }
        public long MinSequence { get; set; }
        public long MaxSequence { get; set; }
        public decimal MinBidPrice { get; set; }
        public decimal MaxBidPrice { get; set; }
        public decimal MinAskPrice { get; set; }
        public decimal MaxAskPrice { get; set; }
        public int Type { get; set; }
    }

    public class TrendAnalysis : DbContext
    {
        public DbSet<Trend> Trends { get; set; }
    }
}
