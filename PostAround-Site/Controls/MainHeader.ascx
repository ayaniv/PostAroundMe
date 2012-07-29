<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MainHeader.ascx.cs" Inherits="Controls_MainHeader" %>

<%@ Register src="LoginPanel.ascx" tagname="FacebookLogin" tagprefix="uc1" %>

    <div id="HeaderLogo">
    <div style="z-index:2; background:url('images/cloud.png') no-repeat; width:446px; height:154px; position:absolute;">
    
    <div class="LogoClear"><a href="<%=homePage %>?ref=logo"><img border="0" src="images/logo_neto.png" title="Location Based Pinboard" width="258" height="50" /></a></div>
    <div class="LogoText">Location Based Pinboard</div>
    
    </div>
        
    

    <div style="bottom:0; z-index:1; position:absolute; height:351px; background:url('images/headerImage.png') no-repeat; width: 404px;">

    </div>
    </div>
        
    <div id="HeaderTopLinks"  style="text-transform:uppercase; margin-top:1px; font-size:12px; font-family:Trebuchet MS, Arial, Sans-Serif; color:#82898E; position:absolute; z-index:2; margin-right:40px; right:0;">
    <uc1:FacebookLogin ID="Facebook" runat="server" />
    
    <div class="HeaderButton" id="divAbout" style="float:right; padding:12px; padding-right:30px; padding-left:30px">
    
    <div id="AboutArea">
        <div style="float:left; cursor:default;  text-decoration:none; font-size:inherit;">
            About
        </div>
    </div>
      <div id="AboutBox" class="MoreBox" style="width:98px">
            <ul>
                <li id="liBlog" style="height:16px; border-top:1px dotted #c0c0c0; border-bottom:1px dotted #c0c0c0; margin-top:5px; padding-top:5px; padding-bottom:5px; padding-left:20px;"><a href="http://blog.postaround.me" target="_blank" class="LogoutLink" style="padding:0">Blog</a></li>
                <li id="liContact" style="height:26px; position:relative; border-bottom:1px dotted #c0c0c0;"><a href="mailto:info@posaround.me"  class="LogoutLink" style="padding-left:20px;">Contact</a></li>
            </ul>
            
            
      </div>
        
    
    </div>
    


    <div id="headerBtnAddPost" class="HeaderButton" style="float:right; cursor:pointer; padding:12px; padding-right:30px; padding-left:30px">
                add post
    </div>
    
    <div class="HeaderButton" style="float:right; cursor:pointer;  padding:12px; padding-left:30px; padding-right:30px;">
    <a href="<%=homePage %>?ref=home" style="text-decoration:none; color:#82898E; font-size:inherit;">Home</a>
        
    </div>
    



    
    </div>