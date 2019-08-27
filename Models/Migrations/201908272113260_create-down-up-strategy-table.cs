namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;

    public partial class createdownupstrategytable : DbMigration
    {
        public override void Up()
        {
            CreateTable("dbo.DownUpStrategies",
                c => new
                {
                    DownUpStrategyID = c.Int(nullable: false, identity: true),
                    StrategyID = c.Int(nullable: false),
                    BuyPrice = c.Decimal(nullable: false, precision: 18, scale: 2),
                    MinimumThreshold = c.Decimal(nullable: false, precision: 18, scale: 10),
                    SoldPrice = c.Decimal(nullable: true, precision: 18, scale: 2),
                }).PrimaryKey(t => t.DownUpStrategyID);
            AddForeignKey("dbo.DownUpStrategies", "StrategyID", "Strategies", "StrategyID");
            
        }

        public override void Down()
        {
            DropTable("dbo.DownUpStrategies");
        }
    }
}
