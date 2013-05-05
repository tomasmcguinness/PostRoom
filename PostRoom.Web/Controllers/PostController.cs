using Newtonsoft.Json.Serialization;
using PostRoom.Management;
using PostRoom.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;

namespace PostRoom.Web.Controllers
{
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

        public JsonResult OutstandingPackagesForBuilding(long buildingId)
        {
            var packageCount = postManager.GetTotalOutstandingPackagesForBuilding(buildingId);
            return Json(packageCount, JsonRequestBehavior.AllowGet);
        }

        public JsonResult Apartments(long buildingId)
        {
            var apartments = buildingManager.GetApartmentsForBuilding(buildingId);
            return Json(apartments, JsonRequestBehavior.AllowGet);
        }

        public JsonResult RecordDelivery(long apartmentId, string recipient)
        {
            postManager.RecordDelivery(apartmentId, recipient);
            return Json(true);
        }
    }
}
