using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class channel : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string cacheExpire = "31536000";
        Response.AddHeader("Pragma", "public");
        Response.AddHeader("Cache-Control", "max-age=" + cacheExpire);
        Response.AddHeader("Expires", DateTime.Now.AddYears(1).ToString("ddd, dd MMM yyyy HH':'mm':'ss 'GMT'"));
    }
}