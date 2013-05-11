using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_LoginMessgae : System.Web.UI.UserControl
{
    public static string siteUrl;
    protected void Page_Load(object sender, EventArgs e)
    {
        siteUrl = ConfigurationManager.AppSettings["SiteUrl"];

    }
}