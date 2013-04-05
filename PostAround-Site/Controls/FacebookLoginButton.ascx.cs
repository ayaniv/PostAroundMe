using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

public partial class Controls_FacebookLoginButton : System.Web.UI.UserControl
{
    public static string FaceBookAppKey;
    public static string siteUrl;
    
    protected void Page_Load(object sender, EventArgs e)
    {

        FaceBookAppKey = ConfigurationManager.AppSettings["facebookAppKey"];
        siteUrl = ConfigurationManager.AppSettings["SiteUrl"];
        if (Tools.GetProtocol(HttpContext.Current).Equals("https"))
        {
            siteUrl = siteUrl.Replace("http://", "https://");
        }
    }

    protected void btnFacebook_Click(object sender, EventArgs e)
    {

        string url = "https://www.facebook.com/dialog/oauth?client_id={0}&redirect_uri={1}&scope=email,user_birthday";
        url = String.Format(url, FaceBookAppKey, HttpUtility.UrlEncode(siteUrl));
        Response.Redirect(url);
    }
}