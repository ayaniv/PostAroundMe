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

public partial class Pages_Sitemap : BasePage
{

    

    protected void Page_Load(object sender, EventArgs e)
    {

        PostAroundServiceClient client = new PostAroundServiceClient();
        int siteMapsCount = client.CreateXmlSiteMap();
        DateTime lastpostDate = client.GetDateOfLastPost("", "", -1);
        client.Close();
        List<int> lstIndexes = new List<int>();

        for (int i = 0; i <= siteMapsCount; i++)
        {
            lstIndexes.Add(i);
        }
        CreateSiteMapIndex(lstIndexes, lastpostDate);

    }

    private void CreateSiteMapIndex(List<int> lstIndexes, DateTime lastpostDate)
    {

      
        string strXmlTag = @"<?xml version=""1.0"" encoding=""utf-8"" ?>";
        string xmlns = "http://www.sitemaps.org/schemas/sitemap/0.9";

        XNamespace ns = XNamespace.Get(xmlns);


        XElement xml = new XElement(ns + "sitemapindex",
                            from i in lstIndexes
                            select new XElement(ns + "sitemap",
                                      new XElement(ns + "loc", siteUrl + "XML/sitemap" + i + ".xml"),
                                      new XElement(ns + "lastmod", lastpostDate.ToString("yyyy-MM-ddThh:mm:sszzz"))     
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