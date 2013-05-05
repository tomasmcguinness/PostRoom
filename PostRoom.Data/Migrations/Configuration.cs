namespace PostRoom.Data.Migrations
{
    using System;
    using System.Collections.Generic;
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

            var building = new Building() { Name = "Slipway House", Estate = newEstate };
            context.Buildings.AddOrUpdate(building);

            building.Apartments = new List<Apartment>();

            for (int i = 1; i < 55; i++)
            {
                var apartment = new Apartment() { Number = i };
                apartment.FriendlyName = string.Format("{0} {1}", i, building.Name);
                building.Apartments.Add(apartment);
            }

            building = new Building() { Name = "Plate House", Estate = newEstate };
            context.Buildings.AddOrUpdate(building);

            building = new Building() { Name = "Traffrail House", Estate = newEstate };
            context.Buildings.AddOrUpdate(building);

            building = new Building() { Name = "Chart House", Estate = newEstate };
            context.Buildings.AddOrUpdate(building);

            building = new Building() { Name = "Wheel House", Estate = newEstate };
            context.Buildings.AddOrUpdate(building);

            context.SaveChanges();
        }
    }
}
