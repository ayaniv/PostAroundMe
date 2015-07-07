<%@ WebHandler Language="C#" Class="channel" %>

using System;
using System.Web;

public class channel : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        HttpResponse response = context.Response;
        response.ClearHeaders();

        string cacheExpire = "31536000";
        response.AppendHeader("Pragma", "public");
        response.AddHeader("Cache-Control", "max-age=" + cacheExpire);
        response.AddHeader("Expires", DateTime.Now.AddYears(1).ToString("ddd, dd MMM yyyy HH':'mm':'ss 'GMT'"));
        
        context.Response.ContentType = "text/html";
        context.Response.Write("<script src=\"//connect.facebook.net/en_US/all.js\"></script>");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}