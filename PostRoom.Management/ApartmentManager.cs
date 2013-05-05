using PostRoom.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PostRoom.Management
{
    public class ApartmentManager
    {
        public List<Apartment> SearchApartments(string search)
        {
            using (var ctx = new PostRoomDataContext())
            {
                var matchingApartments = ctx.Apartments.Where(a => a.FriendlyName.Contains(search)).ToList();

                List<Apartment> results = new List<Apartment>();

                foreach (var apartment in matchingApartments)
                {
                    results.Add(new Apartment() { ApartmentId = apartment.ApartmentId, FriendlyName = apartment.FriendlyName });
                }

                return results;
            }
        }
    }
}
