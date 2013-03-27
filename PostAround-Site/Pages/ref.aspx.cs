using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_ref : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string strUserID = Request.QueryString["uid"];
        int userID;
        if (Int32.TryParse(strUserID, out userID))
        {
            Tools.SetUserIdInCookie(userID, Context);
        }
        
    }
}