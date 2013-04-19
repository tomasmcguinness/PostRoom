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
            context.Estates.AddOrUpdate(newEstate);

            var house = new Building() { Name = "Slipway House", Estate = newEstate };
            context.Buildings.AddOrUpdate(house);

            house = new Building() { Name = "Plate House", Estate = newEstate };
            context.Buildings.AddOrUpdate(house);

            house = new Building() { Name = "Traffrail House", Estate = newEstate };
            context.Buildings.AddOrUpdate(house);

            house = new Building() { Name = "Chart House", Estate = newEstate };
            context.Buildings.AddOrUpdate(house);

            house = new Building() { Name = "Wheel House", Estate = newEstate };
            context.Buildings.AddOrUpdate(house);

            context.SaveChanges();
        }
    }
}
