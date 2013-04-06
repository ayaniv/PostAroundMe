using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_FileUpload : System.Web.UI.UserControl
{
    protected string siteUrl;



    protected void Page_Load(object sender, EventArgs e)
    {
        siteUrl = ConfigurationManager.AppSettings["SiteUrl"];
        if (Tools.GetProtocol(HttpContext.Current).Equals("https"))
        {
            siteUrl = siteUrl.Replace("http://", "https://");
        }
    }
}