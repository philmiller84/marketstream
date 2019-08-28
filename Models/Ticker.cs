using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CBPRO
{
    public class TopOfBook
    {
        //{'sequence': 10683677830, 
        //'bids': [['10348.79', '0.0011764', 1]],
        //'asks': [['10348.8', '7.56202978', 6]]}
        public long sequence;
        public string[][] bids;
        public string[][] asks;
    }

}

namespace Models
{
    public class Ticker
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public long Sequence { get; set; }
        public decimal BidPrice { get; set; }
        public decimal BidSize { get; set; }
        public decimal AskPrice { get; set; }
        public decimal AskSize { get; set; }
    }
}