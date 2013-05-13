using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PostRoom.Data
{
    public class PostRoomDataContext : DbContext
    {
        public IDbSet<Estate> Estates { get; set; }
        public IDbSet<Building> Buildings { get; set; }
        public IDbSet<Apartment> Apartments { get; set; }
        public IDbSet<Resident> Residents { get; set; }
        public IDbSet<Delivery> Deliveries { get; set; }
        public IDbSet<UserProfile> UserProfiles { get; set; }
    }
}
