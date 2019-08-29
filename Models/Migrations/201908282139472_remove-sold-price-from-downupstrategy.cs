namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class removesoldpricefromdownupstrategy : DbMigration
    {
        public override void Up()
        {
            DropColumn("dbo.DownUpStrategies", "SoldPrice");
        }
        
        public override void Down()
        {
            AddColumn("dbo.DownUpStrategies", "SoldPrice", c => c.Decimal(nullable: false, precision: 18, scale: 2));
        }
    }
}
