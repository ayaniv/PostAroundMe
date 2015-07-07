<%@ WebHandler Language="C#" Class="SetFeedback" %>

using System;
using System.Web;
using PostAroundService;

public class SetFeedback : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.CacheControl = "no-cache";
        context.Response.AddHeader("Pragma", "no-cache");
        context.Response.Expires = -1;

        PostAround.Entities.Feedback feedback = new PostAround.Entities.Feedback();

        
        
        feedback.date = DateTime.Now;
        feedback.email = context.Request.Params["email"];
        feedback.message = context.Request.Params["message"];
        feedback.name = context.Request.Params["name"];

        int retVal = -1;
        if (!string.IsNullOrWhiteSpace(feedback.message))
        {
            PostAroundServiceClient client = new PostAroundServiceClient();
            retVal = client.SetFeedback(feedback);
            client.Close();

            if (retVal > 0)
            {
                System.Threading.ThreadPool.QueueUserWorkItem(delegate { SendMail(feedback.email, feedback.message, feedback.name, retVal); });
            }
        }
        
        context.Response.Write(retVal.ToString());
        context.Response.End();
    }


    private void SendMail(string email, string message, string from, int feedbackNumber)
    {
        if (System.Configuration.ConfigurationManager.AppSettings["SendMails"].Equals("True"))
        {


            Mails.SimpleMail mail = new Mails.SimpleMail(System.Configuration.ConfigurationManager.AppSettings["SystemEmail"], email, "Feedback # " + feedbackNumber, message, from);
            string body = mail.Compose();
            string title = mail.Title();
            Mails.Helper.SendMailMessageAsync(mail.SentFrom(), mail.MailTo(), null, null, title, body);
        }
    }

 
    public bool IsReusable {
        get {
            return false;
        }
    }

}