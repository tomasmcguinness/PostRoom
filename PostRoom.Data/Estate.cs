using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PostRoom.Data
{
    public class Estate
    {
        public long EstateId { get; set; }
        public string Name { get; set; }

        public double? Latitude { get; set; }
        public double? Longitude { get; set; }

        public virtual ICollection<Building> Buildings { get; set; }
    }
}
