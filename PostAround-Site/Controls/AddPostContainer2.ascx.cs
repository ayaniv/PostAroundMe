using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_AddPostContainer2 : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int userId = Tools.GetUserIdFromCookie(Context);
        if (userId > 0)
        {
            // user is logged in - show add message
            NewPost1.Visible = true;
            LoginMessage.Visible = false;
            
            Container.Style.Add("width", "325px");
            Container.Style.Add("margin-left", "1px");


        }
        else
        {
            //userId is NOT logged in - show login message
            NewPost1.Visible = false;
            LoginMessage.Visible = true;

        }
    }
}