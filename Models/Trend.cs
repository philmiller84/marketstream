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
        public long StartSequence { get; set; }
        public long EndSequence { get; set; }
        public decimal StartBidPrice { get; set; }
        public decimal EndBidPrice { get; set; }
        public decimal StartAskPrice { get; set; }
        public decimal EndAskPrice { get; set; }
        public int Type { get; set; }
        public int Status { get; set; }
    }

    public class TrendAnalysis : DbContext
    {
        public DbSet<Trend> Trends { get; set; }
    }
}
