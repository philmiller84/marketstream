namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class ulongtolong : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Tickers", "Sequence", c => c.Long(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.Tickers", "Sequence");
        }
    }
}
