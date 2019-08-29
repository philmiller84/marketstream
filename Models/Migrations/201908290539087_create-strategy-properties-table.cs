namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class createstrategypropertiestable : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.StrategyProperties",
                c => new
                    {
                        PropertyId = c.Int(nullable: false, identity: true),
                        StrategyType = c.Int(nullable: false),
                        Description = c.String(),
                        Value = c.Decimal(nullable: false, precision: 18, scale: 10),
                    })
                .PrimaryKey(t => t.PropertyId);
            
        }
        
        public override void Down()
        {
            DropTable("dbo.StrategyProperties");
        }
    }
}
