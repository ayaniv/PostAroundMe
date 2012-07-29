<%@ WebHandler Language="C#" Class="SaveLocation" %>

using System;
using System.Web;

public class SaveLocation : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.CacheControl = "no-cache";
        context.Response.AddHeader("Pragma", "no-cache");
        context.Response.Expires = -1;
        string result = "";

        string lat = context.Request.Params["lat"];
        string lng = context.Request.Params["lng"];
        string address = context.Request.Params["address"];
        string dontShowMeAgainWelcome = context.Request.Params["dontShowMeAgainWelcome"];

        HttpCookie userCookie = new HttpCookie("UserInfo");
        if (!string.IsNullOrEmpty(lat))
            userCookie["lat"] = lat;

        if (!string.IsNullOrEmpty(lng))
            userCookie["lng"] = lng;

        if (!string.IsNullOrEmpty(address))
            userCookie["address"] = Tools.EncodeTo64(address);

        if (!string.IsNullOrEmpty(dontShowMeAgainWelcome))
            userCookie["dontShowMeAgainWelcome"] = dontShowMeAgainWelcome;
        
        
        userCookie.Expires = DateTime.Now.AddDays(14);
        
        context.Response.Cookies.Add(userCookie);
        result = "1";
        
        context.Response.Write(result);
        context.Response.End();
    }




    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}