using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PostAround.Entities;


public partial class Pages_EmailTestPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //try
        //{
        string mapPathHtmls = System.Configuration.ConfigurationManager.AppSettings["PhysicalPath"] + @"\htmls";
        string template = mapPathHtmls + "\\MailReply.htm";
        MailData data = new MailData();
        data.Date = "29 Jan 1983";
        data.SenderFullName = "Yaniv Aharon";
        data.Message = "Hello World";
        data.SenderFname = "Yaniv";
        data.MsgID = 192;
        data.UnsubscribeCode = "yaniv";
        data.SenderImage = "https://graph.facebook.com/567517451/picture";


        Mails.ReplyMailComposer mail = new Mails.ReplyMailComposer(data, template, "New Comment to your post around !");
        string body = mail.Compose();
        string title = mail.Title();
        Tools.SendMailMessage("yaniv@postround.me", "ayaniv@gmail.com", null, null, title, body);
        //}
        //catch (Exception ex) { Response.Write(ex.InnerException); Response.End(); }
    }
}