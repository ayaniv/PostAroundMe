<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Header3.ascx.cs" Inherits="Controls_Header3" %>



<%@ Register src="SiteLocationBar.ascx" tagname="LocationBar" tagprefix="uc1" %>
<%@ Register src="SearchLocation.ascx" tagname="SearchLocation" tagprefix="uc1" %>
<%@ Register src="CategoriesBar.ascx" tagname="CategoriesBar" tagprefix="uc1" %>





<%@ Register src="AddPostButton.ascx" tagname="AddPost" tagprefix="uc1" %>



<%@ Register src="LoginPanel.ascx" tagname="FacebookLogin" tagprefix="uc1" %>
<%@ Register src="AboutButton.ascx" tagname="AboutButton" tagprefix="uc1" %>
<%@ Register src="CategoriesButton.ascx" tagname="CategoriesButton" tagprefix="uc1" %>
<%@ Register src="SortButton.ascx" tagname="SortButton" tagprefix="uc1" %>

 
        


        




      <div id="MainHeader" class="FixedHeader" style="border-bottom:1px solid #e2ddcf; min-width:910px; height:80px; background:#FCFCFC url('<%=homePage%>images/bgtop2.png'); width:100%;">
        <div style="margin:0 auto; padding:0">

        <div id="LogoHeader" style="width:270px; height:90px; background:url('<%=homePage%>images/bgtop2.png') repeat-x; position:absolute; left:50%; margin-left:-135px;">
        
        <div style="width:270px; text-align:center; height:90px; background:url('<%=homePage%>images/logoBg3.png') repeat-x; float:left;">
        
            <div class="LogoClear"><a href="<%=homePage %>"><img src="<%=homePage%>images/logoHead.png" title="PostAround.Me | Local Pinboard"  style="width:246px; height:43px; border:0" /></a></div>
            <div class="LogoText">Local Pinboard</div>
        
        
        </div>
        
        </div>

        <div id="RightWing" style="float:right; height:80px; width:400px; margin-right:17px;">
        
        <ul class="HeaderList" style="float:right">
        <li style="cursor:default;" id="divAbout">
        
        
        <!-- About Start -->
            <span style="float:left;">
                About
            </span>
    
        
        
        <span style="background:url('<%=homePage%>images/icons.png'); float:right; background-position:-100px -152px; margin-left:7px; width:7px; margin-top:5px; height:4px;"></span>
        
        <div id="AboutBox" class="MoreBox" style="width:84px;">
            <ul>
                <li id="liBlog"><a href="http://blog.postaround.me" target="_blank" class="LogoutLink" style="padding:0;">Blog</a></li>
                <li id="liContact"><a href="mailto:info@postaround.me"  class="LogoutLink">Contact</a></li>
            </ul>
            
            
      </div>
    
    
    <!--About End-->
        
        </li>
        <li id="divLogin" style="margin-right:20px"><uc1:FacebookLogin ID="Facebook" runat="server" /></li>
        </ul>


        <%@ Register src="SocialLinks.ascx" tagname="SocialLinks" tagprefix="uc1" %>
<div id="SocialLinksWrapper" style="float:right !important; right:0; margin-right:30px; clear:both; margin-top:10px; ">
    <uc1:SocialLinks ID="SocialLinks1" runat="server" />
