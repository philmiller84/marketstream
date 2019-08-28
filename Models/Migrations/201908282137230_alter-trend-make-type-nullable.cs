namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class altertrendmaketypenullable : DbMigration
    {
        public override void Up()
        {
            AlterColumn("dbo.Trends", "Type", c => c.Int());
        }
        
        public override void Down()
        {
            AlterColumn("dbo.Trends", "Type", c => c.Int(nullable: false));
        }
    }
}
