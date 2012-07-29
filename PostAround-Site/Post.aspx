<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Post.aspx.cs" Inherits="Pages_Post" %>
<%@ Register src="Controls/HeadNew.ascx" tagname="Head" tagprefix="uc1" %>
<%@ Register src="Controls/SinglePost.ascx" tagname="SinglePost" tagprefix="uc1" %>
<%@ Register src="Controls/SimpleHeader.ascx" tagname="SimpleHeader" tagprefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register src="Controls/MetaTags.ascx" tagname="MetaTags" tagprefix="uc1" %>

<html xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://ogp.me/ns#" xmlns:fb="http://ogp.me/ns/fb#" xml:lang="en">
<head runat="server">
    
    <uc1:Head ID="PageHeader1" runat="server" />
    
</head>
<body>

    <form id="form1" runat="server">

    <uc1:SimpleHeader ID="SimpleHeader1" runat="server" />

    
    <div id="SinglePostContainer" style="margin-top:100px; position:absolute; left:50%; margin-left:-447px">

    <uc1:MetaTags ID="MetaTags1" runat="server" />
    <uc1:SinglePost ID="SinglePost1" runat="server" />  
       
    </div>    
    
    


    </form>
</body>
</html>
