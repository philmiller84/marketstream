namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class makesequencekey : DbMigration
    {
        public override void Up()
        {
            DropPrimaryKey("dbo.Tickers");
            AlterColumn("dbo.Tickers", "Sequence", c => c.Long(nullable: false, identity: true));
            AddPrimaryKey("dbo.Tickers", "Sequence");
            DropColumn("dbo.Tickers", "TickerId");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Tickers", "TickerId", c => c.Int(nullable: false, identity: true));
            DropPrimaryKey("dbo.Tickers");
            AlterColumn("dbo.Tickers", "Sequence", c => c.Long(nullable: false));
            AddPrimaryKey("dbo.Tickers", "TickerId");
        }
    }
}
