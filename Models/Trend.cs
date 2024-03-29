﻿using System;
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
        public int? Type { get; set; }
        public int Status { get; set; }
    }

    /* Status:=
     *      0 - Started
     *      1 - Finished
     * Type:=
     *     -1 - Downward Trend
     *      1 - Upward Trend
     */
}
