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
        BriefMessage[] messages = client.GetAllBriefMessages();
        client.Close();
        GenerateXML(messages);

    }




    private void GenerateXML(Object[] list)
    {




        


        BriefMessage[] posts = (BriefMessage[])list;
        string SiteUrl = ConfigurationManager.AppSettings["SiteUrl"];
        string strXmlTag = @"<?xml version=""1.0"" encoding=""utf-8"" ?>";
        string xmlns = "http://www.sitemaps.org/schemas/sitemap/0.9";

        XNamespace ns = XNamespace.Get(xmlns);


        XElement xml = new XElement(ns + "urlset",
                            from p in posts
                            select new XElement(ns + "url",
                                      new XElement(ns + "loc", SiteUrl + "post/" + p.msgId),
                                      new XElement(ns + "lastmod", p.FullDate.ToString("yyyy-MM-ddThh:mm:sszzz")),
                                      new XElement(ns + "changefreq", "weekly"),
                                      new XElement(ns + "priority", "0.8")
                                      
                            ),
                            new XElement(ns + "url",
                                      new XElement(ns + "loc", SiteUrl),
                                      new XElement(ns + "lastmod", DateTime.Now.ToString("yyyy-MM-ddThh:mm:sszzz")),
                                      new XElement(ns + "changefreq", "daily"),
                                      new XElement(ns + "priority", "1.0")),
                            new XElement(ns + "url",
                                      new XElement(ns + "loc", SiteUrl + "Pages/Terms.aspx"),
                                      new XElement(ns + "lastmod", "2012-01-12"),
                                      new XElement(ns + "changefreq", "yearly"),
                                      new XElement(ns + "priority", "0.1")),
                            new XElement(ns + "url",
                                      new XElement(ns + "loc", SiteUrl + "Pages/Privacy.aspx"),
                                      new XElement(ns + "lastmod", "2012-01-12"),
                                      new XElement(ns + "changefreq", "yearly"),
                                      new XElement(ns + "priority", "0.1")),
                            new XElement(ns + "url",
                                      new XElement(ns + "loc", SiteUrl + "Taiwan/Taiwan-Receipt-Lottery-Checker.aspx"),
                                      new XElement(ns + "lastmod", "2012-05-25"),
                                      new XElement(ns + "changefreq", "monthly"),
                                      new XElement(ns + "priority", "0.2")),
                            new XElement(ns + "url",
                                      new XElement(ns + "loc", SiteUrl + "Sitelinks.aspx"),
                                      new XElement(ns + "lastmod", DateTime.Now.ToString("yyyy-MM-ddThh:mm:sszzz")),
                                      new XElement(ns + "changefreq", "daily"),
                                      new XElement(ns + "priority", "0.1"))

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