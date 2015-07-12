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
using System.Globalization;

public partial class _Default : BasePage 
{
   
    //protected string homePage;
   

    //User currentUser;
    protected void Page_Load(object sender, EventArgs e)
    {
    

    }

    protected override void InitializeCulture()
    {
        base.InitializeCulture();
        string lang = null;
        string lang_cookie = null;
        string lang_qs = Request.QueryString["lang"];
        HttpCookie cookie = Request.Cookies["i18next"];
        if (cookie != null )
        {
            lang_cookie = cookie.Value;
        }
        
        if (lang_qs != null  && lang_qs != "")
        {
            lang = lang_qs;
        } else
        {
            if (lang_cookie != null && lang_cookie != "")
            {
                lang = lang_cookie;
            }
        }
        if (lang != null && lang != "" && lang != "en")
        {
            System.Threading.Thread.CurrentThread.CurrentUICulture = new CultureInfo(lang);
            System.Threading.Thread.CurrentThread.CurrentCulture = new CultureInfo(lang);
        }
        
    }




}
