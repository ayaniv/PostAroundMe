using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PostAroundService;
using PostAround.Entities;
using System.Configuration;
using System.Web.UI.HtmlControls;
using System.Text.RegularExpressions;
using System.Xml.Linq;

public partial class Controls_SinglePost_Taiwan : BaseControl
{
    
  
  

    public string PageTitle { get; set; }



    private void SetTextBoxesByValue(string date)
    {
        string fileName = ConfigurationManager.AppSettings["PhysicalPath"] + @"\Taiwan\Invoice\" + "Results.xml";
        var xmlDocument = XDocument.Load(fileName);
        List<XElement> lstCombo = xmlDocument.Descendants("Results").ToList<XElement>();
        List<XElement> lst = (from a in lstCombo where a.Attribute("Date").Value == date select a).Elements().ToList<XElement>();


        txtSpecial.Text = lst[0].Value;
        txtGrand.Text = lst[1].Value;
        txtFirst1.Text = lst[2].Value;
        txtFirst2.Text = lst[3].Value;
        txtFirst3.Text = lst[4].Value;
        txtAdd1.Text = lst[5].Value;
        txtAdd2.Text = lst[6].Value;
    }

    protected void Index_Changed(Object sender, EventArgs e)
    {


        SetTextBoxesByValue(ddMonth.SelectedItem.Text);

    }


    protected void Page_Load(object sender, EventArgs e)
    {
        this.Page.Title = "Taiwan Lottery Numbers Online Checker | Taiwan Receipt Lottery";
        if (!IsPostBack)
        {
            string fileName = ConfigurationManager.AppSettings["PhysicalPath"] + @"\Taiwan\Invoice\" + "Results.xml";
            var xmlDocument = XDocument.Load(fileName);
            List<XElement> lstCombo = xmlDocument.Descendants("Results").ToList<XElement>();//convert to listid

            ddMonth.DataSource = lstCombo.Select(x => x.Attribute("Date").Value);
            ddMonth.DataBind();
            SetTextBoxesByValue(lstCombo.First().Attribute("Date").Value);
        }
    }

    private int GetResultByNumber(string currNum)
    {
        if (currNum.Length == 8)
        {
            if (txtSpecial.Text.Equals(currNum) && txtSpecial.Text != "")
                return 10;
            if (txtGrand.Text.Equals(currNum) && txtGrand.Text != "")
                return 9;
        }

        if (txtSpecial.Text.EndsWith(currNum) && txtSpecial.Text != "")
            return 11;
        if (txtGrand.Text.EndsWith(currNum) && txtGrand.Text != "")
            return 11;

        int[] values = new int[3];
        if (txtFirst1.Text != "")
            values[0] = GetSecondPrizeResults(txtFirst1.Text, currNum);
        if (txtFirst2.Text != "")
            values[1] = GetSecondPrizeResults(txtFirst2.Text, currNum);
        if (txtFirst3.Text != "")
            values[2] = GetSecondPrizeResults(txtFirst3.Text, currNum);

        if (values.Max() != 0)
            return values.Max();

        if ((currNum.EndsWith(txtAdd1.Text) && txtAdd1.Text != "") || (currNum.EndsWith(txtAdd2.Text) && txtAdd2.Text != ""))
            return 3;
        return 0;
    }

    private int GetSecondPrizeResults(string winNumber, string currNum)
    {
        string currWinNumber;
        for (int i = 8; i > 2; i--)
        {
            currWinNumber = winNumber.Substring(8 - i, i);
            if (currNum.EndsWith(currWinNumber))
                return i;
        }
        return 0;
    }

    protected void btnCheck_Click(object sender, EventArgs e)
    {
        string text = txtNumbers.Text;
        text = text.Replace(" ", "");
        string[] array = text.Split(',');
        long wonPrizeSum = 0;
        bool hasPotentionWinningBigPrize = false;

        List<int> arrayIndex = new List<int>();
        List<int> arrayIndexPotential = new List<int>();
        for (int i = 0; i < array.Length; i++)
        {
            if (!string.IsNullOrWhiteSpace(array[i]))
            {
                int res = GetResultByNumber(array[i]);
                if (res == 11)
                {
                    hasPotentionWinningBigPrize = true;
                    arrayIndexPotential.Add(i + 1);
                }
                else if (res > 2)
                {
                    arrayIndex.Add(i + 1);
                    switch (res)
                    {
                        case 10:
                            wonPrizeSum += 10000000;
                            break;
                        case 9:
                            wonPrizeSum += 2000000;
                            break;
                        case 8:
                            wonPrizeSum += 200000;
                            break;
                        case 7:
                            wonPrizeSum += 40000;
                            break;
                        case 6:
                            wonPrizeSum += 10000;

                            break;
                        case 5:
                            wonPrizeSum += 4000;

                            break;
                        case 4:
                            wonPrizeSum += 1000;

                            break;
                        case 3:
                            wonPrizeSum += 200;
                            break;
                        default:
                            wonPrizeSum += 0;
                            break;
                    }
                }
            }
        }
        if (wonPrizeSum > 0)
        {
            txtResults.Text = "You won " + wonPrizeSum.ToString() + "NT";
            string indexes = "";
            for (int i = 0; i < arrayIndex.Count; i++)
            {
                indexes += arrayIndex[i].ToString() + " ";
            }

            txtResults.Text += " Receipts Number: " + indexes;

        }
        else
        {
            txtResults.Text = "Nothing Found";
        }
        if (hasPotentionWinningBigPrize)
        {
            string indexesPotential = "";
            for (int i = 0; i < arrayIndexPotential.Count; i++)
            {
                indexesPotential += arrayIndexPotential[i].ToString() + " ";
            }
            txtResults.Text += "\nPotential Winning in big prize, please re-check reciepts number: " + indexesPotential;
        }


    }


 

    

    


 

    private string FormatText(string text) {


        text = Linkify(text);
        text = text.Replace("\n", "<br/>");
        return text;

    }


    protected string GetLanguageAlign(string str)
    {
        string direction = GetLanguageDirection(str);
        if (direction == "rtl")
            return "right";
        return "left";

    }

    protected string GetLanguageDirection(string str)
    {
        //english
        string direction = "ltr";

        if (str == null)
            return direction;

        str = Regex.Replace(str, @"[\d-]", string.Empty);
        str = str.Trim();


        //hebrew
        if ((!string.IsNullOrWhiteSpace(str)) && (str[0] > 0x590) && (str[0] < 0x5FF))
            direction = "rtl";

        //arabic
        else if ((!string.IsNullOrWhiteSpace(str)) &&  (str[0] > 0x600) && (str[0] < 0x6FF))
            direction = "rtl";

        return direction;

    }

    private string Linkify(string inputText) {
        //URLs starting with http://, https://, or ftp://
        string replacePattern1 = @"((http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:/~\+#]*[\w\-\@?^=%&amp;/~\+#])?)";
        string replacedText = Regex.Replace(inputText, replacePattern1, "<a target='_blank' href='$1'>$1</a>");
        

        //URLs starting with www. (without // before it, or it'd re-link the ones done above)
        string replacePattern2 = @"(^|[^\/])(www\.[\S]+(\b|$))";
        replacedText = Regex.Replace(replacedText, replacePattern2, "$1<a target='_blank' href='http://$2'>$2</a>");
        
        return replacedText;

    }




}
