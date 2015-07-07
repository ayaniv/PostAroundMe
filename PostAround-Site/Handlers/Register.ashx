<%@ WebHandler Language="C#" Class="Register" %>

using System;
using System.Web;
using PostAround.Entities;
using PostAroundService;

public class Register : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.CacheControl = "no-cache";
        context.Response.AddHeader("Pragma", "no-cache");
        context.Response.Expires = -1;
        
        // get data frm client: mail, pass, fname, lname
        // save fname and lname in Users table
        // in return, get userID
        // save userID, email, encripted password in Login Table
        // Send mail to user
        string fname = context.Request.Params["fname"];
        string lname = context.Request.Params["lname"];
        string email = context.Request.Params["email"];
        string password = context.Request.Params["password"];
        int retVal = -1;
        int result = -1;
        if (!string.IsNullOrWhiteSpace(fname) && !string.IsNullOrWhiteSpace(lname) && !string.IsNullOrWhiteSpace(email) && !string.IsNullOrWhiteSpace(password))
        {
            User user = new User();
            user.firstName = Tools.Capitalize(fname);
            user.lastName = Tools.Capitalize(lname);
            user.email = email;
            user.regDate = DateTime.Now;

            PostAroundServiceClient client = new PostAroundServiceClient();
            user.address = "";
            user.avatarImageUrl = "http://www.postaround.me/images/faces/avatar.png";
            user.birthday = DateTime.Now;
            user.facebookID = "";
            user.facebookToken = "";
            user.gender = "";
            user.latidute = "";
            user.link = "";
            user.longtitude = "";
            user.phone1 = "";
            user.phone2 = "";
            user.timezone = 0;
            
            
            int userID = client.InsertUpdateUser(user);
            if (userID > 0)
            {
                LoginDetail ld = new LoginDetail();
                ld.UserID = userID;
                ld.email = email;
                ld.password = Tools.HashIt(password);
                result = client.InsertLoginDetails(ld);
                client.Close();
            }

            if (result > 0)
            {
                System.Threading.ThreadPool.QueueUserWorkItem(delegate { SendConfirmMail(email, fname, lname, userID, result); });
                retVal = 1;
            }
            
            


            System.Web.Script.Serialization.JavaScriptSerializer oSerializer =
            new System.Web.Script.Serialization.JavaScriptSerializer();
            string sJSON = oSerializer.Serialize(retVal);

            context.Response.Write(sJSON);
            context.Response.End();
        }
        
        
       
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }


    private void SendConfirmMail(string email, string fname, string lname, int userId, int loginId)
    {
        if (System.Configuration.ConfigurationManager.AppSettings["SendMails"].Equals("True"))
        {
             

            string mapPathHtmls = System.Configuration.ConfigurationManager.AppSettings["PhysicalPath"] + @"\htmls";
            string template = mapPathHtmls + "\\Activation.htm";

            string activationURL = GenerateActivationUrl(userId, loginId);
            string name = fname + " " + lname;


            Mails.ActivationMail mail = new Mails.ActivationMail(activationURL, name, email, template, "Activate Your Account !");
            string body = mail.Compose();
            string title = mail.Title();
            Mails.Helper.SendMailMessageAsync("", mail.MailTo(), null, null, title, body);
        }
    }
    
    private string GenerateActivationUrl(int userID, int loginId)
    {
        string siteUrl = System.Configuration.ConfigurationManager.AppSettings["SiteUrlSecured"];
        
        var url = siteUrl + "Activate/{0}";
        string key = GetActivationCode(userID, loginId);
       
        string finalUrl = String.Format(url, key);
        return finalUrl;
    }

    private string GetActivationCode(int userID, int loginID)
    {
        string code;
        string codeTemplate = "userid={0}&loginID={1}";

        // we want to have this string: userid=12&loginID=1
        code = String.Format(codeTemplate, userID, loginID);

        // then we will encrypt it
        code = Tools.Encrypt(code, true).Replace('+', '$');

        // then we will encode it to 64 bit
        code = Tools.EncodeTo64(code);

        return code;

    }

}