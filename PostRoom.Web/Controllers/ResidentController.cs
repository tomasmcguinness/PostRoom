﻿using PostRoom.Management;
using PostRoom.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Formatting;
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

        public HttpResponseMessage Get(string uniqueUserIdentifier)
        {
            int numberOfItems = residentManager.GetNumberOfItemsToCollection(uniqueUserIdentifier);

            ResidentStatusModel model = new ResidentStatusModel()
            {
                NumberOfItemsToCollect = numberOfItems
            };

            return new HttpResponseMessage(HttpStatusCode.OK)
            {
                Content = new ObjectContent<ResidentStatusModel>(model, new JsonMediaTypeFormatter())
            };
        }

        public HttpResponseMessage Put(string uniqueUserIdentifier,long apartmentId)
        {
            residentManager.AddResident(uniqueUserIdentifier, apartmentId); 
            return new HttpResponseMessage(HttpStatusCode.OK);
        }

        public HttpResponseMessage Post(string uniqueUserIdentifier, string deviceIdentifier, bool alertOnNewPackage)
        {
            residentManager.UpdateResident(uniqueUserIdentifier, deviceIdentifier, alertOnNewPackage);
            return new HttpResponseMessage(HttpStatusCode.OK);
        }
    }
}