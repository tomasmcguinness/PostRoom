namespace PostRoom.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;

    public partial class AddedBuildingIdtoApartment : DbMigration
    {
        public override void Up()
        {
            DropForeignKey("dbo.Apartments", "Building_BuildingId", "dbo.Buildings");
            DropIndex("dbo.Apartments", new[] { "Building_BuildingId" });
            RenameColumn(table: "dbo.Apartments", name: "Building_BuildingId", newName: "BuildingId");
            AddForeignKey("dbo.Apartments", "BuildingId", "dbo.Buildings", "BuildingId", cascadeDelete: true);
            CreateIndex("dbo.Apartments", "BuildingId");
        }

        public override void Down()
        {
            DropIndex("dbo.Apartments", new[] { "BuildingId" });
            DropForeignKey("dbo.Apartments", "BuildingId", "dbo.Buildings");
            RenameColumn(table: "dbo.Apartments", name: "BuildingId", newName: "Building_BuildingId");
            CreateIndex("dbo.Apartments", "Building_BuildingId");
            AddForeignKey("dbo.Apartments", "Building_BuildingId", "dbo.Buildings", "BuildingId");
        }
    }
}
