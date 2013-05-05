namespace PostRoom.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddedFriendlyNametoApartment : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Apartments", "FriendlyName", c => c.String());
        }
        
        public override void Down()
        {
            DropColumn("dbo.Apartments", "FriendlyName");
        }
    }
}
