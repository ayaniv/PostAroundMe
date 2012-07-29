<%@ WebHandler Language="C#" Class="Logout" %>

using System;
using System.Web;

public class Logout : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.CacheControl = "no-cache";
        context.Response.AddHeader("Pragma", "no-cache");
        context.Response.Expires = -1;
        string result = "";

        HttpCookie userCookie = new HttpCookie("UserLogin");

        userCookie.Expires = DateTime.Now.AddDays(-1);

        context.Response.Cookies.Add(userCookie);
        result = "1";

        context.Response.Write(result);
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}