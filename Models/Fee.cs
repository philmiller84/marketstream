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
    public class Fee
    {
        [Key]
        public int FeeId { get; set; }
        public int Type { get; set; }
        public decimal Value { get; set;}
        public string Description { get; set; }
    }
}

/*
 *  Type:=
 *          0 - Capital Gains Tax (Percentage)
 *          1 - Taker Fee (Percentage)
 *          2 - Transaction Fee (unknown. verify against filled order) TODO!!!
 */
