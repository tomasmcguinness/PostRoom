namespace PostRoom.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class InitialCreate : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Estates",
                c => new
                    {
                        EstateId = c.Long(nullable: false, identity: true),
                        Name = c.String(),
                    })
                .PrimaryKey(t => t.EstateId);
            
            CreateTable(
                "dbo.Buildings",
                c => new
                    {
                        BuildingId = c.Long(nullable: false, identity: true),
                    })
                .PrimaryKey(t => t.BuildingId);
            
            CreateTable(
                "dbo.Residents",
                c => new
                    {
                        ResidentId = c.Long(nullable: false, identity: true),
                    })
                .PrimaryKey(t => t.ResidentId);
            
        }
        
        public override void Down()
        {
            DropTable("dbo.Residents");
            DropTable("dbo.Buildings");
            DropTable("dbo.Estates");
        }
    }
}
