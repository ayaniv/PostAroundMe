using PostAround.Entities;
using PostAroundService;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_PostNotify : BasePage
{
    protected string postHeader;
    protected int postId;
    protected string senderFullName;
    protected string date;
    protected string message;
    protected string senderFName;
    protected string senderImage;
 
    protected void Page_Load(object sender, EventArgs e)
    {
     

        string strCommentId = Request.QueryString["commentId"];
        strCommentId = Server.UrlDecode(strCommentId);
        strCommentId = strCommentId.Replace('$', '+');
        strCommentId = Tools.Decrypt(strCommentId, true);
        strCommentId = strCommentId.Split('.')[0];

        
        int commentId = 0;
        int.TryParse(strCommentId, out commentId);
        
        string mapPathHtmls = System.Configuration.ConfigurationManager.AppSettings["PhysicalPath"] + @"\htmls";
        string template = mapPathHtmls + "\\MailReply.htm";
        MailData data = new MailData();

        PostAroundServiceClient client = new PostAroundServiceClient();

        Comment currComment = client.GetCommentByID(commentId);
        MyMessage mainMessage = client.GetMessageById(currComment.messageID, "", "", 0, 0, 0);
        User senderUser = client.GetUserByID(currComment.userID);
        client.Close();

        postHeader = mainMessage.title;
        postId = currComment.messageID;
        date = DateTime.Now.ToString("d MMMM, yyyy", System.Globalization.CultureInfo.CreateSpecificCulture("en-US"));
        message = currComment.body;
        senderFName = senderUser.firstName;
        senderFullName = senderUser.firstName + " " + senderUser.lastName;
        senderImage = senderUser.avatarImageUrl;

       
    }
}