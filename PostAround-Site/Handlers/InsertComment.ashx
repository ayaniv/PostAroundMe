<%@ WebHandler Language="C#" Class="InsertComment" %>

using System;
using System.Web;
using PostAroundService;
using PostAround.Entities;
using System.Net;
using System.Collections.Generic;

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

    private HashSet<int> GetSetOfRepliersUserId(int messageId, int posterId)
    {
        PostAroundServiceClient client = new PostAroundServiceClient();
        Comment[] comments = client.GetCommentsByMessageID(messageId, posterId, 0, 0);
        HashSet<int> hashset = new HashSet<int>();
        foreach (Comment currComment in comments)
        {
            hashset.Add(currComment.userID);
        }
        client.Close();
        return hashset;
    }

    private void SendMailOnReply(Comment comment, int userId)
    {
        if (System.Configuration.ConfigurationManager.AppSettings["SendMails"].Equals("True"))
        {
            PostAroundServiceClient client = new PostAroundServiceClient();

            MyMessage mainMessage = client.GetMessageById(comment.messageID, "", "", 0, 0, 0);

            if (mainMessage.userid == userId)
            {
                // if the commenter is the poster, send emails to all other commeeters of the post and return.

                //get all the userids of the commenters
                HashSet<int> hashset = GetSetOfRepliersUserId(comment.messageID, userId);

                foreach (int recipientId in hashset)
                {
                    if (UserIsGrantPermission(recipientId, (int)Enums.Permissions.EmailPermission))
                    {
                        ReplyMailSender(userId, recipientId, comment, mainMessage.title);
                    }
                }

            }
            else
            {
                if (UserIsGrantPermission(mainMessage.userid, (int)Enums.Permissions.EmailPermission))
                {
                    ReplyMailSender(comment.userID, mainMessage.userid, comment, mainMessage.title);
                }
            }
            client.Close();
        }
    }

    private void ReplyMailSender(int senderId, int recipeintId, Comment comment, string postTitle)
    {
        if (senderId == recipeintId)
        {
            return;
        }
        PostAroundServiceClient client = new PostAroundServiceClient();
        string mapPathHtmls = System.Configuration.ConfigurationManager.AppSettings["PhysicalPath"] + @"\htmls";
        string template = mapPathHtmls + "\\MailReply.htm";
        MailData data = new MailData();
        User senderUser = client.GetUserByID(senderId);

        User recipientUser = client.GetUserByID(recipeintId);

        client.Close();
        data.recipientEmail = recipientUser.email;
        data.postHeader = postTitle;

        data.Date = DateTime.Now.ToString("d MMMM, yyyy", System.Globalization.CultureInfo.CreateSpecificCulture("en-US"));
        data.SenderFullName = senderUser.firstName + " " + senderUser.lastName;
        data.Message = comment.body;
        data.SenderFname = senderUser.firstName;
        data.MsgID = comment.messageID;
        data.UnsubscribeCode = GetUnsubscriptionCode(recipeintId, (int)Enums.Permissions.EmailPermission);
        data.SenderImage = senderUser.avatarImageUrl;

        Mails.ReplyMailComposer mail = new Mails.ReplyMailComposer(data, template, senderUser.firstName + " also commented the post around");
        string body = mail.Compose();
        string title = mail.Title();
        Mails.Helper.SendMailMessageAsync("", mail.MailTo(), null, null, title, body);
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