namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class addedtrendtable : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                    "dbo.Trends",
                    c => new
                    {
                        TrendId = c.Int(nullable: false, identity: true),
                        MinSequence = c.Int(nullable: false),
                        MaxSequence = c.Int(nullable: false),
                        MinBidPrice = c.Single(nullable: false),
                        MaxBidPrice = c.Single(nullable: false),
                        MinAskPrice = c.Single(nullable: false),
                        MaxAskPrice = c.Single(nullable: false),
                    })
                    .PrimaryKey(t => t.TrendId);
        } 

        public override void Down()
        {
            DropTable("dbo.Trends");
        }
    }
}
