using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

public partial class Controls_SimpleHeader : System.Web.UI.UserControl
{

    protected string homePage;

    protected void Page_Load(object sender, EventArgs e)
    {

        homePage = ConfigurationManager.AppSettings["HomePage"];


    }
}