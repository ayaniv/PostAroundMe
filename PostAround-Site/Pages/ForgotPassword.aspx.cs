using PostAroundService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PostAround.Entities;

public partial class Pages_ForgotPassword : BasePage
{
    int userId;
    protected void Page_Load(object sender, EventArgs e)
    {
        userId = 0;
        string qs = Request.QueryString["code"];
        if (!string.IsNullOrEmpty(qs))
        {
            if (Page.IsPostBack)
            {
                userId = GetUserIDfromCode(qs);
            }
    
            panelSendMail.Visible = false;
            ResetPassword.Visible = true;

        }

        
        

    }

    

    private int UpdatePassword(int userID, string email, string password)
    {
        int result = 0;
        LoginDetail ld = new LoginDetail();
        ld.UserID = userID;
        ld.email = email;
        ld.password = Tools.HashIt(password);

        PostAroundServiceClient client = new PostAroundServiceClient();
        result = client.InsertLoginDetails(ld);
        client.Close();

        return result;
    }

    private bool ResetInputCheck()
    {
        string regex = "";
        if (Tools.InputCheck(txtResetEmail.Text, regex) &&
            Tools.InputCheck(txtResetPass1.Text, regex))
        {
            return true;
        }

        return false;

    }

    protected void btnResetPassword_Click(object sender, EventArgs e)
    {

        // here we need to verify the email inserted to the userID in the q.s.
        // if it matches - we will call insertLoginDetailes with the email, user id, and password  - it will handle all the rest.

        if (ResetInputCheck())
        {
            int result = UpdatePassword(userId, txtResetEmail.Text, txtResetPass1.Text);
            
            if (result > 0)
            {
                ResetPassword.Visible = false;
                ResetPasswordDone.Visible = true;
            }
            else
            {
                ResetPassword.Visible = false;
                ResetPasswordError.Visible = true;
            }
            
        }

        
    }
    protected void btnSendResetPassword_Click(object sender, EventArgs e)
    {
        string email = txtSendResetEmail.Text;
        
        // get id + fname by email
        PostAroundServiceClient client = new PostAroundServiceClient();
        User user = client.GetUserByEmail(email);
        client.Close();

        if (user != null && user.userID > 0)
        {
            SendForgotPasswordMail(email, user.userID, user.firstName);
            panelEmailSent.Visible = true;
            panelSendMail.Visible = false;
        }
        else
        {
            errorEmailNoExist.InnerHtml  = "A user with this email does not exist";
            txtSendResetEmail.Style.Add("border-color", "#FF0000");
            errorEmailNoExist.Style.Add("display", "block");
        }
        
    }

    private void SendForgotPasswordMail(string email, int userId, string fname)
    {
        if (System.Configuration.ConfigurationManager.AppSettings["SendMails"].Equals("True"))
        {
            string mapPathHtmls = System.Configuration.ConfigurationManager.AppSettings["PhysicalPath"] + @"\htmls";
            string template = mapPathHtmls + "\\ForgotPassword.htm";

            string activationURL = GenerateActivationUrl(userId);
           


            Mails.ActivationMail mail = new Mails.ActivationMail(activationURL, fname, email, template, "Reset Your Password");
            string body = mail.Compose();
            string title = mail.Title();
            Mails.Helper.SendMailMessageAsync("", mail.MailTo(), null, null, title, body);
        }
    }

    private string GenerateActivationUrl(int userID)
    {
        string siteUrl = System.Configuration.ConfigurationManager.AppSettings["SiteUrlSecured"];

        var url = siteUrl + "app/ForgotPassword?code={0}";
        string key = GetPasswordResetCode(userID);

        string finalUrl = String.Format(url, key);
        return finalUrl;
    }

    private int GetUserIDfromCode(string code)
    {
        string temp;
        int result;
        temp = Tools.DecodeFrom64(code);
        temp = temp.Replace('$', '+');
        temp = Tools.Decrypt(temp, true);
        temp = temp.Split('=')[1];
        if (Int32.TryParse(temp, out result))
            return result;
        return -1;
    }

    private string GetPasswordResetCode(int userID)
    {
        string code;
        string codeTemplate = "userid={0}";

        // we want to have this string: userid=12&loginID=1
        code = String.Format(codeTemplate, userID);

        // then we will encrypt it
        code = Tools.Encrypt(code, true).Replace('+', '$');

        // then we will encode it to 64 bit
        code = Tools.EncodeTo64(code);

        return code;

    }
}