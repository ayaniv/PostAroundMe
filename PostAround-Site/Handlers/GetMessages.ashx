<%@ WebHandler Language="C#" Class="GetMessages" %>

using System;
using System.Web;
using PostAroundService;
using System.Collections.Generic;
using System.Linq;

public class GetMessages : IHttpHandler {

    
    public void ProcessRequest(HttpContext context)
    {
        context.Response.CacheControl = "no-cache";
        context.Response.AddHeader("Pragma", "no-cache");
        context.Response.Expires = -1;

        string currLon = "", currLat = "";
        int regionId = 0;
        int uptoMeters = -1;
        int userid = 0;
        int timeZone = 0;

        int takeNum = 24;

        currLat = context.Request["currLat"];
        currLon = context.Request["currLon"];


        int intSortBy = 0;
        List<int> lstCatId = new List<int>();
        int[] catIds = null;
        int isMine = 0;
        int lastBoxNumber = 0;


        Int32.TryParse(context.Request["TakeNum"], out takeNum);

        string[] arrCategories = context.Request["CategoryId"].Split(',');
        int tempCatId;
        for (int i = 0; i < arrCategories.Length; i++)
        {
            if (Int32.TryParse(arrCategories[i], out tempCatId))
                lstCatId.Add(tempCatId);
        }
        if (lstCatId != null && lstCatId.Count > 0)
        {
            catIds = lstCatId.ToArray<int>();
        }
        
        Int32.TryParse(context.Request["SortBy"], out intSortBy);
        Int32.TryParse(context.Request["IsMine"], out isMine);

        Int32.TryParse(context.Request["uptoMeters"], out uptoMeters);
        Int32.TryParse(context.Request["timeZone"], out timeZone);

        Int32.TryParse(context.Request["fromNumber"], out lastBoxNumber);
        
        userid = Tools.GetUserIdFromCookie(context);

        PostAroundServiceClient client = new PostAroundServiceClient();

        PostAround.Entities.MyMessage[] messages = client.GetMessages(currLat, currLon, userid, lastBoxNumber, takeNum, isMine, catIds, intSortBy, timeZone, uptoMeters, regionId);
        //PostAround.Entities.Comment[] comments = client.GetAllComments(userid, timeZone);
        

        string mapPathResized = System.Configuration.ConfigurationManager.AppSettings["PhysicalPath"] + @"\UploadedResized";
        int currMsgId;
        for (int i = 0; i < messages.Length; i++)
        {
            currMsgId = messages[i].msgId;
            
            
            //attach comments
            if (messages[i].CommentsNumber > 0)
            {
                messages[i].comments = client.GetCommentsByMessageID(currMsgId, userid, timeZone, 5);
            }
                //messages[i].comments =  comments.Where(c => c.messageID == messages[i].msgId).ToArray();
                                        

            if (!string.IsNullOrEmpty(messages[i].image))
            {
                try
                {
                    // attach image height
                    System.Drawing.Image objImage = System.Drawing.Image.FromFile(mapPathResized + "\\" + messages[i].image);
                    messages[i].ImageHeight = objImage.Height;
                }
                catch (Exception ex) {  }
                
                
            }
                
        }

        client.Close();

        System.Web.Script.Serialization.JavaScriptSerializer oSerializer =
        new System.Web.Script.Serialization.JavaScriptSerializer();
        string sJSON = oSerializer.Serialize(messages);


        
        
        context.Response.Write(sJSON);
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