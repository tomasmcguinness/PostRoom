﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PostRoom.Web.Models
{
    public class ApartmentModel
    {
        public long ApartmentId { get; set; }
        public string FriendlyName { get; set; }
        public int DeliveryCount { get; set; }
    }
}