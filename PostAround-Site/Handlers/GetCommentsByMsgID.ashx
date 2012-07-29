<%@ WebHandler Language="C#" Class="GetCommentsByMsgID" %>

using System;
using System.Web;
using PostAroundService;

public class GetCommentsByMsgID : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.CacheControl = "no-cache";
        context.Response.AddHeader("Pragma", "no-cache");
        context.Response.Expires = -1;

        string strId = "";
        int ID;
        int timeZone;

        int userId = Tools.GetUserIdFromCookie(context);

        if (!Int32.TryParse(context.Request["timeZone"], out timeZone))
        {
            timeZone = 0;
        }

        strId = context.Request["id"];

        string sJSON = "";


        if (Int32.TryParse(strId, out ID))
        {
            PostAroundServiceClient client = new PostAroundServiceClient();

            PostAround.Entities.Comment[] currComments = client.GetCommentsByMessageID(ID, userId, timeZone);

            client.Close();

            System.Web.Script.Serialization.JavaScriptSerializer oSerializer =
            new System.Web.Script.Serialization.JavaScriptSerializer();
            sJSON = oSerializer.Serialize(currComments);
        }

        context.Response.Write(sJSON);
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}