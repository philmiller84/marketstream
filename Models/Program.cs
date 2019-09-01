using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models;
using System.Data.Entity;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;


namespace Models
{
    public class MarketData : DbContext
    {
        public DbSet<Ticker> Tickers { get; set; }
        public DbSet<Fund> Funds { get; set; }
        public DbSet<Global> Globals { get; set; }
        public DbSet<Log> Logs { get; set; }
        public DbSet<Fee> Fees { get; set; }
        public DbSet<Fill> Fills { get; set; }
        public DbSet<Trend> Trends { get; set; }
        public DbSet<Analysis> Analysis { get; set; }
        public DbSet<Strategy> Strategies { get; set; }
        public DbSet<DownUpStrategy> DownUpStrategies { get; set; }
        public DbSet<StrategyProperty> StrategyProperties { get; set; }
        public DbSet<StrategyOrderJoin> StrategyOrderJoins { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<OrderAudit> OrderAudits { get; set; }
        public DbSet<Position> Positions { get; set; }

        public DbSet<VOrders> VOrders { get; set; }
        public DbSet<VExposure> VExposure { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Ticker>().Property(p => p.BidSize).HasPrecision(18, 10);
            modelBuilder.Entity<Ticker>().Property(p => p.AskSize).HasPrecision(18, 10);

            modelBuilder.Entity<Fill>().Property(p => p.Size).HasPrecision(18, 10);

            modelBuilder.Entity<Order>().Property(p => p.Size).HasPrecision(18, 10);
            modelBuilder.Entity<Position>().Property(p => p.Size).HasPrecision(18, 10);

            modelBuilder.Entity<Global>().Property(p => p.Value).HasPrecision(18, 10);
            modelBuilder.Entity<Fee>().Property(p => p.Value).HasPrecision(18, 10);
            modelBuilder.Entity<Fund>().Property(p => p.Value).HasPrecision(18, 10);

            modelBuilder.Entity<StrategyProperty>().Property(p => p.Value).HasPrecision(18, 10);
        }
    }
}

namespace Models
{
    class Program
    {
        static void Main(string[] args)
        {

            //Console.WriteLine("FINISHED");
        }
    }
}
