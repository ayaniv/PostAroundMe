<%@ WebHandler Language="C#" Class="InsertComment" %>

using System;
using System.Web;
using PostAroundService;

public class InsertComment : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.CacheControl = "no-cache";
        context.Response.AddHeader("Pragma", "no-cache");
        context.Response.Expires = -1;
        
        //string strUserId = "";
        int userid = 0;
        int retVal = -1;

        //strUserId = context.Request["userID"];
        //if (!string.IsNullOrWhiteSpace(strUserId))
        //{
        //    strUserId = strUserId.Replace('$', '+');
        //    strUserId = Tools.Decrypt(strUserId, true);
        //    Int32.TryParse(strUserId, out userid);
        //}

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

            if (retVal > 0)
            {
                //string mapPathHtmls = System.Configuration.ConfigurationManager.AppSettings["PhysicalPath"] + @"\htmls";
                //string template = mapPathHtmls + "\\MailReply.htm";
                //MailData data = new MailData();
                //data.Date = "29 Jan 1983";
                //data.SenderFullName = "Yaniv Aharon";
                //data.Message = "Hello World";
                //data.SenderFname = "Yaniv";
                //data.MsgID = 192;
                //data.UnsubscribeCode = "yaniv";
                //data.SenderImage = "https://graph.facebook.com/567517451/picture";


                //Mails.ReplyMailComposer mail = new Mails.ReplyMailComposer(data, template, "New Comment to your post around !");
                //string body = mail.Compose();
                //string title = mail.Title();
                Tools.SendMailMessageAsync("yaniv@postround.me", "ayaniv@gmail.com", null, null, "title", "body");
            }
            client.Close();
        }
            
            



        context.Response.Write(retVal.ToString());
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}