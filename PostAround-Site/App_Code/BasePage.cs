using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for BasePage
/// </summary>
public class BasePage : System.Web.UI.Page
{
    protected string siteUrl;
    protected string siteUrlSecured;

    protected override void OnInit(EventArgs e)
    {
        siteUrl = ConfigurationManager.AppSettings["SiteUrl"];
        siteUrlSecured = ConfigurationManager.AppSettings["SiteUrlSecured"];

        if (Tools.GetProtocol(HttpContext.Current).Equals("https"))
        {
            siteUrl = siteUrl.Replace("http://", "https://");
        }


    }
	public BasePage()
	{
		//
		// TODO: Add constructor logic here
		//
	}
}