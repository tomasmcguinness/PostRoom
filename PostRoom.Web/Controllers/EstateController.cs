using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PostRoom.Web.Controllers
{
    [Authorize]
    public class EstateController : Controller
    {
        public ActionResult Index()
        {
            return RedirectToAction("Index", "Post", new { estateId = 1 });
        }
    }
}
