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

        userid = Tools.GetUserIdFromCookie(context);
        
        if (userid > 0)
        {
            PostAround.Entities.Comment comment = new PostAround.Entities.Comment();

            //comment.date = DateTime.Now;
            comment.body = context.Request.Params["body"];
            comment.messageID = Convert.ToInt32(context.Request.Params["messageID"]);
            comment.userID = userid;


            PostAroundServiceClient client = new PostAroundServiceClient();

            retVal = client.InsertComment(comment);
            client.Close();
            
            if ((retVal > 0))
            {
                comment.ID = retVal;
                comment.userID = userid;
                
                // In a new thread - send email on reply
                
                System.Threading.ThreadPool.QueueUserWorkItem(delegate { SendMailOnReply(comment, comment.userID); });
            }
            
        }
            
            



        context.Response.Write(retVal.ToString());
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

    private void SendMailOnReply(Comment comment, int userId)
    {
        if (System.Configuration.ConfigurationManager.AppSettings["SendMails"].Equals("True"))
        {
            // add check if can send email
            // change the unsubsription to frienly-url
            PostAroundServiceClient client = new PostAroundServiceClient();

            MyMessage mainMessage = client.GetMessageById(comment.messageID, "", "", 0, 0, 0);

            if (mainMessage.userid == userId)
                return;

            string mapPathHtmls = System.Configuration.ConfigurationManager.AppSettings["PhysicalPath"] + @"\htmls";
            string template = mapPathHtmls + "\\MailReply.htm";
            MailData data = new MailData();
            User senderUser = client.GetUserByID(comment.userID);

            User recipientUser = client.GetUserByID(mainMessage.userid);
            client.Close();
            data.recipientEmail = recipientUser.email;

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