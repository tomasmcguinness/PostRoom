using PostRoom.Management;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace PostRoom.Web.Controllers
{
    public class ResidentController : ApiController
    {
        private ResidentManager residentManager;

        public ResidentController()
        {
            this.residentManager = new ResidentManager();
        }

        public HttpResponseMessage Put(long apartmentId, string deviceIdentifier)
        {
            residentManager.AddResident(apartmentId, deviceIdentifier); 
            return new HttpResponseMessage(HttpStatusCode.OK);
        }
    }
}
