using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_AddPostContainer : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        

            int userId = Tools.GetUserIdFromCookie(Context);
            if (userId > 0)
            {
                // user is logged in - show add message
                NewPost1.Visible = true;
                LoginMessage.Visible = false;

            }
            else
            {
                //userId is NOT logged in - show login message
                NewPost1.Visible = false;
                LoginMessage.Visible = true;

            }
        
    }
}