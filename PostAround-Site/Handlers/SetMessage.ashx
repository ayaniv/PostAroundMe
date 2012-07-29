<%@ WebHandler Language="C#" Class="SetMessage" %>

using System;
using System.Web;
using System.Collections.Generic;
using PostAroundService;

public class SetMessage : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.CacheControl = "no-cache";
        context.Response.AddHeader("Pragma", "no-cache");
        context.Response.Expires = -1;

        int retVal = -1;

        try
        {


            int msgId = 0;


            int userid = 0;


            userid = Tools.GetUserIdFromCookie(context);


            //future plans
            //string strUserId = "";
            //strUserId = context.Request["UserID"];
            //if (!string.IsNullOrWhiteSpace(strUserId))
            //{
            //    strUserId = strUserId.Replace('$', '+');
            //    strUserId = Tools.Decrypt(strUserId, true);
            //    Int32.TryParse(strUserId, out userid);
            //}


            if ((userid > 0) && IsInputOk(context.Request.Params))
            {
                PostAround.Entities.MyMessage msg = new PostAround.Entities.MyMessage();

                msg.catID = Convert.ToInt32(context.Request.Params["CatID"]);
                //msg.FullDate = DateTime.Now;
                msg.description = context.Request.Params["description"];
                msg.latitude = context.Request.Params["lat"];
                msg.longitude = context.Request.Params["lon"];
                msg.regionID = 0;
                msg.title = context.Request.Params["title"];
                msg.type = Convert.ToInt32(context.Request.Params["type"]);
                msg.userid = userid;
                msg.image = context.Request.Params["image"];
                msg.msgAddress = context.Request.Params["address"];

                if (!Int32.TryParse(context.Request["msgId"], out msgId))
                {
                    msgId = 0;
                }

                msg.msgId = msgId;

                PostAroundServiceClient client = new PostAroundServiceClient();

                retVal = client.InsertMessage(msg);

                client.Close();
            }

        }
        catch (Exception ex)
        {

        }


        context.Response.Write(retVal.ToString());
        context.Response.End();



    }
    
    public bool IsInputOk(System.Collections.Specialized.NameValueCollection collection)
    {
        
        int tempNum;

        string catId = collection["catID"];
        string title = collection["title"];
        string details = collection["description"];
        string image = collection["image"];
        string lat = collection["lat"];
        string lon = collection["lon"];
        string address = collection["address"];
        string postToWall = collection["postToWall"];
        string msgId = collection["msgId"];
        string userId = collection["userID"];
        string type = collection["type"];

        //mandatory check
        if (string.IsNullOrWhiteSpace(catId))
            return false;
        if (string.IsNullOrWhiteSpace(title))
            return false;
        if (string.IsNullOrWhiteSpace(details))
            return false;
        if (string.IsNullOrWhiteSpace(lat))
            return false;
        if (string.IsNullOrWhiteSpace(lon))
            return false;

        if (details.Contains("<") || details.Contains("--"))
            return false;
        
        //values check
        if (!Int32.TryParse(catId, out tempNum))
            return false;
        if (!Int32.TryParse(type, out tempNum))
            return false;
        
        return true;
        
    }

 
    public bool IsReusable {
        get {
            return false;
        }
    }

}