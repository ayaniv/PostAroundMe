﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

public partial class Controls_FacebookLike : BaseControl
{
    public static string FaceBookAppKey;
    public static string pageUrl;
    protected void Page_Load(object sender, EventArgs e)
    {
        FaceBookAppKey = ConfigurationManager.AppSettings["facebookAppKey"];
        pageUrl = Request.Url.Scheme + "://" + Request.Url.Authority + Request.RawUrl;
    }
}