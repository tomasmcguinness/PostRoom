﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PostRoom.Web.Models
{
    public class DeliveryItemModel
    {
        public long DeliveryId { get; set; }
        public DateTime Date { get; set; }
        public string Name { get; set; }
    }
}