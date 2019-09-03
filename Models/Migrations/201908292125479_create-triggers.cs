namespace Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class createtriggers : DbMigration
    {
        public override void Up()
        {
            this.Sql(Properties.Resources.Create_GetLogLevel);
            this.Sql(Properties.Resources.Create_sp_log_event);
            this.Sql(Properties.Resources.Create_sp_down_up_strategy);
            this.Sql(Properties.Resources.Create_sp_add_trend);
            this.Sql(Properties.Resources.Create_tr_WatchTicker);
            this.Sql(Properties.Resources.Create_tr_WatchTrend);
            this.Sql(Properties.Resources.Create_tr_WatchStrategy);
            this.Sql(Properties.Resources.Create_tr_AllocateOrder);
            this.Sql(Properties.Resources.Create_tr_WatchOrder);
            this.Sql(Properties.Resources.Create_tr_WatchDownUpStrategy);
            this.Sql(Properties.Resources.Create_tr_WatchFills);
            this.Sql(Properties.Resources.Create_tr_WatchPosition);
            this.Sql(Properties.Resources.Create_tr_WatchFund);
        }

        public override void Down()
        {
            this.Sql(Properties.Resources.Drop_tr_WatchFund);
            this.Sql(Properties.Resources.Drop_tr_WatchPosition);
            this.Sql(Properties.Resources.Drop_tr_WatchFills);
            this.Sql(Properties.Resources.Drop_tr_WatchDownUpStrategy);
            this.Sql(Properties.Resources.Drop_tr_AllocateOrder);
            this.Sql(Properties.Resources.Drop_tr_WatchOrder);
            this.Sql(Properties.Resources.Drop_tr_WatchStrategy);
            this.Sql(Properties.Resources.Drop_tr_WatchTrend);
            this.Sql(Properties.Resources.Drop_tr_WatchTicker);
            this.Sql(Properties.Resources.Drop_sp_add_trend);
            this.Sql(Properties.Resources.Drop_sp_down_up_strategy);
            this.Sql(Properties.Resources.Drop_sp_log_event);
            this.Sql(Properties.Resources.Drop_GetLogLevel);
        }
    }
}
