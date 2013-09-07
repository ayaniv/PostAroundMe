using PostAround.Entities;
using PostAroundService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Controls_MorePosts : BaseControl
{

    public int numberOfItems { get; set; }
    public string CategoryName { get; set; }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        // Get postId from queryString
        // If url ends with "Taiwan-Receipt-Lottery-Checker.aspx" Set Hard Coded Location
        // get post details by postId
        // write the address in the address pane
        // get the post lat and lon
        // get posts around this lat lon
        // and poplulate the repeater
        int msgId;
        string lat = "";
        string lng = "";
        string address = "";
        List<int> lstCatId = new List<int>();
        

        string strMsgId = Request.QueryString["id"];
            


            if (Int32.TryParse(strMsgId, out msgId) && msgId > 0)
            {
                MyMessage msg = GetMessageByID(msgId);
                if (msg == null)
                    throw new Exception();
                
                lat = msg.latitude;
                lng = msg.longitude;
                lstCatId.Add(msg.catID);
                address = msg.msgAddress;
                CategoryName = msg.category;


            }
            else
            {
                if (HttpContext.Current.Request.Url.AbsoluteUri.ToLower().Contains("taiwan-receipt-lottery-checker.aspx"))
                {
                    lat = "25.020725";
                    lng = "121.528168";
                    address = "Taipower building station, Daan District, Taipei, Taiwan 106";
                }
            }
            SetLocationScreen(lat, lng, address);
            GetPosts(lat, lng, numberOfItems, lstCatId);
    }

    private void GetPosts(string lat, string lng, int num, List<int> lstCatID)
    {
        List<MyMessage> messages = GetMessages(lat, lng, num, lstCatID);

        rptPosts.ItemCreated += new RepeaterItemEventHandler(rptPosts_ItemCreated);
        rptPosts.DataSource = messages;
        rptPosts.DataBind();
    }

    private void SetLocationScreen(string lat, string lng, string address)
    {
        string address_no_space = address.Replace(",", "").Replace(" ", "_").Replace("/", "_");
        linkMorePosts.NavigateUrl = linkAddress.NavigateUrl = siteUrl + "in/" + address_no_space;
        linkAddress.Text = address;
        
    }

    private List<MyMessage> GetMessages(string lat, string lon, int takeNum, List<int> lstCatID)
    {
        PostAroundServiceClient client = new PostAroundServiceClient();
        List<MyMessage> messages = client.GetMessages(lat, lon, 0, 0, takeNum, 0, lstCatID.ToArray(), 0, 0, 4000, 0).ToList();
        return messages;
    }

    private string TruncateAtWord(string input, int length)
    {
        if (input == null || input.Length < length)
            return input;
        int iNextSpace = input.LastIndexOf(" ", length);
        return string.Format("{0}...", input.Substring(0, (iNextSpace > 0) ? iNextSpace : length).Trim());
    }

    private string TruncString(string input, int length)
    {
        if (input == null || input.Length < length)
            return input;
        
        return string.Format("{0}...", input.Substring(0, length).Trim());
    }


    void rptPosts_ItemCreated(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {

            
            MyMessage item = (MyMessage)e.Item.DataItem;
            if (item != null)
            {

                ((HtmlGenericControl)e.Item.FindControl("PostItem")).Attributes.Add("postId", item.msgId.ToString());
                ((HtmlGenericControl)e.Item.FindControl("divLine")).Style.Add("background-color", item.catColor);
                ((Image)e.Item.FindControl("imgUserAvatar")).ImageUrl = item.userImage;
                ((Literal)e.Item.FindControl("ltrlUserName")).Text = item.Name;
                ((Literal)e.Item.FindControl("ltrlDistance")).Text = FormatDistanceFromMeters(item.Distance); 

                ((HyperLink)e.Item.FindControl("linkTitle")).NavigateUrl = siteUrl + "post/" + item.msgId + "?ref=mp";
                ((HyperLink)e.Item.FindControl("linkTitle")).Text = TruncString(item.title, 20);
            }
        }
    }

    private string GetStreetFromAddress(string str)
    {

        string newstring = "";
        if ((str != null) && (str != ""))
        {


                string[] wordsArray = str.Split(',');
                if (wordsArray.Length < 5)
                    newstring = TruncString(wordsArray[0], 15);
                else if (wordsArray.Length == 5)
                    newstring = TruncString(wordsArray[1], 15);
                else
                    newstring = TruncString(wordsArray[3], 15);

                


        }
        return newstring;

    }

    private string FormatDistanceFromMeters(int meters)
    {
        string retVal = null;
        string distance = null;
        if (meters == -2)
        {
            retVal = "posted <b>Here</b>";
        }
        else
        {

            if (meters > 1000)
            {
                distance = Math.Round((double)meters / 1000) + "KM";
            }
            else
            {
                distance = meters + "m";
            }
        }

        if (string.IsNullOrEmpty(retVal))
        {
            retVal = "<b>" + distance + "</b> around";
        }

        return retVal;


    }

    private MyMessage GetMessageByID(int msgId)
    {

        string currLon = "", currLat = "";
        int regionId = 0;
        int timeZone = 0;
        int userId = 0;

        userId = 0;
 
        
        PostAroundServiceClient client = new PostAroundServiceClient();

        PostAround.Entities.MyMessage message = client.GetMessageById(msgId, currLon, currLat, regionId, timeZone, userId);
        if (message != null)
        {
            message.comments = client.GetCommentsByMessageID(message.msgId, userId, timeZone);
        }

        client.Close();

        return message;
        
    }
 
}