using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using PostAroundService;

public partial class Sitelinks : System.Web.UI.Page
{
    protected string SiteUrl;
    protected void Page_Load(object sender, EventArgs e)
    {
        SiteUrl = ConfigurationManager.AppSettings["SiteUrl"];
        PostAroundServiceClient client = new PostAroundServiceClient();
        rptLinks.DataSource = client.GetAllBriefMessages(); ;
        rptLinks.DataBind();
    }
}