﻿using System;
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
        public int StrategyId { get; set; }
        public decimal BuyPrice { get; set; }
        public decimal MinimumThreshold { get; set; }
        //public decimal SellTarget { get; set; }
        //public decimal SoldPrice { get; set; }

        [ForeignKey("StrategyId")]
        public Strategy Strategy { get; set; }
    }

    public class Strategy
    {
        public int StrategyId { get; set; }
        public int Type { get; set; }
        public int Status { get; set; }
    }

    public class StrategyOrderJoin
    {
        [Key, Column(Order = 0)]
        public int StrategyId { get; set; }
        [Key, Column(Order = 1)]
        public int OrderId { get; set; }


        [ForeignKey("StrategyId")]
        public Strategy Strategy { get; set; }
        [ForeignKey("OrderId")]
        public Order Order { get; set; }
    }
}


/*
    Status:=
        -1 Pending (all negative numbers, used for strategy????)
         0 Ready
         1 Started
         2 Completed

    Type:=
         1 Down Up
*/

