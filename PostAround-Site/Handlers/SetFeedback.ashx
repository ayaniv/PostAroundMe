<%@ WebHandler Language="C#" Class="SetFeedback" %>

using System;
using System.Web;
using PostAroundService;

public class SetFeedback : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.CacheControl = "no-cache";
        context.Response.AddHeader("Pragma", "no-cache");
        context.Response.Expires = -1;

        PostAround.Entities.Feedback feedback = new PostAround.Entities.Feedback();

        feedback.date = DateTime.Now;
        feedback.email = context.Request.Params["email"];
        feedback.message = context.Request.Params["message"];
        feedback.name = context.Request.Params["name"];

        PostAroundServiceClient client = new PostAroundServiceClient();

        int retVal = client.SetFeedback(feedback);

        client.Close();

        context.Response.Write(retVal.ToString());
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}