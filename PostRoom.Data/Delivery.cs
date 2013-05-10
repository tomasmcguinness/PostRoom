using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PostRoom.Data
{
    public class Delivery
    {
        public long DeliveryId { get; set; }
        public DateTime DeliveryDate { get; set; }
        public string Recipient { get; set; }
        public long ApartmentId { get; set; }

        [ForeignKey("ApartmentId")]
        public virtual Apartment Apartment { get; set; }

        public DateTime? CollectionDate { get; set; }
    }
}
