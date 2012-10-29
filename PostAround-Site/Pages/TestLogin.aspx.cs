using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.IO;

public partial class Pages_TestLogin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        FaceBookAppKey = "301703623203131"; //ConfigurationManager.AppSettings["facebookAppKey"];
        siteUrl = ConfigurationManager.AppSettings["SiteUrl"];


        string encodedGabi = "4hhhRMBh6ujYMXHBo1fm7BjZjqWsziyj7GuFcQ$TuZ2Ge9n2$623QVVhyTHF7tUZt0WKKbYyROAVqitvTv0p9HfHIbcXcvoRrH1hiyX7AwQwWF0CZsLBLnr7o4OEpLA2WrqLirgeLBGlafWJMWmxvMzCnEJjj6nqjQvAmlo59lorhF21g533tADFnY7WYkSFwHVJyESxFgOkHWgyjTMUdlq8P44Zqg40/tYYr60BdPHWYTm9UIv8F9gmj$35rr7NPrv6VjhQma9iYRRFYJ6p6fKoeb9C3SFb2C$jBWV9Rd4="; //
        //encodedGabi = "/jwmAtxzUshyIBkt$5E2$ujSmca5truPs1is2MAolbAku0EUd476RA9s4yZFnb$EQTq1JiiSSC2h9NxVK7LTgWvCYcyyyNSnkTZW8P55pHU6BF3pGiJ5W6BYLXAahowU/rfVBzO5ZRAay1WJmb2v0ZO7MtR40Jn/tTU5oAYyit/Tp$bjnCMPmQmfqaOE7rbk6z4Sl0HsxIHoO5AVQ/7Wtl1kvWkYjKZjDIy8NrSVfox31a1xCiTOhMhr8ykeJlLCbbyHa5ZV9KOiRn/1VGzChZ/DTon7J3C/2C$jBWV9Rd4=";
        string realGabi = "AQCWWPynC5KHT-Z2HBtGrexHXWbdLXoo-6u701kLEWf0q1DkUEtn4yfzLaB02B58HwwxjDY9hPbLtRRO0S48rcFnaY7f6eXMOMSmGXVmzVSNhAGAkKZ0se39aQtg-_HJLtBaT4mUBU_w92W4Ao83FZGp6ZBGjkVCFhYfD3CrjFaJwtdlAe4WOP2aeWy6DTKwam5zePbxWV0GXugd9aEKQR-M";
        //realGabi = "AQB8Fl5z6ym0469bqNpbTc2sIb1A1tEzWoBhdhwqdvoOkRuK5hG8KE9oWbHovdAlsNzIgtUyF54AHDAv_LctWu7PW13mPOW5C3PQMOFa4ubrRKXSUiNpIdhEaZtOUWGV6TIWI7c-36byht2K7WjLXztg5P5RSFt0nLcmbemq90PsEya8EolOI5h-fYx6rKVnC_45iw8HDptTyijLOpxy2iLO"; //
        encodedGabi = encodedGabi.Replace('$', '+');
        string decodedGabi = Tools.Decrypt(encodedGabi, true);
        Response.Write(decodedGabi.Equals(realGabi));
        
        string accessToken = GetFacebookAccessToken(decodedGabi);
        if (!string.IsNullOrWhiteSpace(accessToken))
        {
            Response.Write(" Success");
        }
        else
        {
            Response.Write(" Fail");
        }
        

        //Response.Write(decodedGabi.Equals(realGabi));


    }

    public static string siteUrl;
    public static string FaceBookAppKey;

    private string GetFacebookAccessToken(string code)
    {
        string secretCode = "7f985ab276fbafaae72afed868937a06";
        string url = "https://graph.facebook.com/oauth/access_token?client_id={0}&redirect_uri={1}&client_secret={2}&code={3}";

        string page = Path.GetFileNameWithoutExtension(Request.Url.AbsolutePath).ToLower();
        if (page != "default")
        {
            Uri uri = new Uri(HttpContext.Current.Request.Url.AbsoluteUri);
            siteUrl = uri.GetLeftPart(UriPartial.Path);
        }



        url = String.Format(url, FaceBookAppKey, HttpUtility.UrlEncode("http://postaround.me/"), secretCode, code);

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