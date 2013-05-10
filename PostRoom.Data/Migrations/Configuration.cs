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
            var newEstate = new Estate() { Name = "Burrells Wharf", Latitude = 51.487582, Longitude = -0.019854 };
            context.Estates.AddOrUpdate(newEstate);

            Building building;

            building = new Building() { Name = "Beacon House", Estate = newEstate };
            context.Buildings.AddOrUpdate(building);

            AddApartmentsToBuilding(building, 1, 37);

            building = new Building() { Name = "Brunel House", Estate = newEstate };
            context.Buildings.AddOrUpdate(building);

            AddApartmentsToBuilding(building, 1, 42);

            building = new Building() { Name = "Chart House", Estate = newEstate };
            context.Buildings.AddOrUpdate(building);

            AddApartmentsToBuilding(building, 1, 11);
            AddApartmentsToBuilding(building, 101, 112);
            AddApartmentsToBuilding(building, 201, 212);
            AddApartmentsToBuilding(building, 301, 313);
            AddApartmentsToBuilding(building, 401, 411);
            AddApartmentsToBuilding(building, 501, 506);
            AddApartmentsToBuilding(building, 601, 606);
            AddApartmentsToBuilding(building, 701, 706);
            AddApartmentsToBuilding(building, 801, 803);

            building = new Building() { Name = "Corsair House", Estate = newEstate };
            context.Buildings.AddOrUpdate(building);

            AddApartmentsToBuilding(building, 1, 3);

            building = new Building() { Name = "Gate House", Estate = newEstate };
            context.Buildings.AddOrUpdate(building);

            AddApartmentsToBuilding(building, 1, 6);

            building = new Building() { Name = "Plate House", Estate = newEstate };
            context.Buildings.AddOrUpdate(building);

            AddApartmentsToBuilding(building, 1, 20);
            AddApartmentToBuilding(building, 20, "20b");
            AddApartmentToBuilding(building, 21, "21");
            AddApartmentToBuilding(building, 22, "22b");
            AddApartmentsToBuilding(building, 22, 23);
            AddApartmentToBuilding(building, 23, "23b");
            AddApartmentsToBuilding(building, 25, 25);
            AddApartmentsToBuilding(building, 101, 101);
            AddApartmentsToBuilding(building, 301, 312);
            AddApartmentsToBuilding(building, 401, 413);

            building = new Building() { Name = "Port House", Estate = newEstate };
            context.Buildings.AddOrUpdate(building);

            AddApartmentsToBuilding(building, 1, 11);

            building = new Building() { Name = "Riverway House", Estate = newEstate };
            context.Buildings.AddOrUpdate(building);

            AddApartmentToBuilding(building, 1, "1a");
            AddApartmentToBuilding(building, 2, "2a");
            AddApartmentToBuilding(building, 3, "3a");
            AddApartmentsToBuilding(building, 1, 6);

            building = new Building() { Name = "Slipway House", Estate = newEstate };
            context.Buildings.AddOrUpdate(building);

            building.Apartments = new List<Apartment>();

            AddApartmentsToBuilding(building, 1, 3);
            AddApartmentsToBuilding(building, 5, 13);
            AddApartmentsToBuilding(building, 15, 23);
            AddApartmentsToBuilding(building, 25, 43);
            AddApartmentsToBuilding(building, 45, 54);

            building = new Building() { Name = "Traffrail House", Estate = newEstate };
            context.Buildings.AddOrUpdate(building);

            AddApartmentsToBuilding(building, 1, 3);
            AddApartmentsToBuilding(building, 5, 13);
            AddApartmentsToBuilding(building, 15, 23);
            AddApartmentsToBuilding(building, 25, 43);

            building = new Building() { Name = "Wheel House", Estate = newEstate };
            context.Buildings.AddOrUpdate(building);

            AddApartmentsToBuilding(building, 1, 77);

            context.SaveChanges();
        }

        private void AddApartmentsToBuilding(Building building, int startRange, int endRange)
        {
            if (building.Apartments == null)
                building.Apartments = new List<Apartment>();

            for (int i = startRange; i <= endRange; i++)
            {
                var apartment = new Apartment() { Number = i };
                apartment.FriendlyName = string.Format("{0} {1}", i, building.Name);
                building.Apartments.Add(apartment);
            }
        }

        private void AddApartmentToBuilding(Building building, int number, string friendlyName)
        {
            if (building.Apartments == null)
                building.Apartments = new List<Apartment>();

            var apartment = new Apartment() { Number = number };
            apartment.FriendlyName = friendlyName;
            building.Apartments.Add(apartment);
        }
    }
}
