<%@ WebHandler Language="C#" Class="InsertComment" %>

using System;
using System.Web;
using PostAroundService;
using PostAround.Entities;
using System.Net;

public class InsertComment : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.CacheControl = "no-cache";
        context.Response.AddHeader("Pragma", "no-cache");
        context.Response.Expires = -1;
        
        //string strUserId = "";
        int userid = 0;
        int retVal = -1;
        CommentResult cr = null;

        userid = Tools.GetUserIdFromCookie(context);
        
        if (userid > 0)
        {
            PostAround.Entities.Comment comment = new PostAround.Entities.Comment();

            //comment.date = DateTime.Now;
            comment.body = context.Request.Params["body"];
            comment.messageID = Convert.ToInt32(context.Request.Params["messageID"]);
            comment.userID = userid;
            comment.isPrivate = Convert.ToBoolean(context.Request.Params["isPrivate"]);


            PostAroundServiceClient client = new PostAroundServiceClient();

            cr = client.InsertComment(comment);
            client.Close();
            
            if ((cr != null) && (cr.Id > 0))
            {
                comment.ID = cr.Id;
                comment.userID = userid;
                
                // In a new thread - send email on reply
                
                System.Threading.ThreadPool.QueueUserWorkItem(delegate { SendMailOnReply(comment, comment.userID); });
            }
            
        }


        System.Web.Script.Serialization.JavaScriptSerializer oSerializer =
        new System.Web.Script.Serialization.JavaScriptSerializer();
        string sJSON = oSerializer.Serialize(cr);


        context.Response.Write(sJSON);
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }


    private bool UserIsGrantPermission(int userId, int permissionId)
    {
        PostAroundServiceClient client = new PostAroundServiceClient();
        bool response = client.GetUserPermission(userId, permissionId);
        client.Close();
        return response;
    }

    private void SendMailOnReply(Comment comment, int userId)
    {
        if (System.Configuration.ConfigurationManager.AppSettings["SendMails"].Equals("True"))
        {
            PostAroundServiceClient client = new PostAroundServiceClient();

            MyMessage mainMessage = client.GetMessageById(comment.messageID, "", "", 0, 0, 0);

            if (mainMessage.userid == userId)
                return;

            // add check if can send email
            if (!UserIsGrantPermission(mainMessage.userid, (int)Enums.Permissions.EmailPermission))
                return;

            string mapPathHtmls = System.Configuration.ConfigurationManager.AppSettings["PhysicalPath"] + @"\htmls";
            string template = mapPathHtmls + "\\MailReply.htm";
            MailData data = new MailData();
            User senderUser = client.GetUserByID(comment.userID);

            User recipientUser = client.GetUserByID(mainMessage.userid);
            
            client.Close();
            data.recipientEmail = recipientUser.email;
            data.postHeader = mainMessage.title;

            data.Date = DateTime.Now.ToString("d MMMM, yyyy", System.Globalization.CultureInfo.CreateSpecificCulture("en-US"));
            data.SenderFullName = senderUser.firstName + " " + senderUser.lastName;
            data.Message = comment.body;
            data.SenderFname = senderUser.firstName;
            data.MsgID = comment.messageID;
            data.UnsubscribeCode = GetUnsubscriptionCode(mainMessage.userid, (int)Enums.Permissions.EmailPermission);
            data.SenderImage = senderUser.avatarImageUrl;

            Mails.ReplyMailComposer mail = new Mails.ReplyMailComposer(data, template, "New Comment to your post around !");
            string body = mail.Compose();
            string title = mail.Title();
            Mails.Helper.SendMailMessageAsync("", mail.MailTo(), null, null, title, body);
        }
    }

    private string GetUnsubscriptionCode(int userId, int permissionId)
    {
        string code;
        string codeTemplate = "userid={0}&permissionId={1}";

        // we want to have this string: userid=12&permissionId=1
        code = String.Format(codeTemplate, userId, permissionId);

        // then we will encrypt it
        code = Tools.Encrypt(code, true);

        // then we will encode it to 64 bit
        code = Tools.EncodeTo64(code);

        return code;
        
    }

}