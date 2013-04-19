namespace PostRoom.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class UpdatedApartment : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Apartments",
                c => new
                    {
                        ApartmentId = c.Long(nullable: false, identity: true),
                        Building_BuildingId = c.Long(),
                    })
                .PrimaryKey(t => t.ApartmentId)
                .ForeignKey("dbo.Buildings", t => t.Building_BuildingId)
                .Index(t => t.Building_BuildingId);
            
            AddColumn("dbo.Residents", "ApartmentId", c => c.Long(nullable: false));
            AddColumn("dbo.Residents", "DeviceIdentifier", c => c.String());
            AddColumn("dbo.Residents", "UniqueIdentifier", c => c.String());
            AddColumn("dbo.Residents", "AlertOnNewParcel", c => c.Boolean(nullable: false));
            AddForeignKey("dbo.Residents", "ApartmentId", "dbo.Apartments", "ApartmentId", cascadeDelete: true);
            CreateIndex("dbo.Residents", "ApartmentId");
        }
        
        public override void Down()
        {
            DropIndex("dbo.Residents", new[] { "ApartmentId" });
            DropIndex("dbo.Apartments", new[] { "Building_BuildingId" });
            DropForeignKey("dbo.Residents", "ApartmentId", "dbo.Apartments");
            DropForeignKey("dbo.Apartments", "Building_BuildingId", "dbo.Buildings");
            DropColumn("dbo.Residents", "AlertOnNewParcel");
            DropColumn("dbo.Residents", "UniqueIdentifier");
            DropColumn("dbo.Residents", "DeviceIdentifier");
            DropColumn("dbo.Residents", "ApartmentId");
            DropTable("dbo.Apartments");
        }
    }
}
