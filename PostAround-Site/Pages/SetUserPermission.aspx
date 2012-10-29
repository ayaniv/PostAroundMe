<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SetUserPermission.aspx.cs" Inherits="Pages_SetUserPermission" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="font-family:Arial; font-size:12px; color:#333; padding:10px;">
    Hi <asp:Literal runat="server" ID="ltrlFname"></asp:Literal>,
    <br />
    <span style="font-size:36px;"><asp:Literal runat="server" ID="ltrlStatus"></asp:Literal></span>
    <br />
    <div style="color:#C0C0C0; font-size:11px;" ID="pnlUndo" runat="server">
        Oh No, Please <asp:LinkButton runat="server" ID="btnNo" Text="Subscribe me back !" onclick="btnNo_Click" />
    </div>
    <div style="padding-top:50px">
    go back to <a href="<%=siteUrl %>">PostAround.me</a>
    </div>
    </div>
    </form>
</body>
</html>
