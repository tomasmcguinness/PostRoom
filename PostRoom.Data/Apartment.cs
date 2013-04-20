using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PostRoom.Data
{
    public class Apartment
    {
        public long ApartmentId { get; set; }
        public int Number { get; set; }

        public virtual ICollection<Delivery> Deliveries { get; set; }
    }
}
