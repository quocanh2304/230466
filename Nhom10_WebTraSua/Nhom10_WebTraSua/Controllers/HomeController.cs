using Nhom10_WebTraSua.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Nhom10_WebTraSua.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /Home/
        QuanLyTraSuaDataContext db = new QuanLyTraSuaDataContext();
        public ActionResult Index()
        {
            List<SANPHAM> _ds = db.SANPHAMs.Select(t => t).ToList<SANPHAM>();
            return View(_ds);
        }



        [HttpPost]
        public ActionResult PhanHoi(PHANHOI phanhoi)
        {
          
            if (ModelState.IsValid)
            {
                db.PHANHOIs.InsertOnSubmit(phanhoi);
                db.SubmitChanges();
                TempData["FeedbackSuccess"] = true; // Đặt cờ thông báo thành công
                return RedirectToAction("Index");
            }
            return HttpNotFound();
        }

        public ActionResult LienHe()
        {
            return View();
        }

       
    }
}
