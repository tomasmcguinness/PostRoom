namespace PostRoom.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddedPost : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Deliveries",
                c => new
                    {
                        DeliveryId = c.Long(nullable: false, identity: true),
                        DeliveryDate = c.DateTime(nullable: false),
                        ApartmentId = c.Long(nullable: false),
                    })
                .PrimaryKey(t => t.DeliveryId)
                .ForeignKey("dbo.Apartments", t => t.ApartmentId, cascadeDelete: true)
                .Index(t => t.ApartmentId);
            
            AddColumn("dbo.Estates", "Latitude", c => c.Double());
            AddColumn("dbo.Estates", "Longitude", c => c.Double());
        }
        
        public override void Down()
        {
            DropIndex("dbo.Deliveries", new[] { "ApartmentId" });
            DropForeignKey("dbo.Deliveries", "ApartmentId", "dbo.Apartments");
            DropColumn("dbo.Estates", "Longitude");
            DropColumn("dbo.Estates", "Latitude");
            DropTable("dbo.Deliveries");
        }
    }
}
