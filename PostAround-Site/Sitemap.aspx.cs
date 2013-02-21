using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PostAroundService;
using PostAround.Entities;
using System.Web.UI.HtmlControls;
using System.Configuration;
using System.Xml.Linq;

public partial class Pages_Sitemap : System.Web.UI.Page
{



    protected void Page_Load(object sender, EventArgs e)
    {

        PostAroundServiceClient client = new PostAroundServiceClient();
        int siteMapsCount = client.CreateXmlSiteMap();
        client.Close();
        List<int> lstIndexes = new List<int>();

        for (int i = 0; i <= siteMapsCount; i++)
        {
            lstIndexes.Add(i);
        }
        CreateSiteMapIndex(lstIndexes);

    }

    private void CreateSiteMapIndex(List<int> lstIndexes)
    {

        string SiteUrl = ConfigurationManager.AppSettings["SiteUrl"];
        string strXmlTag = @"<?xml version=""1.0"" encoding=""utf-8"" ?>";
        string xmlns = "http://www.sitemaps.org/schemas/sitemap/0.9";

        XNamespace ns = XNamespace.Get(xmlns);


        XElement xml = new XElement(ns + "sitemapindex",
                            from i in lstIndexes
                            select new XElement(ns + "sitemap",
                                      new XElement(ns + "loc", SiteUrl + "XML/sitemap" + i + ".xml"),
                                      new XElement(ns + "lastmod", DateTime.Now.ToString("yyyy-MM-ddThh:mm:sszzz"))     
                            )
                    );

        Response.Clear();
        Response.ContentType = "text/xml";
        Response.ContentEncoding = System.Text.Encoding.UTF8;
        Response.Write(strXmlTag);
        Response.Write('\n');
        Response.Write(xml);
        Response.End();
    }

      
}