using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PostRoom.Data
{
    public class Resident
    {
        public long ResidentId { get; set; }
        public virtual Apartment Apartment { get; set; }

        public long ApartmentId { get; set; }
        public string DeviceIdentifier { get; set; }
        public string UniqueIdentifier { get; set; }
        public bool AlertOnNewParcel { get; set; }
    }
}
