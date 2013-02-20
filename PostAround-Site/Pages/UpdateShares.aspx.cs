using PostAroundService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_UpdateShares : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }


    private int CalculateTotalSharesByMsgId(int msgId)
    {
        int totalShares = 0;
        string url = "http://postaround.me/post/" + msgId;

        totalShares += GetTweeterShares(url);
        totalShares += GetFacebookShares(url);
        totalShares += GetPinterestShares(url);

        return totalShares;

    }





    int GetTweeterShares(string url)
    {
        int count = 0;
        try
        {
            System.Web.Script.Serialization.JavaScriptSerializer oSerializer =
            new System.Web.Script.Serialization.JavaScriptSerializer();

            string jsonString = new System.Net.WebClient().DownloadString("http://cdn.api.twitter.com/1/urls/count.json?url=" + url);

            var json = oSerializer.Deserialize<TweeterShares>(jsonString);
            count = json.shares;
        }
        catch (Exception ex)
        {
        }

        return count;
    }


    int GetFacebookShares(string url)
    {
        int count = 0;
        try
        {
            string jsonString = new System.Net.WebClient().DownloadString("http://graph.facebook.com/?id=" + url);

            var json = new System.Web.Script.Serialization.JavaScriptSerializer().Deserialize<FacebookShares>(jsonString);
            count = json.shares;
        }
        catch (Exception ex)
        {
        }
        return count;
    }



    int GetPinterestShares(string url)
    {
        int count = 0;
        try
        {
            System.Web.Script.Serialization.JavaScriptSerializer oSerializer =
            new System.Web.Script.Serialization.JavaScriptSerializer();

            string jsonString = new System.Net.WebClient().DownloadString("http://api.pinterest.com/v1/urls/count.json?callback=&url=" + url);

            var json = oSerializer.Deserialize<TweeterShares>(jsonString);
            count = json.shares;
        }
        catch (Exception ex) { }
        return count;
    }

    protected void btnCalc_Click(object sender, EventArgs e)
    {

        PostAroundServiceClient client = new PostAroundServiceClient();
        int skipNum = 0;
        int takeNum = 20;
        bool isOk = true;
        int totalShares = 0;
        int currMsgId = 0;

        while (isOk)
        {
            totalShares = 0;
            PostAround.Entities.MyMessage[] messages = client.GetMessages("", "", 0, skipNum, takeNum, 0, null, 0, 0, -1, -1);
            if (messages.Count() > 0)
            {

                for (int i = 0; i < messages.Length; i++)
                {
                    currMsgId = messages[i].msgId;
                    totalShares = CalculateTotalSharesByMsgId(currMsgId);
                    client.UpdateMessageSharesByID(currMsgId, totalShares);
                }
                skipNum += takeNum;

            }
            else
            {
                isOk = false;
            }
        }
        client.Close();
        lblStatus.Text = "Done";
    }
}