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
using System.Text.RegularExpressions;

public partial class Controls_SinglePost : BaseControl
{
    
    protected DateTime fullDate;

    protected string BigBoxLat;
    protected string BigBoxLon;
    protected string BigBoxAddress;
    protected string BigBoxAddressNoSpace;

    protected string directionDescription;
    protected string alignDescription;
    protected string directionAddress;
    protected string directionTitle;

    protected string mapUrl;
    protected string pageUrl;

    protected int msgId;
    protected string bigBoxLineColor;
    protected string facebookID;
  

    public string PageTitle { get; set; }
    protected string myLat;
    protected string myLon;

    

    protected void Page_Load(object sender, EventArgs e)
    {
        
        
        
        try
        {
            GetDataFromCookie();


            string strMsgId = Request.QueryString["id"];
            
            string mapPathResized = System.Configuration.ConfigurationManager.AppSettings["PhysicalPath"] + @"\UploadedResizedBig";

            
            if (Int32.TryParse(strMsgId, out msgId) && msgId > 0)
            {
                MyMessage msg = GetMessageByID(msgId);
                if (msg == null)
                    throw new Exception();
                
                
                if (!msg.Mine)
                    ltrlButtons.Text = @"<div class=""slider-frame""><span class=""slider-button""><span class=""PublicIcon PublicIconOn""></span>Public</span><span class=""slider-button-off""><span class=""PrivateIcon""></span>Private</span></div>";

                this.Page.Title = msg.title + " - " + msg.msgAddress;
                facebookID = msg.facebookID;
                ltrlAddress.Text = msg.msgAddress;
                directionAddress = GetLanguageDirection(ltrlAddress.Text);
                BigBoxAddress = ltrlAddress.Text;
                BigBoxAddressNoSpace = BigBoxAddress.Replace(",", "").Replace(" ", "_").Replace("/", "_");
                ltrlUserImage.Text = "<img src=" + msg.userImage + " style='height:50px; width:50px; border-radius:50px; border-bottom-right-radius:2px; border:0;' />";
                ltrlName.Text = msg.Name;
                ltrlDate.Text = "On " + msg.Date; //+ " at " + msg.Time;
                ltrlAddressUser.Text = "Around " + ltrlAddress.Text;
                //fullDate = msg.FullDate;
                ltrlCategory.Text = msg.category;
                ltrlTitle.Text = msg.title;
                ltrlText.Text = FormatText(msg.description);
                directionDescription = GetLanguageDirection(ltrlText.Text);
                alignDescription = directionDescription == "ltr" ? "left" : "right";
                bigBoxLineColor = msg.catColor;

                directionTitle = GetLanguageDirection(ltrlTitle.Text);
                BigBoxLat = msg.latitude;
                BigBoxLon = msg.longitude;

                pageUrl = siteUrl + "post/" + msg.msgId;

                mapUrl = "https://maps.google.com/maps?daddr=" + BigBoxLat + "," + BigBoxLon; // +"&t=m&z=16";
                
                if (!string.IsNullOrWhiteSpace(myLat) && !string.IsNullOrWhiteSpace(myLon))
                {
                    mapUrl = mapUrl + "&saddr=" + myLat + "," + myLon;
                }
                

                if (!string.IsNullOrWhiteSpace(msg.image))
                {
                    // attach image height
                    System.Drawing.Image objImage = System.Drawing.Image.FromFile(mapPathResized + "\\" + msg.image);
                    msg.ImageHeight = objImage.Height;
                    ltrlMedia.Text = "<img src=" + siteUrl + "UploadedResizedBig/" + msg.image + " style='height:" + msg.ImageHeight + "px;" + " width:610px; float:left; border:0;' />";
                }

                rptComments.ItemCreated += new RepeaterItemEventHandler(rptComments_ItemCreated);
                rptComments.DataSource = msg.comments;
                rptComments.DataBind();


                ClientScriptManager cs = Page.ClientScript;
                String cstext1 = "SetMapCanvas(" + BigBoxLat + ", " + BigBoxLon + ")";
                cs.RegisterStartupScript(this.GetType(), "SetMapCanvas", cstext1, true);


            }
            else { throw new Exception(); }

        }
        catch (Exception ex)
        {
            Response.Redirect(siteUrl);
        }
    }


