using System.Web;
using System.Web.Mvc;

namespace Nhom10_WebTraSua
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}