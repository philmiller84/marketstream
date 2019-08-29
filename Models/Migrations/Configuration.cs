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
            context.Feeds.AddOrUpdate(f => new { f.Type, f.Value , f.Description}, new Fee { Type = 0, Value = .28M, Description = "Capital Gains (Short Term) - Percentage" });
            context.Feeds.AddOrUpdate(f => new { f.Type, f.Value , f.Description}, new Fee { Type = 1, Value = .0025M, Description = "Taker Fee - Percentage" });


            context.StrategyProperties.AddOrUpdate(s => new { s.StrategyType, s.Description, s.Value}, new StrategyProperty { StrategyType = 0, Description = "Sell Increment - Real value", Value = .10M });
            context.StrategyProperties.AddOrUpdate(s => new { s.StrategyType, s.Description, s.Value}, new StrategyProperty { StrategyType = 0, Description = "Downturn Threshold - Real value", Value = .01M });
            context.StrategyProperties.AddOrUpdate(s => new { s.StrategyType, s.Description, s.Value}, new StrategyProperty { StrategyType = 0, Description = "Max Open Orders - Int value", Value = 5 });

        }
    }
}
