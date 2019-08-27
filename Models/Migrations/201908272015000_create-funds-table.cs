namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class createfundstable : DbMigration
    {
        public override void Up()
        {
            CreateTable("dbo.Funds",
      c => new
      {
          FundId = c.Int(nullable: false, identity: true),
          Value = c.Decimal(nullable: false, precision: 18, scale: 2),
          Currency = c.Int(nullable: true),
          AllocationId = c.Int(nullable: true),
          AllocationType = c.Int(nullable: true),
          Status = c.Int(nullable: true),
      }).PrimaryKey(t => t.FundId);
        }
        
        public override void Down()
        {
            DropTable("dbo.Funds");
        }
    }
}
