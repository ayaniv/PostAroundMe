<%@ WebHandler Language="C#" Class="SaveInCookie" %>

using System;
using System.Web;
using PostAroundService;
using System.IO;
using System.Runtime.Serialization.Json;
using System.Text;

public class SaveInCookie : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.CacheControl = "no-cache";
        context.Response.AddHeader("Pragma", "no-cache");
        context.Response.Expires = -1;


        int userID = 0;
        string result = null;
        int retVal = 0;
        string accessToken = context.Request["accessToken"];


        if (!string.IsNullOrWhiteSpace(accessToken))
        {

            try
            {
                string url = String.Format("https://graph.facebook.com/me?access_token={0}", accessToken);
                string response = Tools.CallUrl(url);
                FacebookResponse facebookResponse = ParseJSON(response);
                string facebookID = facebookResponse.id;


                PostAroundServiceClient client = new PostAroundServiceClient();
                userID = client.GetUserIdByFacebookId(facebookID);
                client.Close();

                result = Tools.SetUserIdInCookie(userID, context);
                if (!string.IsNullOrWhiteSpace(result))
                    retVal = 1;
            }
            catch (Exception ex) { }
             
        }


        System.Web.Script.Serialization.JavaScriptSerializer oSerializer =
        new System.Web.Script.Serialization.JavaScriptSerializer();
        string sJSON = oSerializer.Serialize(retVal);

        context.Response.Write(sJSON);
        context.Response.End();
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
    
    private bool CheckSum(string time)
    {
        time = time.Replace('$', '+');
        string decryptedTime = Tools.Decrypt(time, true);
        DateTime dateClient = DateTime.Parse(decryptedTime);
        DateTime dateNow = DateTime.Now.AddSeconds(-2);
        if (dateClient > dateNow)
            return true;
        return false;
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}