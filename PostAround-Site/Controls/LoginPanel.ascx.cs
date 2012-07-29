﻿using System;
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

public partial class Controls_LoginPanel : System.Web.UI.UserControl
{
    public static string FaceBookAppKey;
    public static string siteUrl;
    private string MyAccessToken;
    protected void Page_Load(object sender, EventArgs e)
    {
        // Login Scenario
        FaceBookAppKey = ConfigurationManager.AppSettings["facebookAppKey"];
        siteUrl = ConfigurationManager.AppSettings["SiteUrl"];

        int userId = Tools.GetUserIdFromCookie(Context);
        User user = null;

        if (userId > 0)
        {
            // user already logged in, get his details by cookie
            // Get User By Id

            PostAroundServiceClient client = new PostAroundServiceClient();
            user = client.GetCurrentUser(userId);
            client.Close();


        }
        else
        {
            // user isnt logged in
            
            string facebookReturnedServerCode = Request.QueryString["code"];
            
            
            string accessToken = null;

            // in case of returned from facebook login
            // continue the flow to get the user details
            if (!string.IsNullOrWhiteSpace(facebookReturnedServerCode))
            {
                string url = siteUrl;
                //string page = Path.GetFileNameWithoutExtension(Request.Url.AbsolutePath);
                //page = page.ToLower();

                //string encodedState = Request.QueryString["state"];
                //if (!String.IsNullOrWhiteSpace(encodedState))
                //{

                //    string decodedState = Tools.DecodeFrom64(encodedState);
                //    FacebookLoginState fls = ParseStateJSON(decodedState);
                //    url = url + page + "/" + fls.id;
                //}
                //else
                //{
                //    if (page != "default")
                //    {
                //        url += page + ".aspx";
                //    }
                //}

                SaveEncryptedCodeInCookie(facebookReturnedServerCode);
                Response.Redirect(url);
                return;
                
            }
            else
            {
                HttpCookie cookie = Request.Cookies["FacebookServerCode"];
                if (cookie != null)
                {
                    if (!string.IsNullOrEmpty(cookie["code"]))
                    {
                        string encCode = cookie["code"];
                        encCode = encCode.Replace('$', '+');
                        facebookReturnedServerCode = Tools.Decrypt(encCode, true);

                    }

                    if (!string.IsNullOrWhiteSpace(facebookReturnedServerCode))
                    {
                        accessToken = GetFacebookAccessToken(facebookReturnedServerCode);
                        // pass the access token to function to get the UserDetails
                        if (!string.IsNullOrWhiteSpace(accessToken))
                        {
                            user = GetUserDetailsFromToken(accessToken);
                            //save the user in db
                            userId = SaveUserInDB(user);

                        }
                    }
                    CleanCookie("FacebookServerCode");

                }
            }
        }

        if (!IsPostBack)
        {
            if (user != null && userId > 0)
            {
                //save cookie with userId
                string encUserId = Tools.SetUserIdInCookie(userId, Context);

                //Show UserName and Picture on page
                DisplayDetailsOnPage(user);

                //Show User Div
                ShowUserDiv();

                //Return LoggedInResponse
                SetClientResponse(user, encUserId);

                //Set AccessToken
            }
        }
        
    }

    private void ShowUserDiv()
    {
        //Show User Div
        divLogedIn.Style.Remove("display");

        //Hide Login Div
        btnFacebook.Style.Add("display", "none");
    }

    private void ShowLoginButton()
    {
        //Show User Div
        divLogedIn.Style.Add("display", "none");

        //Hide Login Div
        btnFacebook.Style.Remove("display");
    }

    protected void lnkbLogOut_Click(object sender, EventArgs e)
    {
        // to logout we need to do 5 things
        
        // 1. log the user out of facebook since on log in he entered facebook.
        // i chose not to do it
        //LogoutFromFacebook()

        // 2. clean the cookie
        CleanCookie("UserLogin");

        // and the location cookie
        CleanCookie("UserInfo");

        // 3. clear user details from page
        DisplayDetailsOnPage();

        // 4. clear the response loggedIn
        SetClientResponse();

        // 5. display back the login button
        ShowLoginButton();

        // 6. change the text header
        ClearLonLatAddress();

        //hide banner


        //string page = Path.GetFileNameWithoutExtension(HttpContext.Current.Request.Url.AbsoluteUri);
        //page = page.ToLower();
        //if (page == "post")
        //{
        //    siteUrl += page;
        //    string qs = Request.QueryString["id"];
        //    if (!String.IsNullOrWhiteSpace(qs))
        //        siteUrl += "/" + qs;
        //}
        //else
        //{
        //    if (page != "default")
        //        siteUrl += page + ".aspx";
        //}
        Response.Redirect(siteUrl);
        



        


    }

    private void ClearLonLatAddress()
    {
        ltrlClearSavedLocation.Text = "<script>myLat = ''; myLon = ''; address = '';</script>";
    }

