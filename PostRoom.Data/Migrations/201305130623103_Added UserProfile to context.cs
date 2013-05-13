namespace PostRoom.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddedUserProfiletocontext : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.UserProfiles",
                c => new
                    {
                        UserProfileId = c.Long(nullable: false, identity: true),
                        EmailAddress = c.String(),
                        EstateId = c.Long(nullable: false),
                        DateCreated = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.UserProfileId);
            
        }
        
        public override void Down()
        {
            DropTable("dbo.UserProfiles");
        }
    }
}
