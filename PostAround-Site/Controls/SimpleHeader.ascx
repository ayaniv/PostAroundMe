<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SimpleHeader.ascx.cs" Inherits="Controls_SimpleHeader" %>
<%@ Register src="LoginPanel.ascx" tagname="FacebookLogin" tagprefix="uc1" %>

<div id="MainHeader" style="border-bottom:1px solid #e2ddcf; min-width:910px; position:fixed !important; top:0; left:0; z-index:1000; height:80px; background:#FCFCFC url('<%=siteUrl %>images/bgtop2.png'); width:100%; position:relative;">
        <div style="margin:0 auto; padding:0">

        <div style="width:270px; height:90px; background:url('<%=siteUrl %>images/bgtop2.png') repeat-x; position:absolute; left:50%; margin-left:-135px;">
        
        <div style="width:270px; text-align:center; height:90px; background:url('<%=siteUrl %>images/logoBg3.png') repeat-x; float:left;">
        
            <div class="LogoClear"><a href="<%=siteUrl %>"><img src="<%=siteUrl %>images/logoHead.png" title="Local Pinboard"  style="width:246px; height:43px; border:0" /></a></div>
            <div class="LogoText">Local Pinboard</div>
        
        
        </div>
        
        </div>

        <div id="RightWing" style="float:right; height:80px; width:400px; margin-right:17px;">
        
        <ul class="HeaderList" style="float:right">
       <li style="cursor:pointer;" id="divMobileLink">
                <span class="MobileIcon"></span>
                <span style="font-weight:bold">
                    Mobile
                </span>
                </li>
        <li id="divLogin" style="margin-right:20px"><uc1:FacebookLogin ID="Facebook" runat="server" /></li>
        </ul>



 
        
        </div>
        <div id="LeftWing" style="float:left; height:80px; width:400px; margin-left:39px; ">
       
       <a href="<%=siteUrl %>" style="float:left; font-size:12px; height:15px; font-weight:bold; font-family:Arial; color:#fbf9f4; padding-right:10px; margin-right:13px; padding-top:12px; padding-left:8px; padding-bottom:12px; text-decoration:none;">
       <span style="background:url('<%=siteUrl %>images/icons.png'); float:left; background-position:-299px -6px; margin-right:7px; width:16px; height:18px;"></span>Home
        </a>
        

        

        
        
        </div>

        </div>
 
        
        
 
      </div>