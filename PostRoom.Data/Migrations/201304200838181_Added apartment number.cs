namespace PostRoom.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class Addedapartmentnumber : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Apartments", "Number", c => c.Int(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.Apartments", "Number");
        }
    }
}
