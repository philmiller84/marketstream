namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class NewInitialCreate : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.DownUpStrategies",
                c => new
                    {
                        StrategyId = c.Int(nullable: false),
                        BuyPrice = c.Decimal(nullable: false, precision: 18, scale: 2),
                        MinimumThreshold = c.Decimal(nullable: false, precision: 18, scale: 2),
                        SoldPrice = c.Decimal(nullable: false, precision: 18, scale: 2),
                    })
                .PrimaryKey(t => t.StrategyId)
                .ForeignKey("dbo.Strategies", t => t.StrategyId)
                .Index(t => t.StrategyId);
            
            CreateTable(
                "dbo.Strategies",
                c => new
                    {
                        StrategyId = c.Int(nullable: false, identity: true),
                        Type = c.Int(nullable: false),
                        Status = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.StrategyId);
            
            CreateTable(
                "dbo.Fills",
                c => new
                    {
                        FillId = c.Int(nullable: false, identity: true),
                        OrderId = c.Int(nullable: false),
                        Price = c.Decimal(nullable: false, precision: 18, scale: 2),
                        Size = c.Decimal(nullable: false, precision: 18, scale: 2),
                    })
                .PrimaryKey(t => t.FillId)
                .ForeignKey("dbo.Orders", t => t.OrderId, cascadeDelete: true)
                .Index(t => t.OrderId);
            
            CreateTable(
                "dbo.Orders",
                c => new
                    {
                        OrderId = c.Int(nullable: false, identity: true),
                        ExternalId = c.String(),
                        Price = c.Decimal(nullable: false, precision: 18, scale: 2),
                        Size = c.Decimal(nullable: false, precision: 18, scale: 2),
                        Type = c.Int(nullable: false),
                        Status = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.OrderId);
            
            CreateTable(
                "dbo.Funds",
                c => new
                    {
                        FundId = c.Int(nullable: false, identity: true),
                        Value = c.Decimal(nullable: false, precision: 18, scale: 2),
                        Currency = c.Int(nullable: false),
                        AllocationId = c.Int(nullable: false),
                        AllocationType = c.Int(nullable: false),
                        Status = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.FundId);
            
            CreateTable(
                "dbo.Globals",
                c => new
                    {
                        PropertyId = c.Int(nullable: false, identity: true),
                        Value = c.String(),
                        Type = c.Int(nullable: false),
                        Status = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.PropertyId);
            
            CreateTable(
                "dbo.OrderAudits",
                c => new
                    {
                        AuditId = c.Int(nullable: false, identity: true),
                        OrderId = c.Int(nullable: false),
                        Changes = c.String(),
                        Modifer = c.String(),
                    })
                .PrimaryKey(t => t.AuditId)
                .ForeignKey("dbo.Orders", t => t.OrderId, cascadeDelete: true)
                .Index(t => t.OrderId);
            
            CreateTable(
                "dbo.StrategyOrderJoins",
                c => new
                    {
                        StrategyId = c.Int(nullable: false),
                        OrderId = c.Int(nullable: false),
                    })
                .PrimaryKey(t => new { t.StrategyId, t.OrderId })
                .ForeignKey("dbo.Orders", t => t.OrderId, cascadeDelete: true)
                .ForeignKey("dbo.Strategies", t => t.StrategyId, cascadeDelete: true)
                .Index(t => t.StrategyId)
                .Index(t => t.OrderId);
            
            CreateTable(
                "dbo.Tickers",
                c => new
                    {
                        Sequence = c.Long(nullable: false),
                        BidPrice = c.Decimal(nullable: false, precision: 18, scale: 2),
                        BidSize = c.Decimal(nullable: false, precision: 18, scale: 2),
                        AskPrice = c.Decimal(nullable: false, precision: 18, scale: 2),
                        AskSize = c.Decimal(nullable: false, precision: 18, scale: 2),
                    })
                .PrimaryKey(t => t.Sequence);
            
            CreateTable(
                "dbo.Trends",
                c => new
                    {
                        TrendId = c.Int(nullable: false, identity: true),
                        StartSequence = c.Long(nullable: false),
                        EndSequence = c.Long(nullable: false),
                        StartBidPrice = c.Decimal(nullable: false, precision: 18, scale: 2),
                        EndBidPrice = c.Decimal(nullable: false, precision: 18, scale: 2),
                        StartAskPrice = c.Decimal(nullable: false, precision: 18, scale: 2),
                        EndAskPrice = c.Decimal(nullable: false, precision: 18, scale: 2),
                        Type = c.Int(nullable: false),
                        Status = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.TrendId);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.StrategyOrderJoins", "StrategyId", "dbo.Strategies");
            DropForeignKey("dbo.StrategyOrderJoins", "OrderId", "dbo.Orders");
            DropForeignKey("dbo.OrderAudits", "OrderId", "dbo.Orders");
            DropForeignKey("dbo.Fills", "OrderId", "dbo.Orders");
            DropForeignKey("dbo.DownUpStrategies", "StrategyId", "dbo.Strategies");
            DropIndex("dbo.StrategyOrderJoins", new[] { "OrderId" });
            DropIndex("dbo.StrategyOrderJoins", new[] { "StrategyId" });
            DropIndex("dbo.OrderAudits", new[] { "OrderId" });
            DropIndex("dbo.Fills", new[] { "OrderId" });
            DropIndex("dbo.DownUpStrategies", new[] { "StrategyId" });
            DropTable("dbo.Trends");
            DropTable("dbo.Tickers");
            DropTable("dbo.StrategyOrderJoins");
            DropTable("dbo.OrderAudits");
            DropTable("dbo.Globals");
            DropTable("dbo.Funds");
            DropTable("dbo.Orders");
            DropTable("dbo.Fills");
            DropTable("dbo.Strategies");
            DropTable("dbo.DownUpStrategies");
        }
    }
}
