namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;

    public partial class createstrategyorderjointable : DbMigration
    {
        public override void Up()
        {
            CreateTable("dbo.StrategyOrderJoins",
                c => new
                {
                    StrategyId = c.Int(nullable: false),
                    OrderId = c.Int(nullable: false),
                }).PrimaryKey(t => new { t.StrategyId, t.OrderId });

            AddForeignKey("dbo.StrategyOrderJoins", "StrategyId", "Strategies", "StrategyId");
            AddForeignKey("dbo.StrategyOrderJoins", "OrderId", "Orders", "OrderId");
        }


        public override void Down()
        {
            DropTable("dbo.StrategyOrderJoins");
        }
    }
}
