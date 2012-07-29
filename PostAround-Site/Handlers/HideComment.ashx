<%@ WebHandler Language="C#" Class="HideComment" %>

using System;
using System.Web;
using PostAroundService;

public class HideComment : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.CacheControl = "no-cache";
        context.Response.AddHeader("Pragma", "no-cache");
        context.Response.Expires = -1;


        
        int userid = 0;

        //string strUserId = "";
        //strUserId = context.Request["userID"];
        //if (!string.IsNullOrWhiteSpace(strUserId))
        //{
        //    strUserId = strUserId.Replace('$', '+');
        //    strUserId = Tools.Decrypt(strUserId, true);
        //    Int32.TryParse(strUserId, out userid);
        //}

        userid = Tools.GetUserIdFromCookie(context);
        
        
        
        int res = -1;
        // TODO: check if current user id == userID

        if (userid > 0)
        {
            int commentId = Convert.ToInt32(context.Request.Params["commentID"]);
            PostAroundServiceClient client = new PostAroundServiceClient();
            res = client.DeleteComment(commentId, userid);
            client.Close(); 
        }


        context.Response.Write(res.ToString());
        context.Response.End();
    }
    
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}