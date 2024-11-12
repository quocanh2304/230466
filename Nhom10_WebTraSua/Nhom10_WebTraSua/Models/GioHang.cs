using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Nhom10_WebTraSua.Controllers;
using Nhom10_WebTraSua.Models;
using System.Data.SqlClient;
namespace Nhom10_WebTraSua.Models
{
    public class GioHang
    {
        QuanLyTraSuaDataContext db = new QuanLyTraSuaDataContext();
        private string hinhAnh;

        public string HinhAnh
        {
            get { return hinhAnh; }
            set { hinhAnh = value; }
        }
        private int maSP;

        public int MaSP
        {
            get { return maSP; }
            set { maSP = value; }
        }
        private string tenSP;

        public string TenSP
        {
            get { return tenSP; }
            set { tenSP = value; }
        }
        private string kichThuoc;

        public string KichThuoc
        {
            get { return kichThuoc; }
            set { kichThuoc = value; }
        }
        private int soLuong;

        public int SoLuong
        {
            get { return soLuong; }
            set { soLuong = value; }
        }
        private string topping;

        public string Topping
        {
            get { return topping; }
            set { topping = value; }
        }
        private float donGia;

        public float DonGia
        {
            get { return donGia; }
            set { donGia = value; }
        }

        public float TinhTongTien()
        {
            float tongTien = DonGia; 

            // Thêm phụ phí theo kích thước
            if (KichThuoc == "Nhỏ")
            {
                tongTien += 5000;
            }
            else if (KichThuoc == "Vừa")
            {
                tongTien += 7000;
            }
            else if (KichThuoc == "Lớn")
            {
                tongTien += 10000;
            }

            // Thêm giá topping nếu có
            if (!string.IsNullOrEmpty(Topping))
            {
                TOPPING toppingItem = db.TOPPINGs.FirstOrDefault(t => t.TEN == Topping);
                if (toppingItem != null && toppingItem.GIA.HasValue)
                {
                    tongTien += (float)toppingItem.GIA.Value;
                }
            }
            tongTien *= SoLuong;
            return tongTien;
        }

        public GioHang(int MASP,string TENKICHTHUOC, string TENTOPPING)
        {
            MaSP = MASP;
            SANPHAM sp = db.SANPHAMs.Single(s => s.MASP == MaSP);
            HinhAnh = sp.HINHANH;
            TenSP = sp.TENSP;
            KichThuoc = TENKICHTHUOC;
            KICHTHUOC kt= db.KICHTHUOCs.Single(s=>s.TENKICHTHUOC==KichThuoc);
            if(kt==null)
            {
                throw new Exception("Kích thước không hợp lệ!");
            }
            SoLuong = 1;
            Topping = TENTOPPING;
            if (!string.IsNullOrEmpty(Topping))
            {
                TOPPING tp = db.TOPPINGs.SingleOrDefault(t => t.TEN == Topping);
                if (tp == null)
                {
                    throw new Exception("Topping không hợp lệ!");
                }
            }
            DonGia = (float)sp.GIA;
        }
    }
}