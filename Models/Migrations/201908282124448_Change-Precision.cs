namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class ChangePrecision : DbMigration
    {
        public override void Up()
        {
            AlterColumn("dbo.Fills", "Size", c => c.Decimal(nullable: false, precision: 18, scale: 10));
            AlterColumn("dbo.Orders", "Size", c => c.Decimal(nullable: false, precision: 18, scale: 10));
            AlterColumn("dbo.Tickers", "BidSize", c => c.Decimal(nullable: false, precision: 18, scale: 10));
            AlterColumn("dbo.Tickers", "AskSize", c => c.Decimal(nullable: false, precision: 18, scale: 10));
        }
        
        public override void Down()
        {
            AlterColumn("dbo.Tickers", "AskSize", c => c.Decimal(nullable: false, precision: 18, scale: 2));
            AlterColumn("dbo.Tickers", "BidSize", c => c.Decimal(nullable: false, precision: 18, scale: 2));
            AlterColumn("dbo.Orders", "Size", c => c.Decimal(nullable: false, precision: 18, scale: 2));
            AlterColumn("dbo.Fills", "Size", c => c.Decimal(nullable: false, precision: 18, scale: 2));
        }
    }
}
