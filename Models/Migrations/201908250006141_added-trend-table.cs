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
                        StartSequence = c.Long(nullable: false),
                        EndSequence = c.Long(nullable: true),
                        StartBidPrice = c.Single(nullable: true),
                        EndBidPrice = c.Single(nullable: true),
                        StartAskPrice = c.Single(nullable: true),
                        EndAskPrice = c.Single(nullable: true),
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