    private void GetDataFromCookie()
    {
        HttpCookie cookie = Request.Cookies["UserInfo"];

        if (cookie != null)
        {
            if (!string.IsNullOrEmpty(cookie["lat"]))
                myLat = cookie["lat"];

            if (!string.IsNullOrEmpty(cookie["lng"]))
                myLon = cookie["lng"];

        }
    }

    private PostAround.Entities.MyMessage GetMessageByID(int msgId)
    {

        string currLon = "", currLat = "";
        int regionId = 0;
        int timeZone = 0;
        int userId = 0;

        userId = Tools.GetUserIdFromCookie(Context);
        //if (userId <= 0)
        //{
        //    AddCommentPanel.Visible = false;
        //}
        
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
            ((Literal)e.Item.FindControl("cmtUserName")).Text = "<a href='" + item.commentUserLink + "' target='_blank' >" + item.name + "</a>";
            ((Literal)e.Item.FindControl("cmtBody")).Text = FormatText(item.body);
            ((Literal)e.Item.FindControl("cmtDate")).Text = item.strDate + " at " + item.strTime;

            ((HtmlGenericControl)e.Item.FindControl("CommentText")).Style.Add("direction", GetLanguageDirection(item.body));
            ((HtmlGenericControl)e.Item.FindControl("CommentText")).Attributes.Add("dir", GetLanguageDirection(item.body));
            string strComment = @"<div id=""HideComment"" class=""SmallXButton""></div>";
            if (item.Mine == true)
            {
                ((Literal)e.Item.FindControl("ltrlCommentXButton")).Text = strComment;
                
            }
            
            
            //((TextBox)e.Item.FindControl("txtDropDownCategoryId")).Text = item.ID.ToString();
            //((Label)e.Item.FindControl("ltrlDropDownColor")).Style.Add("background-color", item.Color);
            //((Label)e.Item.FindControl("ltrlDropDownOption")).Text = item.Name;
        }
    }


    private string FormatText(string text) {


        text = Linkify(text);
        text = text.Replace("\n", "<br/>");
        return text;

    }


    protected string GetLanguageAlign(string str)
    {
        string direction = GetLanguageDirection(str);
        if (direction == "rtl")
            return "right";
        return "left";

    }

    protected string GetLanguageDirection(string str)
    {
        //english
        string direction = "ltr";

        if (str == null)
            return direction;

        str = Regex.Replace(str, @"[\d-]", string.Empty);
        str = str.Trim();


        //hebrew
        if ((!string.IsNullOrWhiteSpace(str)) && (str[0] > 0x590) && (str[0] < 0x5FF))
            direction = "rtl";

        //arabic
        else if ((!string.IsNullOrWhiteSpace(str)) &&  (str[0] > 0x600) && (str[0] < 0x6FF))
            direction = "rtl";

        return direction;

    }

    private string Linkify(string inputText) {
        //URLs starting with http://, https://, or ftp://
        string replacePattern1 = @"((http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:/~\+#]*[\w\-\@?^=%&amp;/~\+#])?)";
        string replacedText = Regex.Replace(inputText, replacePattern1, "<a target='_blank' href='$1'>$1</a>");
        

        //URLs starting with www. (without // before it, or it'd re-link the ones done above)
        string replacePattern2 = @"(^|[^\/])(www\.[\S]+(\b|$))";
        replacedText = Regex.Replace(replacedText, replacePattern2, "$1<a target='_blank' href='http://$2'>$2</a>");
        
        return replacedText;

    }




}
