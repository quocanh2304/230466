using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Nhom10_WebTraSua.Models;
using System.Data;
using System.Data.SqlClient;
namespace Nhom10_WebTraSua.Controllers
{
    public class GioHangController : Controller
    {
        //
        // GET: /GioHang/
        QuanLyTraSuaDataContext db = new QuanLyTraSuaDataContext();

        public ActionResult Index()
        {
            return View();
        }

        public List<GioHang> LayGioHang()
        {
            List<GioHang> lstGioHang = Session["GioHang"] as List<GioHang>;
            if(lstGioHang==null)
            {
                lstGioHang = new List<GioHang>();
                Session["GioHang"] = lstGioHang;
            }
            return lstGioHang;
        }

        public ActionResult ThemGioHang(int msp,string tkt,string ttp, string strURL)
        {
            List<GioHang> lstGioHang = LayGioHang();
            GioHang sanPham = lstGioHang.Find(s => s.MaSP == msp&&s.KichThuoc==tkt&&s.Topping==ttp);          
            if(sanPham==null)
            {
                sanPham = new GioHang(msp,tkt,ttp);
                lstGioHang.Add(sanPham);
                return Redirect(strURL);
            }
            else
            {
                sanPham.SoLuong++;
                return Redirect(strURL);
            }
        }

        private int TongSoLuong()
        {
            int tsl = 0;
            List<GioHang> lstGioHang = Session["GioHang"] as List<GioHang>;
            if(lstGioHang!=null)
            {
                tsl = lstGioHang.Sum(s => s.SoLuong);
            }
            return tsl;
        }

        private double TongThanhTien()
        {
            double ttt = 0;
            List<GioHang> lstGioHang = Session["GioHang"] as List<GioHang>;
            if (lstGioHang != null)
            {
                ttt = lstGioHang.Sum(s => s.TinhTongTien());
            }
            return ttt;
        }

        public ActionResult GioHang()
        {
            //if(Session["GioHang"]==null)
            //{
            //    return RedirectToAction("GioHang", "GioHang");
            //}
            List<GioHang> lstGioHang = LayGioHang();
            ViewBag.TongSoLuong = TongSoLuong();
            ViewBag.TongThanhTien = TongThanhTien();
            return View(lstGioHang);
        }
    }
}
