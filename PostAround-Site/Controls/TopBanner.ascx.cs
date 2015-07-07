using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_TopBanner : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int userid = Tools.GetUserIdFromCookie(Context);
        if (userid > 0)
        {
            BannerTop.Visible = false;
        }
    }
}