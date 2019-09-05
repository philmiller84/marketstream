namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class fillschanges : DbMigration
    {
        public override void Up()
        {
            DropForeignKey("dbo.Fills", "OrderId", "dbo.Orders");
            DropIndex("dbo.Fills", new[] { "OrderId" });
            AddColumn("dbo.Fills", "ExternalOrderId", c => c.String());
            DropColumn("dbo.Fills", "OrderId");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Fills", "OrderId", c => c.Int(nullable: false));
            DropColumn("dbo.Fills", "ExternalOrderId");
            CreateIndex("dbo.Fills", "OrderId");
            AddForeignKey("dbo.Fills", "OrderId", "dbo.Orders", "OrderId", cascadeDelete: true);
        }
    }
}
