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
    public class Fund
    {
        [Key]
        public int FundId { get; set; }
        public decimal Value { get; set; }
        public int Currency { get; set; }
        public int AllocationId { get; set; }
        public int AllocationType { get; set; }
        public int Status { get; set; }
    }
    public class FundAssignments : DbContext
    {
        public DbSet<Fund> Funds { get; set; }
    }
}
