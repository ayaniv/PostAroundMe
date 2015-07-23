using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for BaseControl
/// </summary>
public class BaseControl : System.Web.UI.UserControl
{
    
    protected string domain;
    protected string siteUrl;
    protected string siteUrlSecured;

    protected override void OnInit(EventArgs e)
    {
        domain = ConfigurationManager.AppSettings["Domain"]; 
        siteUrl = ConfigurationManager.AppSettings["SiteUrl"];
        siteUrlSecured = ConfigurationManager.AppSettings["SiteUrlSecured"];
        
        if (Tools.GetProtocol(HttpContext.Current).Equals("https"))
        {
            siteUrl = siteUrl.Replace("http://", "https://");
        }

        

    }


   


	public BaseControl()
	{
		//
		// TODO: Add constructor logic here
		//
	}
}