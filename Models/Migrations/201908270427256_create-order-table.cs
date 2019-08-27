namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class createordertable : DbMigration
    {
        public override void Up()
        { 
            CreateTable("dbo.Orders",
                c => new
                {
                    OrderId = c.Int(nullable: false, identity: true),
                    ExternalId = c.String(nullable: true),
                    Price = c.Decimal(nullable: false, precision: 18, scale: 2),
                    Size = c.Decimal(nullable: false, precision: 18, scale: 10),
                    Type = c.Int(nullable: true),
                    Status = c.Int(nullable: true),
                }).PrimaryKey(t => t.OrderId);
        }
        
        public override void Down()
        {
            DropTable("dbo.Orders");
        }
    }
}
