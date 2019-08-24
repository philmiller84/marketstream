namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class datagennone : DbMigration
    {
        public override void Up()
        {
            DropPrimaryKey("dbo.Tickers");
            AlterColumn("dbo.Tickers", "Sequence", c => c.Long(nullable: false));
            AddPrimaryKey("dbo.Tickers", "Sequence");
        }
        
        public override void Down()
        {
            DropPrimaryKey("dbo.Tickers");
            AlterColumn("dbo.Tickers", "Sequence", c => c.Long(nullable: false, identity: true));
            AddPrimaryKey("dbo.Tickers", "Sequence");
        }
    }
}
