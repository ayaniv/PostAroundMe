using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

public partial class Controls_Footer2 : BaseControl
{
    

    protected void Page_Load(object sender, EventArgs e)
    {
        ltrlCopyright.Text = (String)GetGlobalResourceObject("Resource", "Copyright"); 
        FooterText.Text = (String)GetGlobalResourceObject("Resource", "FooterText");

        lnkPostAroundMe.Text = (String)GetGlobalResourceObject("Resource", "PostAroundMe");
        lnkPostAroundMe.NavigateUrl = siteUrl;

        lnkSiteLinks.Text = (String)GetGlobalResourceObject("Resource", "SiteLinks");
        lnkSiteLinks.NavigateUrl = Site + "Sitelinks.aspx";

        lnkBlog.Text = (String)GetGlobalResourceObject("Resource", "Blog");
        lnkBlog.NavigateUrl = "http://blog.postaround.me";

        lnkContact.Text = (String)GetGlobalResourceObject("Resource", "Contact");
        lnkContact.NavigateUrl = "mailto:yaniv@postaround.me";

        lnkTerms.Text = (String)GetGlobalResourceObject("Resource", "Terms");
        lnkTerms.NavigateUrl = siteUrl + "Pages/Terms.aspx";

        lnkPrivacy.Text = (String)GetGlobalResourceObject("Resource", "Privacy");
        lnkPrivacy.NavigateUrl = siteUrl + "Pages/Privacy.aspx";



    }
}