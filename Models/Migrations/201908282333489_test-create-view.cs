namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class testcreateview : DbMigration
    {
        public override void Up()
        {
            this.Sql(Properties.Resources.Create_V_Orders);
        }
        
        public override void Down()
        {
            this.Sql(Properties.Resources.Drop_V_Orders);
        }
    }
}
