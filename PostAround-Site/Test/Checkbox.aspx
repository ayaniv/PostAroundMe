<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Checkbox.aspx.cs" Inherits="Test_Checkbox" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>

    <form id="form" runat="server">
        <div class="checkboxOne">
            <asp:CheckBox ID="cbActive" runat="server" />
            <asp:Label ID="Label3" AssociatedControlID="cbActive" runat="server"
                ></asp:Label>
        </div>
    </form>
</body>


    <style>
         input[type=checkbox], input[type=radio]
{
    display: none;
}


         .checkboxOne {
	width: 80px;
	height: 26px;
	background: #555;
	margin: 20px 80px;
	position: relative;
	border-radius: 20px;
}

         .checkboxOne label {
	display: block;
	width: 16px;
	height: 16px;
	border-radius: 50%;

	-webkit-transition: all .5s ease;
	-moz-transition: all .5s ease;
	-o-transition: all .5s ease;
	-ms-transition: all .5s ease;
	transition: all .5s ease;
	cursor: pointer;
	position: absolute;
	top: 5px;
	left: 5px;

	background: #ccc;
}
.checkboxOne input[type=checkbox]:checked + label {
	left: 59px;
}
    </style>
</html>
