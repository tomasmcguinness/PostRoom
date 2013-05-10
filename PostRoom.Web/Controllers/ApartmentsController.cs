using PostRoom.Data;
using PostRoom.Management;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PostRoom.Web.Controllers
{
    public class ApartmentsController : Controller
    {
        private ApartmentManager apartmentManager;

        public ApartmentsController()
        {
            apartmentManager = new ApartmentManager();
        }

        public ActionResult SearchApartments(string query)
        {
            var results = apartmentManager.SearchApartments(query);
            return Json(results, JsonRequestBehavior.AllowGet);
        }
    }
}
