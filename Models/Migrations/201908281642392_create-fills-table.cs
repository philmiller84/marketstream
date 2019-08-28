namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;

    public partial class createfillstable : DbMigration

    {
        public override void Up()
        {
            CreateTable("dbo.Fills",
                c => new
                {
                    FillId = c.Int(nullable: false, identity: true),
                    Price = c.Decimal(nullable: false, precision: 18, scale: 2),
                    Size = c.Decimal(nullable: false, precision: 18, scale: 10),
                    OrderId = c.Int(nullable: true),
                }).PrimaryKey(t => t.FillId);
        }

        public override void Down()
        {
            DropTable("dbo.Fills");
        }
    }
}
