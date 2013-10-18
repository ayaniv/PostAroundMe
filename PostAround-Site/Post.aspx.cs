using PostAround.Entities;
using PostAroundService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Post : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.MorePosts1.numberOfItems = 10;

        // for Facebook Login
        if (!string.IsNullOrWhiteSpace(Request.QueryString["code"]))
        {
            string id = Request.QueryString["id"];
            Response.Redirect(siteUrl + "post/" + id);
        }

        if (!IsPostBack)
        {
            string id = Request.QueryString["id"];
            int msgId = 0;
            if (!Int32.TryParse(id, out msgId))
                return;

            string passedSlug = Request.QueryString["title"];
            //get the original slug from database / dymanic method

            PostAroundServiceClient client = new PostAroundServiceClient();
            MyMessage message = client.GetMessageById(msgId, "", "", -1, 0, -1);
            string originalSlug = message.title.Replace(' ', '-');
            client.Close();

           
            if (!originalSlug.Equals(HttpUtility.UrlDecode(passedSlug)))
            {
                var url = String.Format(siteUrl + "post/{0}/{1}", id, originalSlug);
                Response.RedirectPermanent(url, true);
            }
        }
        
    }
}