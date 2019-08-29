namespace Models.Migrations
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Linq;

    internal sealed class Configuration : DbMigrationsConfiguration<Models.MarketData>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
            ContextKey = "Models.MarketData";
        }

        protected override void Seed(Models.MarketData context)
        {
            //  This method will be called after migrating to the latest version.

            //  You can use the DbSet<T>.AddOrUpdate() helper extension method 
            //  to avoid creating duplicate seed data.

            //TODO: Fix the capital gains tax based on the total income. This will need to change based on tax bracket. 
            context.Fees.AddOrUpdate(f => new { f.Type, f.Value , f.Description}, new Fee { Type = 0, Value = .28M, Description = "Capital Gains (Short Term) - Percentage" });
            context.Fees.AddOrUpdate(f => new { f.Type, f.Value , f.Description}, new Fee { Type = 1, Value = .0025M, Description = "Taker Fee - Percentage" });


            context.StrategyProperties.AddOrUpdate(s => new { s.StrategyType, s.Description, s.Value}, new StrategyProperty { StrategyType = 0, Description = "Sell Increment", Value = .10M });
            context.StrategyProperties.AddOrUpdate(s => new { s.StrategyType, s.Description, s.Value}, new StrategyProperty { StrategyType = 0, Description = "Downturn Threshold", Value = .01M });
            context.StrategyProperties.AddOrUpdate(s => new { s.StrategyType, s.Description, s.Value}, new StrategyProperty { StrategyType = 0, Description = "Max Open Orders", Value = 5 });

            context.Funds.AddOrUpdate(f => new { f.Value, f.Currency, f.AllocationType }, new Fund { Value = 100, Currency = 0, AllocationType = 1 });

            context.Globals.AddOrUpdate(g => new { g.Description, g.Value }, new Global { Description = "Minimum Order Size", Value = 0.001M });
        }
    }
}
