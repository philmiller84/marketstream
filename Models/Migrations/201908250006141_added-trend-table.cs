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
                        MinSequence = c.Long(nullable: false),
                        MaxSequence = c.Long(nullable: true),
                        MinBidPrice = c.Single(nullable: true),
                        MaxBidPrice = c.Single(nullable: true),
                        MinAskPrice = c.Single(nullable: true),
                        MaxAskPrice = c.Single(nullable: true),
                        Type = c.Single(nullable: true)
                    })
                    .PrimaryKey(t => t.TrendId);
        } 

        public override void Down()
        {
            DropTable("dbo.Trends");
        }
    }
}
