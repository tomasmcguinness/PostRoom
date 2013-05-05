using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PostRoom.Data
{
    public class Apartment
    {
        public long ApartmentId { get; set; }
        public int Number { get; set; }
        public string FriendlyName { get; set; }
        public long BuildingId { get; set; }
        [ForeignKey("BuildingId")]
        public virtual Building Building { get; set; }
        public virtual ICollection<Delivery> Deliveries { get; set; }
    }
}
