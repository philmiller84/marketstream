namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class minortablechanges : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Globals", "Description", c => c.String());
            AlterColumn("dbo.Funds", "Value", c => c.Decimal(nullable: false, precision: 18, scale: 10));
            AlterColumn("dbo.Globals", "Value", c => c.Decimal(nullable: false, precision: 18, scale: 10));
            DropColumn("dbo.Funds", "AllocationId");
            DropColumn("dbo.Globals", "Type");
            DropColumn("dbo.Globals", "Status");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Globals", "Status", c => c.Int(nullable: false));
            AddColumn("dbo.Globals", "Type", c => c.Int(nullable: false));
            AddColumn("dbo.Funds", "AllocationId", c => c.Int(nullable: false));
            AlterColumn("dbo.Globals", "Value", c => c.String());
            AlterColumn("dbo.Funds", "Value", c => c.Decimal(nullable: false, precision: 18, scale: 2));
            DropColumn("dbo.Globals", "Description");
        }
    }
}
