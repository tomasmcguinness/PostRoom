using PostRoom.Data;
using PostRoom.Management;
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
    public class PropertyController : ApiController
    {
        private PropertyManager propertyManager;

        public PropertyController()
        {
            this.propertyManager = new PropertyManager();
        }

        [HttpGet]
        public HttpResponseMessage Estates()
        {
            var estateList = propertyManager.GetEstates();

            var estateModelList = new List<EstateModel>();

            foreach (var estate in estateList)
            {
                estateModelList.Add(new EstateModel() { EstateId = estate.EstateId, Name = estate.Name });
            }

            return new HttpResponseMessage(HttpStatusCode.OK)
            {
                Content = new ObjectContent<List<EstateModel>>(estateModelList, new JsonMediaTypeFormatter())
            };
        }

        [HttpGet]
        public HttpResponseMessage Buildings(long estateId)
        {
            var buildingList = propertyManager.GetBuildingsForEstate(estateId);

            var modelList = new List<BuildingModel>();

            foreach (var building in buildingList)
            {
                modelList.Add(new BuildingModel() { BuildingId = building.BuildingId, Name = building.Name });
            }

            return new HttpResponseMessage(HttpStatusCode.OK)
            {
                Content = new ObjectContent<List<BuildingModel>>(modelList, new JsonMediaTypeFormatter())
            };
        }

        [HttpGet]
        public HttpResponseMessage Apartments(long buildingId)
        {
            var apartmentList = propertyManager.GetApartmentsForBuilding(buildingId);

            var modelList = new List<ApartmentModel>();

            foreach (var apartment in apartmentList)
            {
                modelList.Add(new ApartmentModel() { ApartmentId = apartment.ApartmentId, ApartmentNumber = apartment.Number });
            }

            return new HttpResponseMessage(HttpStatusCode.OK)
            {
                Content = new ObjectContent<List<ApartmentModel>>(modelList, new JsonMediaTypeFormatter())
            };
        }
    }
}
