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
	public class PendingRequest
	{
		[Key]
		public int Id { get; set; }
		public int Type { get; set; }
		public string EntityId { get; set; }
		public string Response { get; set; }
	}
}
