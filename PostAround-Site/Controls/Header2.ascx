<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Header2.ascx.cs" Inherits="Controls_Header2" %>



<%@ Register src="SiteLocationBar.ascx" tagname="LocationBar" tagprefix="uc1" %>

<%@ Register src="GeoHead.ascx" tagname="GeoHead" tagprefix="uc1" %>
<%@ Register src="MainHeader.ascx" tagname="MainHeader" tagprefix="uc1" %>


<%@ Register src="TopBanner.ascx" tagname="TopBanner" tagprefix="uc1" %>
<%@ Register src="AddPostButton.ascx" tagname="AddPost" tagprefix="uc1" %>

<%@ Register src="SocialLinks.ascx" tagname="SocialLinks" tagprefix="uc1" %>

        
        


        





<div style="height:2px; background-color:#FFF; width:100%"></div>
<div id="heading" class="header"> <%--header--%>
       <uc1:MainHeader ID="MainHeader1" runat="server" /> 
    <div class="MainHead" style="z-index:1;">

    
    
 
    
    <div id="HeaderText" style="height:404px; width:514px; float:left; margin-left:430px;">






    

    
    <h1>What’s good <span>in the hood !</span></h1>
    <p>
    PostAround is fun and easy way to share with your neighbors. <br />
    Know a good restarurant around? Need a ladder to borrow? Looking for a babysitter? Anything you want to share with your neighborhood? <br />
    Just post it around and find out what's good in your hood !


    
    </p>

            <div class="PostBox" style="margin-left:16px;">
        
            <div id="Links" class="TopLinks" style="color:#f57814; font-family:Calibri, Arial; font-size:24px;">
            Start here by typing your address:
            <span style="margin-left:5px; margin-right:5px; display:none;">|</span>
            <span style="display:none">Show messages on map</span>
                    
            </div>
            <div class="Field">
                <div class="AutoDiscoverButton" id="AutoDiscover"></div>
                <div id="autoDiscoverText" style="display:none; position:absolute; background-color:Blue; width:383px; height:38px; margin:6px; margin-left:50px; background:url('images/btnBg.png') repeat-x; z-index:5; padding:1px; padding-left:45px; font-size:24px; font-style:italic; font-family:Calibri, Arial; color:#FFF "><b>On Wifi?</b> Click to Auto-Discover</div>
                <input type="text" maxlength="245" id="content" class="BlackText" placeholder="Street Address, City, State" />
                <div class="Search" title="Get Posts Around"  id="SearchBtn"></div>
            </div>
            <div class="TopLinks" style="margin-left:27px; font-weight:normal; float:left; font-size:11px; font-style:italic"><div style="margin-top:3px; margin-right:2px; float:left; background:url('images/icons.png') repeat scroll -281px -148px transparent; width:8px; height:6px;"></div><b>on WiFi?</b> just click it</div>
            <div class="TopLinks" style="font-size:11px; font-weight:normal; margin-right:10px; float:right">Popular location: <b>Taipei, Taiwan</b></div>
            
            <div id="AutoDiscoverBubble1" style="display:none; position:absolute;  margin-top:75px; margin-left:0px; background:url('images/bubble6.png') no-repeat; width:244px; height:45px;">
            <div style=" padding-top:7px; font-family:Calibri,Arial; padding-left:20px; font-style:italic; font-size:18px; color:#3a3a3a;">
            
            </div>
            </div>


            
        </div>

    </div>
    
    
        


        



    </div>

    


            
        <uc1:GeoHead ID="GeoHead1" runat="server" />
        <div style="width:100%; text-align:center"><img src="images/headerShadow.png" style="height:15px; width:765px"></div>
        </div> <%--end header--%>
        <uc1:SocialLinks ID="SocialLinks1" runat="server" />
        <uc1:LocationBar ID="LocationBar" runat="server" />



        
