namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class createtriggerforstrategies : DbMigration
    {
         public override void Up()
        {
            this.Sql(Properties.Resources.Create_tr_WatchStrategy);
        }

        public override void Down()
        {
            this.Sql(Properties.Resources.Drop_tr_WatchStrategy);
        }
    }
}


