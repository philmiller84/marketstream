namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class addstrategyontickerupdate : DbMigration
    {
        public override void Up()
        {
            this.Sql(Properties.Resources.Create_tr_WatchTrend);
        }
        
        public override void Down()
        {
            this.Sql(Properties.Resources.Drop_sp_add_strategy);
        }
    }
}
