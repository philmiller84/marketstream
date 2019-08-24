namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class InitialCreate : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Tickers",
                c => new
                    {
                        TickerId = c.Int(nullable: false, identity: true),
                        sequence = c.Int(nullable: false),
                        bidPrice = c.Single(nullable: false),
                        bidSize = c.Single(nullable: false),
                        askPrice = c.Single(nullable: false),
                        askSize = c.Single(nullable: false),
                    })
                .PrimaryKey(t => t.TickerId);
            
        }
        
        public override void Down()
        {
            DropTable("dbo.Tickers");
        }
    }
}
