using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Configuration;
using System.IO;
using PostAround.Entities;
using PostAroundService;

public partial class Controls_MetaTags : BaseControl
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        

        string title = "Post Around Me | Local Pinboard";
        string description = "Turn your Facebook into a bulletin board based on your locaion, that finds you what closest to you !";
        string url = siteUrl.TrimEnd('/');
        string image = siteUrl + "images/facebook_ogimage.png";
        string admin = "567517451";
        int msgId;
        string strMsgId = Request.QueryString["id"];
        string page = Path.GetFileNameWithoutExtension(HttpContext.Current.Request.Url.AbsoluteUri).ToLower();
        string author = "Yaniv Aharon";

        if ( (page == "post") && (Int32.TryParse(strMsgId, out msgId)) && msgId > 0)
        {
            MyMessage msg = GetMessageByID(msgId);
            if (msg != null)
            {
                author = msg.Name;
                admin = msg.facebookID;
                title = msg.title;
                description = FormatText(msg.description);
                url = siteUrl + "post/" + msg.msgId;
                string latlon = msg.latitude + "," + msg.longitude;
                if (!string.IsNullOrWhiteSpace(msg.image))
                    image = siteUrl + "UploadedResized/" + msg.image;
                else
                    image = "http://maps.googleapis.com/maps/api/staticmap?center=" + latlon + "&zoom=14&size=220x220&maptype=roadmap&sensor=true&markers=icon:http://postaround.me/images/markers/image.png%7C" + latlon;
            }

        }
        else if (HttpContext.Current.Request.Url.AbsoluteUri.ToLower().Contains("taiwan-receipt-lottery-checker.aspx"))
        {
            author = "";
            admin = "567517451";
            title = "Taiwan Lottery Numbers Online Checker | Taiwan Receipt Lottery";
            description = "Easily check your receipts with the up to date Winning Numbers for Taiwan's Receipt Lottery";
            url = "http://postaround.me/taiwan/Taiwan-Receipt-Lottery-Checker.aspx";
            image = "http://postaround.me/images/taiwan_receipt_lottery.jpg";

        }
        else if ((Request.QueryString["latlon"] == "32.069798,34.795407") || (Request.QueryString["address"] == "ביצרון"))
        {
            author = "";
            admin = "567517451";
            title = "שכונת ביצרון  - לוח המודעות השכונתי";
            description = "מה קורה בשכונת ביצרון? לוח מודעות שיתופי המיועד לתושבי השכונה. המקום שלכם ליצור קשר עם השכנים שלכם";
            url = "http://postaround.me/ll/32.069798,34.795407";
            
           

        }
        else if ((Request.QueryString["latlon"] == "32.1112796,34.8014162") || (Request.QueryString["address"] == "אוניברסיטת_תל_אביב"))
        {
            author = "";
            admin = "567517451";
            title = "לוח מודעות - אוניברסיטת תל אביב";
            description = "מה קורה באוניברסיטת תל אביב? לוח מודעות שיתופי המיועד לכל מי שנמצא באיזור אוניברסיטת תל אביב. המקום לעדכן ולהתעדכן על כל מה שקורה בסביבה";
            url = "http://postaround.me/ll/32.1112796,34.8014162";
            
        }


        this.Page.Title = title;
        Dictionary<string, string> ogAttributes = new Dictionary<string, string>();
        ogAttributes.Add("og:title", title);
        ogAttributes.Add("og:description", description);
        ogAttributes.Add("og:url", url);
        ogAttributes.Add("og:image", image);
        
        ogAttributes.Add("og:type", "website");
        ogAttributes.Add("og:site_name", "postaround.me");
        ogAttributes.Add("fb:app_id", ConfigurationManager.AppSettings["facebookAppKey"]);
        ogAttributes.Add("fb:admins", admin);
        
        
        Dictionary<string, string> metaAttributes = new Dictionary<string, string>();
        metaAttributes.Add("description", description);
        metaAttributes.Add("keywords", "Location Based Social Network, places, locations, local, hyperlocal, geo-tagging, geo-community, listener, broadcast, local feed, local recommendations, local restaurants, local message board, local community, local issues, Location Based Bulletin Board,  Pinboard, posterboard, bulletin board, billboard, neighborhood, myhood, hood, people around, nearby, nearbyme, bulletin, board, location, geolocation, postaround, posting, based, area, Location Based Bulletin Board, Location Based Pinboard, aroundme, post around me, postaroundme, postaround, לוח מודעות, לוח מודעות מבוסס מיקום");
        metaAttributes.Add("author", author);
        
        HtmlMeta tag;
        foreach (KeyValuePair<string, string> kvp in ogAttributes)
        {
            tag = new HtmlMeta();
            tag.Attributes.Add("property", kvp.Key);
            tag.Content = kvp.Value; 
            Page.Header.Controls.Add(tag);
        }

        foreach (KeyValuePair<string, string> kvp in metaAttributes)
        {
            tag = new HtmlMeta();
            tag.Attributes.Add("name", kvp.Key);
            tag.Content = kvp.Value; 
            Page.Header.Controls.Add(tag);
        }
    

    }

    private PostAround.Entities.MyMessage GetMessageByID(int msgId)
    {

        string currLon = "", currLat = "";
        int regionId = 0;
        int timeZone = 0;
        int userId = 0;

        userId = Tools.GetUserIdFromCookie(Context);

        PostAroundServiceClient client = new PostAroundServiceClient();

        PostAround.Entities.MyMessage message = client.GetMessageById(msgId, currLon, currLat, regionId, timeZone, userId);
        
        client.Close();

        return message;

    }



    private string FormatText(string text)
    {

        int posStart;
        while ((posStart = LinkPositionInText(text)) >= 0)
        {
            text = GetTextWithoutLink(posStart, text);
        }

        return text;
    }

    private int LinkPositionInText(string text)
    {
        int posStart = text.IndexOf("http://") > 0 ? text.IndexOf("http://") : text.IndexOf("https://");
        if (posStart < 0)
            posStart = text.IndexOf("www");

        return posStart;
    }

    private string GetTextWithoutLink(int posStart, string text) {
        
        var posEnd = 0;
        var link = "";
        
        posEnd = text.IndexOf(' ', posStart);
        if (posEnd < 0) {
            posEnd = text.IndexOf('\n', posStart);
            if (posEnd < 0)
                posEnd = text.Length;
        }
        link = text.Substring(posStart,  posEnd - posStart);
        
        text = text.Replace(link, "");
        
        
        return text;
    }

}