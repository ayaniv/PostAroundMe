using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PostAround.Entities;
using PostAroundService;

public partial class Controls_CategoriesButton : BaseControl
{

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



    protected void Page_Load(object sender, EventArgs e)
    {

        PostAroundServiceClient client = new PostAroundServiceClient();
        Category[] arrCategroies = client.GetListCategories();
        client.Close();

        List<Category> lstCategories = arrCategroies.ToList();

        Category firstCategory = new Category();
        firstCategory.ID = 0;
        firstCategory.Name = "Everything";
        firstCategory.Color = "#e3e3e3";
        lstCategories.Insert(0, firstCategory);


        rptCategoriesColumn1.ItemCreated += new RepeaterItemEventHandler(rptCategories_ItemCreated);

        rptCategoriesColumn1.DataSource = L10NCategories(lstCategories); //.Take(8);
        rptCategoriesColumn1.DataBind();

        //rptCategoriesColumn2.ItemCreated += new RepeaterItemEventHandler(rptCategories_ItemCreated);
        //rptCategoriesColumn2.DataSource = lstCategories.Skip(8).Take(8);
        //rptCategoriesColumn2.DataBind();
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