    private void CleanCookie(string cookieName)
    {
        HttpCookie userCookie = new HttpCookie(cookieName);
        userCookie.Expires = DateTime.Now.AddDays(-1);
        Context.Response.Cookies.Add(userCookie);
    }

    protected void btnFacebook_Click(object sender, EventArgs e)
    {
        //string state = "";
        //string queryString = Request.QueryString["id"];
        //if (!String.IsNullOrWhiteSpace(queryString))
        //{
        //    state = SetFacebookLoginState(Convert.ToInt32(queryString));
        //    state = Tools.EncodeTo64(state);
        //    state = "&state=" + state;
        //}

        //Uri uri = new Uri(HttpContext.Current.Request.Url.AbsoluteUri);
        //siteUrl = uri.GetLeftPart(UriPartial.Path);

        string url = "https://www.facebook.com/dialog/oauth?client_id={0}&redirect_uri={1}&scope=email,user_birthday" /*+ state*/;
        url = String.Format(url, FaceBookAppKey, HttpUtility.UrlEncode(siteUrl));
        Response.Redirect(url);
    }

    private void LogoutFromFacebook(string site_url, string accessToken)
    {
        // to implement it you need to send valid accessToken. the token from DB maybe expired
        string url = "https://www.facebook.com/logout.php?next={0}&access_token={1}";
        url = String.Format(url, site_url, accessToken);
        Response.Redirect(url);
    }

    private string SetFacebookLoginState(int id)
    {
        string sJSON = null;
        FacebookLoginState fls = new FacebookLoginState();
        fls.id = id;

        System.Web.Script.Serialization.JavaScriptSerializer oSerializer;
        oSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        sJSON = oSerializer.Serialize(fls);
        return sJSON;
    }


    private void SetClientResponse(User user = null, string encUserId = null)
    {
        string sJSON = null;
        if (user != null && !string.IsNullOrWhiteSpace(encUserId))
        {
            System.Web.Script.Serialization.JavaScriptSerializer oSerializer;
            
            LoginResponseSuccess resp = new LoginResponseSuccess();

            resp.Status = 1;
            resp.FirstName = user.firstName;
            resp.LastName = user.lastName;
            resp.Image = user.avatarImageUrl;
            //resp.userID = encUserId;
            resp.link = user.link;

            oSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            sJSON = oSerializer.Serialize(resp);
        }

        ltrlClientResponse.Text = "<script>currentUser = " + sJSON + ";</script>";
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

    private FacebookResponse ParseJSON(string jsonText)
    {
        FacebookResponse req = new FacebookResponse();
        MemoryStream ms = new MemoryStream(Encoding.Unicode.GetBytes(jsonText));
        DataContractJsonSerializer serializer = new DataContractJsonSerializer(req.GetType());
        req = serializer.ReadObject(ms) as FacebookResponse;
        ms.Close();
        return req;
    }

    private FacebookLoginState ParseStateJSON(string jsonText)
    {
        FacebookLoginState req = new FacebookLoginState();
        MemoryStream ms = new MemoryStream(Encoding.Unicode.GetBytes(jsonText));
        DataContractJsonSerializer serializer = new DataContractJsonSerializer(req.GetType());
        req = serializer.ReadObject(ms) as FacebookLoginState;
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
                user.lastName = /*facebookResponse.middle_name + " " + */ facebookResponse.last_name;
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

    private int SaveUserInDB(User user)
    {
        int userId;
        PostAroundServiceClient client = new PostAroundServiceClient();
        userId = client.InsertUpdateUser(user);
        client.Close();
        return userId;

    }

    //private string SaveEncryptedCookie(int userId)
    //{
    //    string encUserId = Tools.Encrypt(userId.ToString(), true).Replace('+', '$');
    //    // save encrypted userid in cookie
    //    HttpCookie userCookie = new HttpCookie("UserLogin");
    //    userCookie["userId"] = encUserId;
    //    userCookie.Expires = DateTime.Now.AddDays(7);
    //    Response.Cookies.Add(userCookie);
    //    return encUserId;
    //}

    private void SaveEncryptedCodeInCookie(string code)
    {
        string encCode = Tools.Encrypt(code, true).Replace('+', '$');
        // save encrypted userid in cookie
        HttpCookie userCookie = new HttpCookie("FacebookServerCode");
        userCookie["code"] = encCode;
        userCookie.Expires = DateTime.Now.AddMinutes(2);
        Response.Cookies.Add(userCookie);
    }

    private void DisplayDetailsOnPage(User user = null)
    {
        if (user != null)
        {
            UserName.InnerHtml = user.firstName + " " + user.lastName;
            UserImage.InnerHtml = "<img src=" + user.avatarImageUrl + "/>";
        }
        else
        {
            UserName.InnerHtml = "";
            UserImage.InnerHtml = "";
        }
        
    
    }

 

}