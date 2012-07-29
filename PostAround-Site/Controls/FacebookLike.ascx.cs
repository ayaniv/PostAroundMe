using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

public partial class Controls_FacebookLike : System.Web.UI.UserControl
{
    public static string FaceBookAppKey;
    protected void Page_Load(object sender, EventArgs e)
    {
        FaceBookAppKey = ConfigurationManager.AppSettings["facebookAppKey"];
    }
}