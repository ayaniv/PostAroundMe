<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Taiwan-Receipt-Lottery-Checker.aspx.cs" Inherits="Taiwan_Taiwan_Receipt_Lottery_Checker" %>

<%@ Register src="../Controls/FacebookLike.ascx" tagname="FacebookLike" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Taiwan Lottery Numbers Online Checker | Taiwan Receipt Lottery</title>
    <link rel="stylesheet" href="../css/screen.css" type="text/css" media="screen" charset="utf-8" />
</head>
<body>

<div id="fb-root"></div>
<script>    (function (d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
        fjs.parentNode.insertBefore(js, fjs);
    } (document, 'script', 'facebook-jssdk'));</script>


    <form id="form1" runat="server">

            <div class="HeadLine" ></div>
    <div class="HairHeadLine"></div>
        <div class="BottomDiv" id="BottomDiv" style="background:none">
        <div class="Logo">
        <h1>Taiwan Receipt Lottery / Taiwan Lottery / Uniform Invoice Taiwan Online Checker</h1>
        
            台灣彩券
            <br />
            Check if you won Taiwan Lottery Automatically !!
        <br />
        with <b>Taiwan Receipt Lottery Winning Numbers</b> Online Web Checker
        

                </div>  
        <br />  
        <div class="Text" style="font-style:normal; color:#424E55; font-size:13px;">


    
    Winning numbers for months <asp:DropDownList ID="ddMonth" OnSelectedIndexChanged="Index_Changed" AutoPostBack="true" runat="server"></asp:DropDownList>
    
    as can be shown <a href="http://service.etax.nat.gov.tw/etwmain/front/ETW183W6" target="_blank">here</a>

    <br /><br />
    <table style="wdith:800">
    <tr>
    <td>Special Prize Number:</td>
    <td><asp:TextBox id="txtSpecial" runat="server"></asp:TextBox></td>
    <td style="padding-left:30px;">First Prize #1:</td>
    <td><asp:TextBox id="txtFirst1" runat="server"></asp:TextBox></td>
    <td style="padding-left:30px;">Addition #1:</td>
    <td><asp:TextBox id="txtAdd1" runat="server"></asp:TextBox></td>
    </tr>
    <tr>
    <td>Grand Prize Number:</td>
    <td><asp:TextBox id="txtGrand" runat="server"></asp:TextBox></td>
    <td style="padding-left:30px;">First Prize #2:</td>
    <td><asp:TextBox id="txtFirst2" runat="server"></asp:TextBox></td>
    <td style="padding-left:30px;">Addition #2:</td>
    <td><asp:TextBox id="txtAdd2" runat="server"></asp:TextBox></td>
    </tr>

    <tr>
    <td></td>
    <td></td>
    <td style="padding-left:30px;">First Prize #3:</td>
    <td><asp:TextBox id="txtFirst3" runat="server"></asp:TextBox></td>
    <td></td>
    <td></td>
    </tr>

    </table>
    
    </div>
    <div>
            <h4>how to check taiwan receipt lottery?</h4>
        Don't need to know anything, simply enter your receipts numbers below
        and check how much money you won.<br />
        Enter the last <b>3 digits</b> (or more) of your receipts <b>seperated by a comma (,)</b> and click "Check":<br /><br />
    <asp:TextBox TextMode="MultiLine" ID="txtNumbers" runat="server" style="width:800px; height:100px"></asp:TextBox>
    
    <br />
    <asp:Button ID="btnCheck" runat="server" Text="Check" onclick="btnCheck_Click" />
    <br />
    <br />
    Checking Results:
    <br />
    <asp:TextBox ID="txtResults" Enabled="false" style="width:800px" runat="server" TextMode="MultiLine"></asp:TextBox>
    <br />
    <hr />
    Brought to you by:
    
    <div style="border:1px solid; background-color:#fff947; width:780px; height:50px; padding:10px; ">
        <div style="float:left; padding-right:10px;">
    <a href="http://postaround.me"><img border="0" src="../images/logo_neto.png" alt="Local Pinboard" width="258" height="50" style="border:none" /></a>
    </div>
    <div class="Text" style="margin-top:7px; text-align:center; ">
    
    
    
    <a href="http://postaround.me" style="font-style:normal; text-decoration:none;  color:#424E55; font-weight:bold; text-transform:uppercase;  font-family:Trebuchet MS, Arial; font-size:14px;">
    READ <span style="font-family:Helvetica">&</span> SHARE POSTS IN YOUR OWN NEIGHBORHOOD
    <br />ON A PINBOARD BASED ON YOUR LOCATION
    </a>
    
    
    
    </div>
    <br />
    </div>
            
    <br />
    
   <div class="fb-comments" data-href="http://postaround.me/taiwan" data-num-posts="2" data-width="470"></div>
   <uc1:FacebookLike ID="FacebookLike1" runat="server" />
   
    </div>
    </div>
    </form>


    <script type="text/javascript">

        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-28432512-1']);
        _gaq.push(['_trackPageview']);

        (function () {
            var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();

</script>


</body>
</html>
