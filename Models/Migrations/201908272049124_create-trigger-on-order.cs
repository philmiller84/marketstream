namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class createtriggeronorder : DbMigration
    {
        public override void Up()
        {
            this.Sql(Properties.Resources.Create_tr_WatchOrder);
        }
        
        public override void Down()
        {
            this.Sql(Properties.Resources.Drop_tr_WatchOrder);
        }
    }
}
