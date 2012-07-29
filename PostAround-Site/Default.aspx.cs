using System;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using PostAroundService;
using PostAround.Entities;
using System.Collections.Generic;

public partial class _Default : System.Web.UI.Page 
{
    protected string siteUrl;
    //protected string homePage;
    

    //User currentUser;
    protected void Page_Load(object sender, EventArgs e)
    {
        siteUrl = ConfigurationManager.AppSettings["SiteUrl"];
        //homePage = ConfigurationManager.AppSettings["HomePage"];

        //int ID = 1;
        //if (Request.Cookies["PostAroundUserCookie"] != null)
        //    ID = Convert.ToInt32(Request.Cookies["PostAroundUserCookie"].Value);

        if (Tools.IsDirectLink(Context))
        {
            // go to bring post by id and show it on server
        }


    }


    

  
}
