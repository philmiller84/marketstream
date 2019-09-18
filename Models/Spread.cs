using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
	public class Spread
	{
		public int SpreadId { get; set; }
		public long StartSequence { get; set; }
		public long EndSequence { get; set; }
		public decimal BidPrice { get; set; }
		public decimal AskPrice { get; set; }
		public int Status { get; set; }
	}
}
