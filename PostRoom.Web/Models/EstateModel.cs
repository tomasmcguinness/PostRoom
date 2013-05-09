using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PostRoom.Web.Models
{
    public class EstateModel
    {
        public long EstateId { get; set; }
        public string Name { get; set; }

        public double Latitude { get; set; }

        public double Longitude { get; set; }
    }
}