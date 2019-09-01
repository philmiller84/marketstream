namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class createlogstable : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Logs",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Level = c.Int(nullable: false),
                        Context = c.String(),
                        Text = c.String(),
                    })
                .PrimaryKey(t => t.Id);
            
            this.Sql(Properties.Resources.Create_GetLogLevel);
        }
        
        public override void Down()
        {
            this.Sql(Properties.Resources.Drop_GetLogLevel);
            DropTable("dbo.Logs");
        }
    }
}
