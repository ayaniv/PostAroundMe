using PostAroundService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Activation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            List<int> ListIds = new List<int>();
            int loginID;
            string code64Encoded = Request.QueryString["code"];
            if (code64Encoded == null)
                throw new Exception("No Query String");
            ListIds = GetUserLoginIDFromQueryString(code64Encoded);

            // make DB call to change the Login status
            PostAroundServiceClient client = new PostAroundServiceClient();
            int result = client.ActivateUserLoginByLoginID(ListIds[1], ListIds[0]);
            client.Close();


            ltrlResult.Text = "Activation Successfully Completed !";
            
            string funcCall = "<script language='javascript'>setTimeout(function(){window.location = 'http://postaround.me';},3000);</script>";
            ClientScript.RegisterStartupScript(this.GetType(), "redirect", funcCall);

        }
        catch (Exception ex)
        {
            Response.Write("Error: " + ex.Message);
            Response.End();
        }
    }

    private List<int> GetUserLoginIDFromQueryString(string key)
    {
        int loginID = 0;
        int userID = 0;

        string strLoginID = null;
        string strUserID = null;

        List<int> result = new List<int>();

        if (!string.IsNullOrWhiteSpace(key))
        {

            string encryptedString = Tools.DecodeFrom64(key).Replace("$", "+");
            string longString = Tools.Decrypt(encryptedString, true);
            //now we got "userid={0}&loginID={1}"; // to be continue
            strUserID = longString.Split('&')[0].Split('=')[1];
            strLoginID = longString.Split('&')[1].Split('=')[1];

            Int32.TryParse(strUserID, out userID);
            Int32.TryParse(strLoginID, out loginID);

            result.Add(userID);
            result.Add(loginID);

        }

        return result;
    }

}