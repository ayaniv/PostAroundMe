﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Taiwan-Receipt-Lottery-Checker.aspx.cs" Inherits="TaiwanLottery" %>
<%@ Register src="../Controls/HeadNew.ascx" tagname="Head" tagprefix="uc1" %>
<%@ Register src="../Controls/SinglePost_Taiwan.ascx" tagname="SinglePost" tagprefix="uc1" %>
<%@ Register src="../Controls/MorePosts.ascx" tagname="MorePosts" tagprefix="uc1" %>
<%@ Register src="../Controls/SimpleHeader.ascx" tagname="SimpleHeader" tagprefix="uc1" %>
<%@ Register src="../Controls/Footer2.ascx" tagname="Footer" tagprefix="uc1" %>

<%@ Register src="../Controls/MetaTags.ascx" tagname="MetaTags" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://ogp.me/ns#" xmlns:fb="http://ogp.me/ns/fb#" xml:lang="en">
<head runat="server">
    
    
    <uc1:Head ID="PageHeader1" runat="server" />
    
</head>
<body style="height:100%">

    <form id="form1" runat="server">

        <div id="PleaseLogin" style="display:none; float:left; border:6px solid #fff; border-right:8px solid #FFF; z-index:10001; background-color:#FFF; width:320px; top:25%; left:50%; margin-left:-160px; position:fixed;
box-shadow: 0px 6px 6px #666; -moz-box-shadow: 0px 6px 6px #666; -webkit-box-shadow: 0px 6px 6px #666; 

 ">
	
</div>

         <div id="fuzz" class="fuzz" style="filter:alpha(opacity=20); display:none"></div>
            

        <div style="position:relative; min-height:100%">
    <uc1:SimpleHeader ID="SimpleHeader1" runat="server" />
        
    
    <div id="SinglePostContainer" style=" margin:0 auto; padding-top:100px; width:920px;">

    <uc1:MetaTags ID="MetaTags1" runat="server" />
    <uc1:SinglePost ID="SinglePost1" runat="server" />  
       
    </div> 
            
            <uc1:MorePosts ID="MorePosts1" runat="server" />   
    
    <div class="PostBottom">
                
<div id="BottomDiv">
        <uc1:Footer ID="Footer1" runat="server" />
    </div>
</div>
        </div>
         
    </form>
</body>
</html>
