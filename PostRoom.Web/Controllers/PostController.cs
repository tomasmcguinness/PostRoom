using PostRoom.Management;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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
            var buildings = buildingManager.GetBuildingsForEstate(estateId);
            return View(buildings);
        }
    }
}
