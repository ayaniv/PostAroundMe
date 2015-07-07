using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_testFacebookNotif : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string url = "https://graph.facebook.com/567517451/notifications";


        HttpWebRequest httpWReq =
        (HttpWebRequest)WebRequest.Create(url);

        ASCIIEncoding encoding = new ASCIIEncoding();
        string postData = "access_token=355242331161855|qyYMEnPyR2y3sWK8H7rN-6n3lBU";
        postData += "&template=Test";
        postData += "&href=http://postaround.me";
        byte[] data = encoding.GetBytes(postData);

        httpWReq.Method = "POST";
        httpWReq.ContentType = "application/x-www-form-urlencoded";
        httpWReq.ContentLength = data.Length;

        using (Stream stream = httpWReq.GetRequestStream())
        {
            stream.Write(data, 0, data.Length);
        }

        HttpWebResponse response = (HttpWebResponse)httpWReq.GetResponse();

        string responseString = new StreamReader(response.GetResponseStream()).ReadToEnd();

    }
}