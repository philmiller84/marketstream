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
    public class Log
    {
        [Key]
        public int Id { get; set; }
        public int Level { get; set; }
        public string Context { get; set; }
        public string Text { get; set; }
    }
}
