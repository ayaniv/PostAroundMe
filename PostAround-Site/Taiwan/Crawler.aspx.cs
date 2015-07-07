using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Taiwan_Crawler : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {





        string url = "http://service.etax.nat.gov.tw/etwmain/front/ETW183W6";
            string html = CallUrl(url);
            string yaniv = "yaniv aharon";


        
    }


    private string CallUrl(string url)
    {
        string result = null;
        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
        request.Headers.Add("Accept-Encoding", "gzip,deflate,sdch");
        request.Headers.Add("Accept-Language", "he-IL,he;q=0.8,en-US;q=0.6,en;q=0.4");
        request.Headers.Add("Accept-Charset", "windows-1255,utf-8;q=0.7,*;q=0.3");
        request.UserAgent = "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31";
        
        

        HttpWebResponse response = (HttpWebResponse)request.GetResponse();
        if (response.StatusCode.Equals(HttpStatusCode.OK))
        {
            Stream receiveStream = response.GetResponseStream();
            StreamReader readStream = new StreamReader(receiveStream, Encoding.UTF8);
            result = readStream.ReadToEnd();
        }

        return result;
    }

 
}