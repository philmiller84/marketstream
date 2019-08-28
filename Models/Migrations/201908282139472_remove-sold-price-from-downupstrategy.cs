namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class removesoldpricefromdownupstrategy : DbMigration
    {
        public override void Up()
        {
            DropColumn("dbo.DownUpStrategies", "SoldPrice");
            this.Sql(Properties.Resources.Drop_tr_WatchStrategy);
            this.Sql(Properties.Resources.Create_tr_WatchStrategy);
        }
        
        public override void Down()
        {
            AddColumn("dbo.DownUpStrategies", "SoldPrice", c => c.Decimal(nullable: false, precision: 18, scale: 2));
        }
    }
}
