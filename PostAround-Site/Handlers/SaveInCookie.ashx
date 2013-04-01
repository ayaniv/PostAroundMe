<%@ WebHandler Language="C#" Class="SaveInCookie" %>

using System;
using System.Web;
using PostAroundService;

public class SaveInCookie : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.CacheControl = "no-cache";
        context.Response.AddHeader("Pragma", "no-cache");
        context.Response.Expires = -1;


        int userID = 0;
        string result = null;
        int retVal = 0;
        string facebookID = context.Request["facebookID"];
        string secretCode = context.Request["secretCode"];
        
        
        if (!string.IsNullOrWhiteSpace(facebookID))
        {
            if (CheckSum(secretCode))
            {
                PostAroundServiceClient client = new PostAroundServiceClient();
                userID = client.GetUserIdByFacebookId(facebookID);
                client.Close();

                result = Tools.SetUserIdInCookie(userID, context);
                if (!string.IsNullOrWhiteSpace(result))
                    retVal = 1;
            }
        }


        System.Web.Script.Serialization.JavaScriptSerializer oSerializer =
        new System.Web.Script.Serialization.JavaScriptSerializer();
        string sJSON = oSerializer.Serialize(retVal);

        context.Response.Write(sJSON);
        context.Response.End();
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