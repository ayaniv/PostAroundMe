using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

public partial class Controls_Header3 : BaseControl
{

    
    private void HideWhenNeeded()
    {
        string page = System.IO.Path.GetFileNameWithoutExtension(HttpContext.Current.Request.Url.AbsoluteUri);
        page = page.ToLower();
        bool isSlimFit = page == "slimfit";
        if (isSlimFit)
        {
            TopHeader.Attributes.CssStyle.Add("display", "none");
        }

    }


    protected void Page_Load(object sender, EventArgs e)
    {
        HideWhenNeeded();
    }




}