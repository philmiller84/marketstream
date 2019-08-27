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
        public string Value { get; set; }
        public int Type { get; set; }
        public int Status { get; set; }
    }

    public class GlobalData : DbContext
    {
        public DbSet<Global> Globals { get; set; }
    }
}
