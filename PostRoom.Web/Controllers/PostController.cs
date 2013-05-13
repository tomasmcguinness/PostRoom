using Newtonsoft.Json.Serialization;
using PostRoom.Management;
using PostRoom.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PostRoom.Web.Controllers
{
    [Authorize]
    public class PostController : Controller
    {
        private PropertyManager buildingManager;
        private PostManager postManager;

        public PostController()
        {
            buildingManager = new PropertyManager();
            postManager = new PostManager();
        }

        public ActionResult Index(long estateId)
        {
            return View(estateId);
        }

        public JsonResult Post(long estateId)
        {
            var buildings = buildingManager.GetBuildingsForEstate(estateId);

            var buildingModels = new List<BuildingModel>();

            foreach (var building in buildings)
            {
                buildingModels.Add(new BuildingModel() { BuildingId = building.BuildingId, Name = building.Name });
            }

            return Json(buildingModels, JsonRequestBehavior.AllowGet);
        }

        [OutputCache(Duration = 0)]
        public JsonResult OutstandingPackagesForBuilding(long buildingId)
        {
            var packageCount = postManager.GetTotalOutstandingPackagesForBuilding(buildingId);
            return Json(packageCount, JsonRequestBehavior.AllowGet);
        }

        [OutputCache(Duration = 0)]
        public JsonResult Apartments(long buildingId)
        {
            var apartments = buildingManager.GetApartmentsForBuilding(buildingId);

            var apartmentModels = new List<ApartmentModel>();

            foreach (var apartment in apartments)
            {
                apartmentModels.Add(new ApartmentModel() { ApartmentId = apartment.ApartmentId, FriendlyName = apartment.FriendlyName, DeliveryCount = apartment.Deliveries.Where(d => d.CollectionDate == null).Count() });
            }

            return Json(apartmentModels, JsonRequestBehavior.AllowGet);
        }

        public JsonResult RecordDelivery(long apartmentId, string recipient)
        {
            postManager.RecordDelivery(apartmentId, recipient);
            return Json(true);
        }

        //[HttpPost]
        public JsonResult MarkDeliveryAsCollected(long deliveryId)
        {
            postManager.MarkDeliveryAsCollected(deliveryId);
            return Json(true);
        }

        //[HttpPost]
        public JsonResult MarkAllDeliveriesAsCollected(long apartmentId)
        {
            postManager.MarkAllDeliveriesAsCollected(apartmentId);
            return Json(true);
        }

        [OutputCache(Duration = 0)]
        public JsonResult DeliveriesForApartment(long apartmentId)
        {
            var items = postManager.GetItemsForCollection(apartmentId);

            var packageModels = new List<DeliveryItemModel>();

            foreach (var apartment in items)
            {
                packageModels.Add(new DeliveryItemModel() { DeliveryId = apartment.DeliveryId, Date = apartment.DeliveryDate, Name = apartment.Recipient });
            }

            return Json(packageModels, JsonRequestBehavior.AllowGet);
        }
    }
}
