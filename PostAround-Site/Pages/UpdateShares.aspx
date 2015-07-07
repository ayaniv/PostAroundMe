<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UpdateShares.aspx.cs" Inherits="Pages_UpdateShares" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:Button runat="server" Text="Update Total Shares" ID="btnCalc" OnClick="btnCalc_Click" />
        <asp:Label runat="server" Text="Status" ID="lblStatus"></asp:Label>
    </div>
    </form>
</body>
</html>
