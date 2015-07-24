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

    protected string lang;

    //User currentUser;
    protected void Page_Load(object sender, EventArgs e)
    {
        HideInSlimFit();
        if (lang != null && lang != "")
        {
            lang = lang.Split('-')[0];
            Page.Header.Controls.Add(
            new System.Web.UI.LiteralControl("<link rel=\"stylesheet\" type=\"text/css\" href=\"" + ResolveUrl("~/css/style_" + lang + ".css") + "\" />"));
        }
        

    }



    private void HideInSlimFit()
    {
        BottomDiv.Attributes.CssStyle.Add("display", "none");
    }

    protected override void InitializeCulture()
    {

        base.InitializeCulture();
        lang = Tools.GetLocale(Context);
        if (lang != null && lang != "" && lang != "en")
        {
            System.Threading.Thread.CurrentThread.CurrentUICulture = new CultureInfo(lang);
            System.Threading.Thread.CurrentThread.CurrentCulture = new CultureInfo(lang);
        }

        


    }




}
