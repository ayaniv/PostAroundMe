<%@ WebHandler Language="C#" Class="TimeTest" %>

using System;
using System.Web;

public class TimeTest : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Write(DateTime.Now.ToString());
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}