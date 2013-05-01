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

        public PostController()
        {
            buildingManager = new PropertyManager();
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

        public JsonResult OutstandingPackages(long buildingId)
        {
            return Json(12, JsonRequestBehavior.AllowGet);
        }

        public JsonResult Apartments(long buildingId)
        {
            var apartments = buildingManager.GetApartmentsForBuilding(buildingId);
            return Json(apartments, JsonRequestBehavior.AllowGet);
        }
    }
}
