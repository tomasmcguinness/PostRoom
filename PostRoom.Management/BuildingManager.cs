using PostRoom.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PostRoom.Management
{
    public class PropertyManager
    {
        private PostRoomDataContext context;

        public PropertyManager()
        {
            context = new PostRoomDataContext();
        }

        public List<Estate> GetEstates()
        {
            return context.Estates.ToList();
        }

        public List<Building> GetBuildingsForEstate(long estateId)
        {
            return context.Estates.Find(estateId).Buildings.ToList();
        }

        public List<Data.Apartment> GetApartmentsForBuilding(long buildingId)
        {
            ////using (var ctx = new PostRoomDataContext())
            ////{
            //var deliveries = (from d in ctx.Deliveries
            //                  join a in ctx.Apartments on d.ApartmentId equals a.ApartmentId
            //                  where a.ApartmentId == apartmentId && d.CollectionDate.HasValue == false
            //                  select d);

            //return deliveries.ToList();
            ////}
            return context.Buildings.Find(buildingId).Apartments.ToList();
        }
    }
}
