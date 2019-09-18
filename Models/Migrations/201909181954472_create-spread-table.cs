namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class createspreadtable : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Spreads",
                c => new
                    {
                        SpreadId = c.Int(nullable: false, identity: true),
                        StartSequence = c.Long(nullable: false),
                        EndSequence = c.Long(nullable: false),
                        BidPrice = c.Decimal(nullable: false, precision: 18, scale: 2),
                        AskPrice = c.Decimal(nullable: false, precision: 18, scale: 2),
                        Status = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.SpreadId);
			this.Sql(Properties.Resources.Create_tr_WatchSpread);
            
        }
        
        public override void Down()
        {
			this.Sql(Properties.Resources.Drop_tr_WatchSpread);
            DropTable("dbo.Spreads");
        }
    }
}
