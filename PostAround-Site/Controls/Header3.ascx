<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Header3.ascx.cs" Inherits="Controls_Header3" %>



<%@ Register src="SiteLocationBar.ascx" tagname="LocationBar" tagprefix="uc1" %>
<%@ Register src="SearchLocation.ascx" tagname="SearchLocation" tagprefix="uc1" %>
<%@ Register src="CategoriesBar.ascx" tagname="CategoriesBar" tagprefix="uc1" %>





<%@ Register src="AddPostButton.ascx" tagname="AddPost" tagprefix="uc1" %>



<%@ Register src="LoginPanel.ascx" tagname="FacebookLogin" tagprefix="uc1" %>
<%@ Register src="AboutButton.ascx" tagname="AboutButton" tagprefix="uc1" %>
<%@ Register src="CategoriesButton.ascx" tagname="CategoriesButton" tagprefix="uc1" %>
<%@ Register src="SortButton.ascx" tagname="SortButton" tagprefix="uc1" %>

 
        


        


<div id="TopHeader">

      <div id="MainHeader" class="FixedHeader" style="border-bottom:1px solid #e2ddcf; /*min-width:910px;*/ height:80px; background:#FCFCFC url('<%=siteUrl%>images/bgtop2.png'); width:100%;">
        <div style="margin:0 auto; padding:0">

        <div id="LogoHeader" style="width:270px; height:90px; background:url('<%=siteUrl%>images/bgtop2.png') repeat-x; position:absolute; left:50%; margin-left:-135px;">
        
        <div style="width:270px; text-align:center; height:90px; background:url('<%=siteUrl%>images/logoBg3.png') repeat-x; float:left;">
        
            <div class="LogoClear"><a href="<%=siteUrl %>"><img src="<%=siteUrl%>images/logoHead.png" title="PostAround.Me • Local Pinboard"  style="width:246px; height:43px; border:0" /></a></div>
            <div class="LogoText" data-i18n="header.logo-text"></div>
        
        
        </div>
        
        </div>

        <div id="RightWing">
        
        <ul class="HeaderList" style="float:right">

            <li style="cursor:default;" id="divLanguage">
        
        
        <!-- Language Start -->
            <span class="HeaderMenu" data-i18n="header.language">
            </span>
    
        
        
        <span class="HeaderMenuArrow"></span>
        
        <div id="LanguageBox" class="MoreBox" style="width:84px;">
            <ul>
                <li><a href="<%=siteUrl %>?lang=en" class="LogoutLink" style="padding:0;">English</a></li>
                <li><a href="<%=siteUrl %>?lang=he"  class="LogoutLink">עברית</a></li>
            </ul>
            
            
      </div>
    
    
    <!--Language End-->
        
        </li>

        <li style="cursor:default;" id="divAbout">
        
        
        <!-- About Start -->
            <span class="HeaderMenu" data-i18n="header.about">
            </span>
    
        
        
        <span class="HeaderMenuArrow"></span>
        
        <div id="AboutBox" class="MoreBox" style="width:84px;">
            <ul>
                <li id="liBlog"><a href="http://blog.postaround.me" target="_blank" class="LogoutLink" style="padding:0;"  data-i18n="header.blog"></a></li>
                <li id="liContact"><a href="mailto:yaniv@postaround.me"  class="LogoutLink" data-i18n="header.contact"></a></li>
            </ul>
            
            
      </div>
    
    
    <!--About End-->
        
        </li>
        <li id="divLogin" style="margin-right:20px"><uc1:FacebookLogin ID="Facebook" runat="server" /></li>
        </ul>


        <%@ Register src="SocialLinks.ascx" tagname="SocialLinks" tagprefix="uc1" %>
<div id="SocialLinksWrapper" style="float:right !important; right:0; margin-right:30px; clear:both; padding-top:10px;">
    <uc1:SocialLinks ID="SocialLinks1" runat="server" />
