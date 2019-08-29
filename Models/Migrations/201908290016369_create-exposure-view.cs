namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class createexposureview : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Positions",
                c => new
                    {
                        PositionId = c.Int(nullable: false, identity: true),
                        Size = c.Decimal(nullable: false, precision: 18, scale: 10),
                    })
                .PrimaryKey(t => t.PositionId);
            this.Sql(Properties.Resources.Create_V_Exposure);
        }
        
        public override void Down()
        {
            this.Sql(Properties.Resources.Drop_V_Exposure);
            DropTable("dbo.Positions");
        }
    }
}
