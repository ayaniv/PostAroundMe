using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Error : BasePage
{
   
   
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void lnkClearCookie_Click(object sender, EventArgs e)
    {
        HttpCookie userCookie = new HttpCookie("UserInfo");
        userCookie.Expires = DateTime.Now.AddDays(-1);
        Response.Cookies.Add(userCookie);

        HttpCookie loginCookie = new HttpCookie("UserLogin");
        loginCookie.Expires = DateTime.Now.AddDays(-1);
        Response.Cookies.Add(loginCookie);

        HttpCookie fbCookie = new HttpCookie("FacebookServerCode");
        fbCookie.Expires = DateTime.Now.AddDays(-1);
        Response.Cookies.Add(fbCookie);
        
        Response.Redirect(siteUrl);
    }
}