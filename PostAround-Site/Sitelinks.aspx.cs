using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using PostAroundService;
using PostAround.Entities;
using System.Net;

public partial class Sitelinks : System.Web.UI.Page
{
    protected string SiteUrl;
    protected void Page_Load(object sender, EventArgs e)
    {

        SiteUrl = ConfigurationManager.AppSettings["SiteUrl"];
        PostAroundServiceClient client = new PostAroundServiceClient();
        client.CreateJsonPostsDigest();

        WebClient webclient = new WebClient();

        webclient.Encoding = System.Text.Encoding.UTF8; 
        string jsonString = webclient.DownloadString(SiteUrl + "Pages/json.txt");
        
        

        System.Web.Script.Serialization.JavaScriptSerializer oSerializer =
        new System.Web.Script.Serialization.JavaScriptSerializer();

        List<BriefMessage> bMessages = oSerializer.Deserialize<List<BriefMessage>>(jsonString);
        

        rptLinks.DataSource = bMessages;
        
        rptLinks.DataBind();
    }
}