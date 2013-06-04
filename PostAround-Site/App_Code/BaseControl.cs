﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for BaseControl
/// </summary>
public class BaseControl : System.Web.UI.UserControl
{

    protected string siteUrl;
    protected override void OnInit(EventArgs e)
    {
        siteUrl = ConfigurationManager.AppSettings["SiteUrl"];
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