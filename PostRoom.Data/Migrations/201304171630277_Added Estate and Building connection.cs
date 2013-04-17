namespace PostRoom.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddedEstateandBuildingconnection : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Buildings", "Name", c => c.String());
            AddColumn("dbo.Buildings", "Estate_EstateId", c => c.Long());
            AddForeignKey("dbo.Buildings", "Estate_EstateId", "dbo.Estates", "EstateId");
            CreateIndex("dbo.Buildings", "Estate_EstateId");
        }
        
        public override void Down()
        {
            DropIndex("dbo.Buildings", new[] { "Estate_EstateId" });
            DropForeignKey("dbo.Buildings", "Estate_EstateId", "dbo.Estates");
            DropColumn("dbo.Buildings", "Estate_EstateId");
            DropColumn("dbo.Buildings", "Name");
        }
    }
}
