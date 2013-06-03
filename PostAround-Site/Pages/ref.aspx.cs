using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using PostAround.Entities;
using System.IO;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Globalization;
using PostAroundService;

public partial class Pages_ref : BasePage
{

    public static string FaceBookAppKey;
 
    public static string siteUrlSecured;
    public static string secretCode;

    string facebookID;
    protected void Page_Load(object sender, EventArgs e)
    {
     
       
        secretCode = Tools.Encrypt(DateTime.Now.ToString(), true).Replace('+', '$');
      
        siteUrlSecured = ConfigurationManager.AppSettings["SiteUrlSecured"];
        FaceBookAppKey = ConfigurationManager.AppSettings["facebookAppKey"];






        // Login Scenario - all this to get the user logged in the application. insane.
        
        //siteUrl = "http://localhost/postaround/pages/ref.aspx";
        //if ((!IsPostBack) && string.IsNullOrWhiteSpace(Request.QueryString["code"]))
        //{
        //    string url = "https://www.facebook.com/dialog/oauth?client_id={0}&redirect_uri={1}" /*+ state*/;
        //    url = String.Format(url, FaceBookAppKey, HttpUtility.UrlEncode(siteUrl));
        //    Response.Redirect(url);
        //}
        //else
        //{
        //    string facebookReturnedServerCode = null;
        //    string accessToken = null;
        //    if (!string.IsNullOrWhiteSpace(Request.QueryString["code"]))
        //    {
        //        facebookReturnedServerCode = Request.QueryString["code"];

        //        if (!string.IsNullOrWhiteSpace(facebookReturnedServerCode))
        //        {
        //            accessToken = GetFacebookAccessToken(facebookReturnedServerCode);
        //            // pass the access token to function to get the UserDetails
        //            if (!string.IsNullOrWhiteSpace(accessToken))
        //            {
        //                User user = GetUserDetailsFromToken(accessToken);
        //                facebookID = user.facebookID;
        //                //Get UserID from FacebookID and saveit in cookie




        //                PostAroundServiceClient client = new PostAroundServiceClient();
        //                int userID = client.GetUserIdByFacebookId(facebookID);
        //                client.Close();

        //                Tools.SetUserIdInCookie(userID, Context);



        //            }
        //        }
        //    }

           
        //}

    }


    private FacebookResponse ParseJSON(string jsonText)
    {
        FacebookResponse req = new FacebookResponse();
        MemoryStream ms = new MemoryStream(Encoding.Unicode.GetBytes(jsonText));
        DataContractJsonSerializer serializer = new DataContractJsonSerializer(req.GetType());
        req = serializer.ReadObject(ms) as FacebookResponse;
        ms.Close();
        return req;
    }

    private string GetFacebookResponse(string token)
    {
        string response = null;
        try
        {
            string url = String.Format("https://graph.facebook.com/me?access_token={0}", token);
            response = Tools.CallUrl(url);

        }
        catch (Exception ex)
        {
        }

        return response;
    }

    private User GetUserDetailsFromToken(string token)
    {

        string response = GetFacebookResponse(token);
        User user = null;

        if (response != null)
        {
            FacebookResponse facebookResponse = ParseJSON(response);
            if (facebookResponse != null)
            {
                // for the date parsing
                CultureInfo provider = CultureInfo.CurrentCulture;

                // make user instance and put values in it
                user = new User();
                user.firstName = facebookResponse.first_name;

                if (!string.IsNullOrWhiteSpace(facebookResponse.middle_name))
                    user.lastName = facebookResponse.middle_name + " " + facebookResponse.last_name;
                else
                    user.lastName = facebookResponse.last_name;

                user.facebookID = facebookResponse.id;
                user.email = facebookResponse.email;
                user.avatarImageUrl = "https://graph.facebook.com/" + facebookResponse.id + "/picture";
                user.gender = facebookResponse.gender;
                if (facebookResponse.birthday != null)
                {
                    user.birthday = DateTime.ParseExact(facebookResponse.birthday, "MM/dd/yyyy", provider);
                }
                user.link = facebookResponse.link;
                if (facebookResponse.timezone != null)
                {
                    user.timezone = Convert.ToInt32(facebookResponse.timezone);
                }
                user.facebookToken = token;
                user.regDate = DateTime.Now;
            }


        }
        return user;
    }

    private string GetFacebookAccessToken(string code)
    {
        string secretCode = ConfigurationManager.AppSettings["facebookAppSecret"];
        string url = "https://graph.facebook.com/oauth/access_token?client_id={0}&redirect_uri={1}&client_secret={2}&code={3}";

        string page = Path.GetFileNameWithoutExtension(Request.Url.AbsolutePath).ToLower();
        if (page != "default")
        {
            Uri uri = new Uri(HttpContext.Current.Request.Url.AbsoluteUri);
            siteUrl = uri.GetLeftPart(UriPartial.Path);
        }



        url = String.Format(url, FaceBookAppKey, HttpUtility.UrlEncode(siteUrl), secretCode, code);

        string response = Tools.CallUrl(url);
        // now we got the string string: 'access_token=gfdgfdgd&expires=5108' or an error message

        string accessToken = null;
        if (response.Contains("access_token"))
        {
            //take only the access token part
            accessToken = response.Split('&')[0];

            //take only the token itself
            accessToken = accessToken.Split('=')[1];


        }

        return accessToken;

    }
        
    
}