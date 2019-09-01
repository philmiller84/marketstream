namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class createanalysistable : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Analysis",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Description = c.String(),
                        Value = c.Decimal(nullable: false, precision: 18, scale: 2),
                    })
                .PrimaryKey(t => t.Id);
            
        }
        
        public override void Down()
        {
            DropTable("dbo.Analysis");
        }
    }
}
