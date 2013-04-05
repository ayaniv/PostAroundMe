using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using PostAround.Entities;
using PostAroundService;

public partial class Pages_SetUserPermission : System.Web.UI.Page
{
    UserPermission up = new UserPermission();
    protected string siteUrl;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        
        siteUrl = ConfigurationManager.AppSettings["SiteUrl"];
        if (Tools.GetProtocol(HttpContext.Current).Equals("https"))
        {
            siteUrl = siteUrl.Replace("http://", "https://");
        }
        
        try
        {
            //string test = "userid=14&permissionId=1";
            //test = Tools.Encrypt(test, true);
            //test = Tools.EncodeTo64(test);


            string code64Encoded = Request.QueryString["code"];
            up = GetUserPermissionDataFromQueryString(code64Encoded);
            if (up != null)
            {
                // call the method to show user First Name
                PostAroundServiceClient client = new PostAroundServiceClient();
                User user = client.GetUserByID(up.userId);
                client.Close();
                ltrlFname.Text = user.firstName;
                if (!IsPostBack)
                {
                    if (UserIsGrantPermission((int)Enums.Permissions.EmailPermission))
                    {
                        bool isSucceed = Unsubscribe();
                        if (isSucceed)
                            ltrlStatus.Text = "You have been unsubscribed!";
                        else
                            ltrlStatus.Text = "Unsubscribtion Failed. Please Try Again.";
                    }
                    else
                        ltrlStatus.Text = "User already unsubscribed.";
                }
            }
            
        }
        catch (Exception ex)
        {
            PrintStatus(ex.Message);
        }

        

    }

    private UserPermission GetUserPermissionDataFromQueryString(string querystring)
    {
        UserPermission up = null;

        if (!string.IsNullOrWhiteSpace(querystring))
        {
            up = new UserPermission();
            string codeEncoded = Tools.DecodeFrom64(querystring);
            string code = Tools.Decrypt(codeEncoded, true);
            // now we got userid=12&permissionId=1
            string userPart = code.Split('&')[0];
            string permissionPart = code.Split('&')[1];
            string strUserId = userPart.Split('=')[1];
            string strPermissionId = permissionPart.Split('=')[1];

            int userId;
            int permissionId;
            Int32.TryParse(strUserId, out userId);
            Int32.TryParse(strPermissionId, out permissionId);

            up.userId = userId;
            up.permissionId = permissionId;
        }

        return up;
    }
    private bool Unsubscribe()
    {
        up.status = false;
        PostAroundServiceClient client = new PostAroundServiceClient();
        int response = client.SetUserPermission(up);
        client.Close();
        if (response == 0)
            return true;
        return false;
    }

    private bool UserIsGrantPermission(int permissionId)
    {
        PostAroundServiceClient client = new PostAroundServiceClient();
        bool response = client.GetUserPermission(up.userId, permissionId);
        client.Close();
        return response;
    }

    private bool Subscribe()
    {
        up.status = true;
        PostAroundServiceClient client = new PostAroundServiceClient();
        int response = client.SetUserPermission(up);
        client.Close();
        if (response == 1)
            return true;
        return false;
    }

    private void PrintStatus(string what)
    {
        Response.Write(what);
        Response.End();


    }
    protected void btnNo_Click(object sender, EventArgs e)
    {
        if (!UserIsGrantPermission((int)Enums.Permissions.EmailPermission))
        {
            bool isSucceed = Subscribe();
            if (isSucceed)
            {
                ltrlStatus.Text = "And you're back!";
                pnlUndo.Visible = false;
            }
            else
                ltrlStatus.Text = "Subscribtion Failed. Please Try Again.";
        }
        else
        {
            ltrlStatus.Text = "User already subscribed";
        }
    }
}