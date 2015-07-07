using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TaiwanLottery : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.MorePosts1.numberOfItems = 15;
        
    }
}