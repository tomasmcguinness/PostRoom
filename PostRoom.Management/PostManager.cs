using PostRoom.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PostRoom.Management
{
    public class PostManager
    {
        public void RecordDelivery(long apartmentId, string recipient)
        {
            using (var ctx = new PostRoomDataContext())
            {
                ctx.Deliveries.Add(new Delivery()
                {
                    ApartmentId = apartmentId,
                    Recipient = recipient,
                    DeliveryDate = DateTime.UtcNow
                });

                ctx.SaveChanges();
            }
        }

        public int GetTotalOutstandingPackagesForBuilding(long buildingId)
        {
            using (var ctx = new PostRoomDataContext())
            {
                var package = (from d in ctx.Deliveries
                               join a in ctx.Apartments on d.ApartmentId equals a.ApartmentId
                               where a.BuildingId == buildingId
                               select d).Count();

                return package;
            }
        }

        internal int GetTotalOutstandingPackagesForApartment(long apartmentId)
        {
            using (var ctx = new PostRoomDataContext())
            {
                var package = (from d in ctx.Deliveries
                               join a in ctx.Apartments on d.ApartmentId equals a.ApartmentId
                               where a.ApartmentId == apartmentId
                               select d).Count();

                return package;
            }
        }
    }
}
