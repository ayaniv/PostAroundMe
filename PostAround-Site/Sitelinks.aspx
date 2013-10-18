<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Sitelinks.aspx.cs" Inherits="Sitelinks" %>
<%@ Register src="Controls/HeadNew.ascx" tagname="Head" tagprefix="uc1" %>
<%@ Register src="Controls/SimpleHeader.ascx" tagname="SimpleHeader" tagprefix="uc1" %>
<%@ Register src="Controls/Footer2.ascx" tagname="Footer" tagprefix="uc1" %>

<%@ Import Namespace="PostAround.Entities" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>Site Links : Post Around Me</title>
<uc1:Head ID="Head1" runat="server" />
    
    <style type="text/css">
	    .LinksContainer a  { background:#f8f8f8; height:20px; margin: 0 5px 5px 0; float:left; padding: 2px 4px 2px 4px; text-decoration:none; color:#333 }
	    .LinksContainer a:hover { background-color:#57849d !important; color:#fff !important; }
    </style>

</head>
<body>

    <form id="form1" runat="server">

    <uc1:SimpleHeader ID="SimpleHeader1" runat="server" />
    <div class="LinksContainer" style="margin-top:100px; margin-left:40px; margin-right:40px;">
    <asp:Repeater runat="server" ID="rptLinks">
    <HeaderTemplate></HeaderTemplate>
    <ItemTemplate>
    <a href="<%=siteUrl %>post/<%# ((BriefMessage)Container.DataItem).msgId %>/<%# ((BriefMessage)Container.DataItem).Title.Replace(' ', '-') %>"><%# ((BriefMessage)Container.DataItem).Title %></a>
    </ItemTemplate>
    <FooterTemplate></FooterTemplate>
    </asp:Repeater>
        <a href="<%=siteUrl %>in/ביצרון">לוח מודעות שכונת ביצרון</a>
        <a href="<%=siteUrl %>in/אוניברסיטת_תל_אביב">לוח מודעות אוניברסיטת תל אביב</a>
    </div>
    
    </form>
</body>
</html>
