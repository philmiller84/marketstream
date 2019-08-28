namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class createtriggerforfills : DbMigration
    {
        public override void Up()
        {
            this.Sql(Properties.Resources.Create_tr_WatchFills);
        }

        public override void Down()
        {
            this.Sql(Properties.Resources.Drop_tr_WatchFills);
        }
    }
}
