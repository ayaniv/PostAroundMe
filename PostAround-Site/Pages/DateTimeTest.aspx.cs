using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_DateTimeTest : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //TimeZoneInfo pacificZone = TimeZoneInfo.FindSystemTimeZoneById("Pacific Standard Time");
        //int UsTimeZone = pacificZone.BaseUtcOffset.Hours * -1;
        //        Response.Write(UsTimeZone);
        TimeZoneInfo localZone = TimeZoneInfo.Local;
        String str1 = "The {0} time zone is {1}:{2} {3} than Coordinated Universal Time. current time {4}. utc time is {5}";
        string output = String.Format(str1, localZone.DisplayName,
                          Math.Abs(localZone.BaseUtcOffset.Hours),
                          Math.Abs(localZone.BaseUtcOffset.Minutes),
                          (localZone.BaseUtcOffset >= TimeSpan.Zero) ? "later" : "earlier",
                          DateTime.Now,
                          DateTime.UtcNow
                          );
        Response.Write(output);
                          


    }
}