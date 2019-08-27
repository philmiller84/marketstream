namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class addstrategytable : DbMigration
    {
        public override void Up()
        {
            CreateTable("dbo.Strategies",
                c => new
                {
                    StrategyId = c.Int(nullable: false, identity: true),
                    Type = c.Single(nullable: true),
                    Status = c.Int(nullable: true)
                }).PrimaryKey(t => t.StrategyId);
        }
        
        
        
        public override void Down()
        {
        }
    }
}
