namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class createfeestable : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Fees",
                c => new
                    {
                        FeeId = c.Int(nullable: false, identity: true),
                        Type = c.Int(nullable: false),
                        Value = c.Decimal(nullable: false, precision: 18, scale: 10),
                        Description = c.String(),
                    })
                .PrimaryKey(t => t.FeeId);
            
        }
        
        public override void Down()
        {
            DropTable("dbo.Fees");
        }
    }
}
