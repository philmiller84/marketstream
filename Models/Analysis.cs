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
    [Table("Analysis")]
    public class Analysis
    {
        [Key]
        public int Id { get; set; }
        public string Description { get; set; }
        public decimal Value { get; set; }
    }
}