</div>
        
        
        </div>
        <div id="LeftWing" style="float:left; height:80px; width:400px; margin-left:39px; ">
        <ul class="HeaderList">
        <li style="width:90px;" id="liAddPost"><span style="background:url('<%=homePage%>images/icons.png'); float:left; background-position:-184px -143px; margin-right:7px; width:24px; height:18px;"></span>Add Post
        <%--<div style="background:url('images/icons.png');  background-position:-100px -156px; margin-left:7px; z-index:1; position:absolute; margin-top:8px; width:10px; clear:both; height:6px;" ></div>--%>
        </li>
        <li id="liCategory">
        
        <uc1:CategoriesButton ID="CategoriesButton1" runat="server" />
        <span style="background:url('<%=homePage%>images/icons.png'); float:right; background-position:-100px -152px; margin-left:7px; width:7px; margin-top:5px; height:4px;"></span>
        
        </li>
        
        <li id="liSort">
        <!-- Sort Start -->
        <div id="btnSort" class="ChooseCategory" >
                    
                        Newest on top
                    
                
        </div>

        <span style="background:url('<%=homePage%>images/icons.png'); float:right; background-position:-100px -152px; margin-left:7px; margin-top:5px; width:7px; height:4px;"></span>
        

        





        <div id="SortBox" class="MoreBox" style="width:114px">
                
                

                

                
                    <ul>
                

                
                    <li onselectstart='return false;'  style="width:104px; cursor:pointer;">
                        Newest on top
                        <input style="display:none" value="0">
                    </li>

                    <li onselectstart='return false;' style="width:104px; cursor:pointer;">
                        Nearest First
                        <input style="display:none" value="1">
                    </li>
                


                
                    </ul>
                


                
       
       
    </div>
        <!-- Sort End -->
        </li>
        </ul>

        <div style="float:left; margin-top:3px; margin-left:8px; color:#666; font-size:12px;">
        
        <textarea maxlength="400" id="txtPopupDetails1" style="margin-top:3px; width:315px; height:18px; color:#3c3c3c; border:solid 1px #b8b8b8; resize:none; overflow:auto; padding:4px; font-size:14px; font-family:Tahoma, Arial" title="Details"  placeholder="Add your post here !"></textarea>
        </div>
        
        </div>

        </div>
 
        
        <div id="topShpitz" style="z-index:100; position:absolute; background:url('<%=homePage%>images/toptrianagle.png'); width:13px; height:8px; margin-top:31px; margin-left:65px;"></div>
 
      </div>

      <div id="MapSpacing" style="position:relative; height:80px; background:#fcfbf9 url('<%=homePage%>images/ibg.jpg');"></div>

      <div id="MapPas" style="height:190px; width:100%; background:url('<%=homePage%>images/map_pas.png'); position:relative">
      <div id="MapPasShade" style="position:absolute; z-index:1; width:100%; height:18px; top:0; background:url('<%=homePage%>images/dropdown_shadow.png')"></div>
      <div id="MapPasText" style="background:url('<%=homePage%>images/bgWhite80.png'); height:90px; width:862px; position:relative; margin:0 auto; top:27px; padding:25px 30px;">
      <div style="float:left"> 
      <h1>What’s good <span>in the hood !</span></h1>
      </div>
      <div style="float:left; margin-left:40px; margin-right:30px; width:1px; height:100%; background-color:#505050;"></div>
      <div style="float:left; text-transform:uppercase; color:#505050; font-family: Trebuchet MS, Arial; text-align:center; width:420px; font-size:18px; padding:20px 15px 0 15px;">
      Read <span style="font-family:Helvetica">&</span> Share Posts in your own neighborhood on a pinboard based on your location
      <span  style="display:none; text-transform:lowercase;  font-size:11px; color:#6AA1BB">more <span style="font-size:14px">»</span></span>
      </div>
      
      </div>
      <div id="MapRealCover" style="display:none; background-color:Black; height:190px; width:100%;"></div>
      <div id="MapReal" style="display:none; height:190px; width:100%;"></div>
      </div>
      
      <div id="MapPasBottom" style="width:100%; min-width:910px; position:relative;  z-index:10; float:left; background-color:#fcfcfc; border-bottom:1px solid #e1dfdc; border-top:1px solid #e1dfdc;">
      <uc1:LocationBar ID="LocationBar" runat="server" />
      <uc1:SearchLocation ID="SearchLocation1" runat="server" />

      
      </div>
      
      <div id="CategoriesBar">
      <div style="float:left; width:100%; height:1px; background:url('images/cats_top.png');"></div>
      <div style="float:left; width:100%; padding-bottom:6px; background:url('images/cats_bg.png'); ">
<!-- Categories -->

<uc1:CategoriesBar ID="CategoriesBar1" runat="server" />

      </div>
      </div>
      <div style="float:left; width:100%; height:2px; background:url('images/cats_bottom.png'); margin-bottom:11px;"></div>
      

    


            
        
        
        



        
