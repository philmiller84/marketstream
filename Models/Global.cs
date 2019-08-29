using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Models
{
    public class Global
    {
        [Key]
        public int PropertyId { get; set; }
        public string Description { get; set; }
        public decimal Value { get; set; }
    }

}
