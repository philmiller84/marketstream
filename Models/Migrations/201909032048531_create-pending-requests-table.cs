namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class creatependingrequeststable : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.PendingRequests",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Type = c.Int(nullable: false),
                        EntityId = c.String(),
                        Response = c.String(),
                    })
                .PrimaryKey(t => t.Id);
            
        }
        
        public override void Down()
        {
            DropTable("dbo.PendingRequests");
        }
    }
}
