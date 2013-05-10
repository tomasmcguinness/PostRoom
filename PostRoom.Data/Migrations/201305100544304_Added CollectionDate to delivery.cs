namespace PostRoom.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddedCollectionDatetodelivery : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Deliveries", "CollectionDate", c => c.DateTime());
        }
        
        public override void Down()
        {
            DropColumn("dbo.Deliveries", "CollectionDate");
        }
    }
}
