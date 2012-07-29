<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TopBanner.ascx.cs" Inherits="Controls_TopBanner" %>

<%@ Register src="FacebookLoginButton.ascx" tagname="FacebookLoginButton" tagprefix="uc1" %>


    <div id="BannerTop" visible="false" runat="server" style="border:1px solid #C0BCB1; width:505px; height:70px; background:url('images/topBannerBg.gif');">
        <div style="padding:10px; text-align:center; font-size:16px; padding-top:6px; font-weight:bold; color:#3A3A3A; font-family:Calibri, Arial; ">
            PostAround.me connects you to people around you !
            <div style="padding:3px;"></div>
            
            <uc1:FacebookLoginButton ID="FacebookLoginButton1" runat="server" />
        </div>
    
    </div>