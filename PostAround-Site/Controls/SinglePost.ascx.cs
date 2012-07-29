using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PostAroundService;
using PostAround.Entities;
using System.Configuration;
using System.Web.UI.HtmlControls;

public partial class Controls_SinglePost : System.Web.UI.UserControl
{
    protected string homePage;
    protected DateTime fullDate;

    protected string BigBoxLat;
    protected string BigBoxLon;
    protected string BigBoxAddress;

    protected string directionDescription;
    protected string directionAddress;
    protected string directionTitle;

    protected string mapUrl;
    protected string pageUrl;

    protected int msgId;
    protected string bigBoxLineColor;


    public string PageTitle { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        
        try
        {
            homePage = ConfigurationManager.AppSettings["HomePage"];
            string strMsgId = Request.QueryString["id"];
            
            string mapPathResized = System.Configuration.ConfigurationManager.AppSettings["PhysicalPath"] + @"\UploadedResizedBig";

            
            if (Int32.TryParse(strMsgId, out msgId) && msgId > 0)
            {
                MyMessage msg = GetMessageByID(msgId);
                if (msg == null)
                    throw new Exception();

                this.Page.Title = msg.title + " : Post Around Me";

                ltrlAddress.Text = msg.msgAddress;
                directionAddress = GetLanguageDirection(ltrlAddress.Text);
                BigBoxAddress = Tools.EncodeTo64(ltrlAddress.Text);
                ltrlUserImage.Text = "<img src=" + msg.userImage + " style='height:50px; width:50px; border:0;' />";
                ltrlName.Text = msg.Name;
                ltrlDate.Text = "Posted on " + msg.Date; // +" at " + msg.Time;
                //fullDate = msg.FullDate;
                ltrlCategory.Text = msg.category;
                ltrlTitle.Text = msg.title;
                ltrlText.Text = FormatText(msg.description);
                directionDescription = GetLanguageDirection(ltrlText.Text);
                bigBoxLineColor = msg.catColor;

                directionTitle = GetLanguageDirection(ltrlTitle.Text);
                BigBoxLat = msg.latitude;
                BigBoxLon = msg.longitude;

                pageUrl = homePage + "post/" + msg.msgId;

                mapUrl = "https://maps.google.com/maps?q=" + BigBoxLat + "," + BigBoxLon + "&t=m&z=16";

                if (!string.IsNullOrWhiteSpace(msg.image))
                {
                    // attach image height
                    System.Drawing.Image objImage = System.Drawing.Image.FromFile(mapPathResized + "\\" + msg.image);
                    msg.ImageHeight = objImage.Height;
                    ltrlMedia.Text = "<img src=" + homePage + "/UploadedResizedBig/" + msg.image + " style='height:" + msg.ImageHeight + "px;" + " width:533px; border:0;' />";
                }

                rptComments.ItemCreated += new RepeaterItemEventHandler(rptComments_ItemCreated);
                rptComments.DataSource = msg.comments;
                rptComments.DataBind();
                




            }
            else { throw new Exception(); }

        }
        catch (Exception ex)
        {
            Response.Redirect(homePage);
        }
    }


     protected string GetLanguageDirection(string str)
     {
         //english
         string direction = "ltr";

         if (str == null)
             return direction;

        //hebrew
        if ((str[0] > 0x590) && (str[0] < 0x5FF))
            direction = "rtl";

        //arabic
        else if ((str[0] > 0x600) && (str[0] < 0x6FF))
            direction = "rtl";

        return direction;

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
        if (message != null)
        {
            message.comments = client.GetCommentsByMessageID(message.msgId, userId, timeZone);
        }

        client.Close();

        return message;
        
    }


    


    void rptComments_ItemCreated(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            

            Comment item = (Comment)e.Item.DataItem;
            ((Literal)e.Item.FindControl("cmtUserImage")).Text = "<img src='" + item.avatarImageUrl +"' />";
            ((Literal)e.Item.FindControl("cmtUserName")).Text = "<a href='" + item.commentUserLink + "' target='_blank'>" + item.name + "</a>";
            ((Literal)e.Item.FindControl("cmtBody")).Text = item.body;
            ((Literal)e.Item.FindControl("cmtDate")).Text = item.strDate + " at " + item.strTime;
            
            //((TextBox)e.Item.FindControl("txtDropDownCategoryId")).Text = item.ID.ToString();
            //((Label)e.Item.FindControl("ltrlDropDownColor")).Style.Add("background-color", item.Color);
            //((Label)e.Item.FindControl("ltrlDropDownOption")).Text = item.Name;
        }
    }


    private string FormatText(string text) {

        int posStart = text.IndexOf("http://") > 0 ? text.IndexOf("http://") : text.IndexOf("https://");
        if (posStart >= 0) {
            text = GetTextWithLink(posStart, text, false);
        } else {
            posStart = text.IndexOf("www");
            if (posStart >= 0)
                text = GetTextWithLink(posStart, text, true);
        }
        text = text.Replace("\n", "<br/>");
        return text;

    }


    private string GetTextWithLink(int posStart, string text, bool addHttp) {
        string href = "<a style='color:#6AA1BB' href='[link]' target='_blank'>External Website</a>";
        int posEnd = 0;
        string link = "";
        
        posEnd = text.IndexOf(' ', posStart);
        if (posEnd < 0) {
            posEnd = text.IndexOf("\n", posStart);
            if (posEnd < 0)
                posEnd = text.Length;
        }
        link = text.Substring(posStart, posEnd - posStart);
        
        if (addHttp)
            href = href.Replace("[link]", "http://" + link);
        else
            href = href.Replace("[link]", link);

        text = text.Replace(link, href);
        
        return text;
    }

}
