namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class createglobalstable: DbMigration
    {
        public override void Up()
        {
            CreateTable("dbo.Globals",
                c => new
                {
                    PropertyId = c.Int(nullable: false, identity: true),
                    Value = c.String(nullable:false),
                    Type = c.Int(nullable: true),
                    Status = c.Int(nullable: true),
                }).PrimaryKey(t => t.PropertyId);
        }

        public override void Down()
        {
            DropTable("dbo.Globals");
        }
    }
}
