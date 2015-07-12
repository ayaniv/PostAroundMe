using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PostAroundService;
using PostAround.Entities;

public partial class Controls_CategoriesBar : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

        PostAroundServiceClient client = new PostAroundServiceClient();
        Category[] arrCategroies = client.GetListCategories();
        client.Close();

        List<Category> lstCategories = arrCategroies.ToList();

        rptCategoriesBar.ItemCreated += new RepeaterItemEventHandler(rptCategories_ItemCreated);

        rptCategoriesBar.DataSource = L10NCategories(lstCategories);
        rptCategoriesBar.DataBind();

    }
    private List<Category> L10NCategories(List<Category> lst)
    {
        List<Category> retVal = new List<Category>();

        foreach (Category item in lst)
        {
            Category cat = new Category();
            cat.ID = item.ID;
            cat.Color = item.Color;
            cat.Name = (String)GetGlobalResourceObject("Resource", Format(item.Name));
            retVal.Add(cat);
        }

        return retVal;
    }

    private string Format(string str)
    {
        string retVal = str.Replace(" ", "").Replace("&", "").Replace("/", "");


        return retVal;
    }

    void rptCategories_ItemCreated(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Category item = (Category)e.Item.DataItem;
            ((TextBox)e.Item.FindControl("txtDropDownCategoryId")).Text = item.ID.ToString();
            ((Label)e.Item.FindControl("ltrlDropDownColor")).Style.Add("background-color", item.Color);
            ((Label)e.Item.FindControl("ltrlDropDownOption")).Text = item.Name;
        }
    }
}