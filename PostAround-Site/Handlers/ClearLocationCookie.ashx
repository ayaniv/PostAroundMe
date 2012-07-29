<%@ WebHandler Language="C#" Class="ClearLocationCookie" %>

using System;
using System.Web;

public class ClearLocationCookie : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.CacheControl = "no-cache";
        context.Response.AddHeader("Pragma", "no-cache");
        context.Response.Expires = -1;
        
        HttpCookie userCookie = new HttpCookie("UserInfo");
        
        userCookie.Expires = DateTime.Now.AddDays(-1);

        context.Response.Cookies.Add(userCookie);
        string result = "1";

        context.Response.Write(result);
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}