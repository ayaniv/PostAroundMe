<%@ WebHandler Language="C#" Class="CheckLoginData" %>

using System;
using System.Web;
using PostAround.Entities;
using PostAroundService;

public class CheckLoginData : IHttpHandler
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.CacheControl = "no-cache";
        context.Response.AddHeader("Pragma", "no-cache");
        context.Response.Expires = -1;

        //gets login data from user
        //encode the password
        // pass it to server
        //if user ID is returned - save it to cookie and return Success
        // else - return Fail.
        LoginDetail ld = new LoginDetail();
        ld.email = context.Request.Params["email"];
        ld.password = context.Request.Params["password"];
        string result = null;
        int retVal = 0;
        int userID = -1;
        if (!string.IsNullOrWhiteSpace(ld.email) && !string.IsNullOrWhiteSpace(ld.password))
        {
            ld.password = Tools.HashIt(ld.password);
            PostAroundServiceClient client = new PostAroundServiceClient();
            userID = client.CheckLoginData(ld);
            client.Close();
            if (userID > 0)
                result = Tools.SetUserIdInCookie(userID, context);
        }

        retVal = userID;

        System.Web.Script.Serialization.JavaScriptSerializer oSerializer =
        new System.Web.Script.Serialization.JavaScriptSerializer();
        string sJSON = oSerializer.Serialize(retVal);

        context.Response.Write(sJSON);
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}