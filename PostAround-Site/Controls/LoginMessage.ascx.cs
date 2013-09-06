using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_LoginMessgae : BaseControl
{
    public static string urlForgotPassword;
    protected void Page_Load(object sender, EventArgs e)
    {
        urlForgotPassword = siteUrlSecured + "app/ForgotPassword";

    }
}