namespace PostRoom.Data.Migrations
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Linq;

    internal sealed class Configuration : DbMigrationsConfiguration<PostRoom.Data.PostRoomDataContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
        }

        protected override void Seed(PostRoom.Data.PostRoomDataContext context)
        {
            var newEstate = new Estate() { Name = "Burrells Wharf" };
            context.Estates.Add(newEstate);

            var house1 = new Building() { Name = "Slipway House" };
            house1.Estate = newEstate;

            context.SaveChanges();

              //  This method will be called after migrating to the latest version.

              //  You can use the DbSet<T>.AddOrUpdate() helper extension method 
              //  to avoid creating duplicate seed data. E.g.
              //
              //    context.People.AddOrUpdate(
              //      p => p.FullName,
              //      new Person { FullName = "Andrew Peters" },
              //      new Person { FullName = "Brice Lambson" },
              //      new Person { FullName = "Rowan Miller" }
              //    );
              //
        }
    }
}
