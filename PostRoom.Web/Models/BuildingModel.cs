using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PostRoom.Web.Models
{
    public class BuildingModel
    {
        public long BuildingId { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }
    }
}