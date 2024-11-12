using Nhom10_WebTraSua.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Nhom10_WebTraSua.Controllers
{
    public class SanPhamController : Controller
    {
        //
        // GET: /SanPham/


        QuanLyTraSuaDataContext db = new QuanLyTraSuaDataContext();

        public ActionResult MenuParital()
        {
            return View();
        }

        public ActionResult SanPhamDongGoiPartial()
        {
            List<SANPHAM> _ds = db.SANPHAMs.Where(t => t.MALOAI == 6).Select(t => t).OrderBy(t => t.TENSP).Skip(0).Take(5).ToList();
            return PartialView(_ds);
        }
    }
}