</div>
        
        
        </div>
        <div id="LeftWing">
        <ul class="HeaderList">
        <li style="width:90px;" id="liAddPost"><span class="AddPostIcon"></span><span data-i18n="header.add-post"></span>
        <%--<div style="background:url('images/icons.png');  background-position:-100px -156px; margin-left:7px; z-index:1; position:absolute; margin-top:8px; width:10px; clear:both; height:6px;" ></div>--%>
        </li>
        <li id="liCategory">
        
        <uc1:CategoriesButton ID="CategoriesButton1" runat="server" />
        <span class="HeaderMenuArrow"></span>
        
        </li>
        
        <li id="liSort">
        <!-- Sort Start -->
        <div id="btnSort" class="ChooseCategory HeaderMenu"  data-i18n="header.newest-on-top">
                    
                
        </div>

        <span class="HeaderMenuArrow"></span>
        

        





        <div id="SortBox" class="MoreBox" style="width:114px">
                
                

                

                
                    <ul>
                

                
                    <li onselectstart='return false;'  style="width:104px; cursor:pointer;">
                        <span data-i18n="header.newest-on-top"></span>
                        <input style="display:none" value="0">
                    </li>

                    <li onselectstart='return false;' style="width:104px; cursor:pointer;">
                        <span data-i18n="header.nearest-first"></span>
                        <input style="display:none" value="1">
                    </li>
                
                         <li onselectstart='return false;' style="width:104px; cursor:pointer;">
                         <span data-i18n="header.most-shared"></span>
                        
                        <input style="display:none" value="2">
                    </li>


                
                    </ul>
                


                
       
       
    </div>
        <!-- Sort End -->
        </li>
        </ul>

        <div style="float:left; margin-top:3px; margin-left:8px; color:#666; font-size:12px;">
        
        <textarea maxlength="400" id="txtPopupDetails1" data-i18n="[placeholder]header.placeholder;[title]post.details"></textarea>
        </div>
        
        </div>

        </div>
 
        
        <div id="topShpitz" style="z-index:100; position:absolute; background:url('<%=siteUrl%>images/toptrianagle.png'); width:13px; height:8px; margin-top:31px; margin-left:65px;"></div>
 
      </div>

      <div id="MapSpacing" style="position:relative; height:80px; background:#fcfbf9 url('<%=siteUrl%>images/ibg.jpg');"></div>

      <div id="MapPas" style="height:190px; width:100%; background:url('<%=siteUrl%>images/map_pas.png'); position:relative">
      <div id="MapPasShade" style="position:absolute; z-index:1; width:100%; height:18px; top:0;"></div>
      <div id="MapPasText" style="background:url('<%=siteUrl%>images/bgWhite80.png'); height:90px; width:862px; position:relative; margin:0 auto; top:27px; padding:25px 30px;">
      <div class="bannerTitle"> 
      <h1>
          <span class="font1" data-i18n="header.whats-good"></span>
          <span class="font2" data-i18n="header.in-the-hood"></span></h1>
      </div>
      <div class="bannerLine"></div>
      <div class="bannerText" data-i18n="header.description">
      </div>
      
      </div>
      <div id="MapRealCover" style="display:none; background-color:Black; height:190px; width:100%;"></div>
      <div id="MapReal" style="display:none; height:100%; width:100%;"></div>
      </div>
      
      <div id="MapPasBottom" style="width:100%; /*min-width:910px;*/ position:relative;  z-index:10; float:left; background-color:#fcfcfc; border-bottom:1px solid #e1dfdc; border-top:1px solid #e1dfdc;">
      <uc1:LocationBar ID="LocationBar" runat="server" />
      <uc1:SearchLocation ID="SearchLocation1" runat="server" />

      
      </div>
      
    <div id="CategoriesWrapper">
      <div id="CategoriesBar" style="display:none">
      <div style="float:left; width:100%; height:1px; background:url('<%=siteUrl%>images/cats_top.png');"></div>
      <div style="float:left; width:100%; padding-bottom:6px; background:url('<%=siteUrl%>images/cats_bg.png'); ">
<!-- Categories -->

<uc1:CategoriesBar ID="CategoriesBar1" runat="server" />

      </div>
      </div>
        </div>
      <div style="float:left; width:100%; height:2px; background:url('<%=siteUrl%>images/cats_bottom.png'); margin-bottom:11px;"></div>
      
    </div>
    


            
        
        
        



        
