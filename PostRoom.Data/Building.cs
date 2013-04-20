using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PostRoom.Data
{
    public class Building
    {
        public long BuildingId { get; set; }
        public string Name { get; set; }

        public virtual ICollection<Apartment> Apartments { get; set; }
        public virtual Estate Estate { get; set; }
    }
}
