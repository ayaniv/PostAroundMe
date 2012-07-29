<%@ WebHandler Language="C#" Class="GetMessageByID" %>

using System;
using System.Web;
using PostAroundService;

public class GetMessageByID : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.CacheControl = "no-cache";
        context.Response.AddHeader("Pragma", "no-cache");
        context.Response.Expires = -1;

        string currLon = "", currLat = "";
        int regionId = 0;
        int timeZone = 0;
        int userId = 0;
        int msgId = 0;

        currLon = context.Request["currLon"];
        currLat = context.Request["currLat"];
        Int32.TryParse(context.Request["regionId"], out regionId);
        Int32.TryParse(context.Request["timeZone"], out timeZone);

        Int32.TryParse(context.Request["msgId"], out msgId);

        userId = Tools.GetUserIdFromCookie(context);
        
        PostAroundServiceClient client = new PostAroundServiceClient();

        PostAround.Entities.MyMessage message = client.GetMessageById(msgId, currLon, currLat, regionId, timeZone, userId);

        client.Close();
        

        System.Web.Script.Serialization.JavaScriptSerializer oSerializer =
        new System.Web.Script.Serialization.JavaScriptSerializer();
        string sJSON = oSerializer.Serialize(message);

        context.Response.Write(sJSON);
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}