namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class refactor_add_trend : DbMigration
    {
        public override void Up()
        {
            this.Sql(Properties.Resources.Create_sp_add_strategy);
        }

        public override void Down()
        {
            this.Sql(Properties.Resources.Drop_sp_add_strategy);
        }
    }
}
