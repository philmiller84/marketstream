namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class init : DbMigration
    {
        public override void Up()
        {
            AlterColumn("dbo.Tickers", "bidPrice", c => c.Decimal(nullable: false, precision: 18, scale: 2));
            AlterColumn("dbo.Tickers", "bidSize", c => c.Decimal(nullable: false, precision: 18, scale: 2));
            AlterColumn("dbo.Tickers", "askPrice", c => c.Decimal(nullable: false, precision: 18, scale: 2));
            AlterColumn("dbo.Tickers", "askSize", c => c.Decimal(nullable: false, precision: 18, scale: 2));
            DropColumn("dbo.Tickers", "sequence");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Tickers", "sequence", c => c.Int(nullable: false));
            AlterColumn("dbo.Tickers", "askSize", c => c.Single(nullable: false));
            AlterColumn("dbo.Tickers", "askPrice", c => c.Single(nullable: false));
            AlterColumn("dbo.Tickers", "bidSize", c => c.Single(nullable: false));
            AlterColumn("dbo.Tickers", "bidPrice", c => c.Single(nullable: false));
        }
    }
}
