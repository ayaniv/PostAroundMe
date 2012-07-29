<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SiteLocationBar.ascx.cs" Inherits="Controls_SiteLocationBar" %>


       <%@ Register src="SocialLinks.ascx" tagname="SocialLinks" tagprefix="uc1" %>

<div id="TopMessage" style="display:none; float:left;">

<div id="SocialLinksWrapper" style="position:absolute; top:20px; float:right !important; right:0; margin-right:47px; ">
    <uc1:SocialLinks ID="SocialLinks1" runat="server" />
</div>

<div id="moreButtons" style="float:left; margin-left:39px;">

<div style="float:left;">

<div style="float:left; padding:10px; padding-top:12px; height:100%; width:27px;">
 <img src="images/baloon.png" style="width:27px; height:31px;" />
</div>



<div style="float:left; padding:10px; padding-left:0; width:700px;" >

           
           
           
           <div style="float:left; color:#333; font-size:18px; font-weight:bold; font-family:Trebuchet MS, Arial, Sans-Serif; text-transform:uppercase;">showing posts around</div>
           <div style="clear:both">
           <div style="float:left; color:#333; font-family:Georgia, Calibri, Arial; display:block; font-size:14px; cursor:pointer" title="Show/Hide location on map"  id="moreButtonsText"></div>
           <div id="LocationLinks" style="float:left;">
           <div style="float:left; margin-left:10px; color:#6AA1BB; font-family:Georgia, Calibri, Arial; font-size:14px; ">|</div>
           <div class="LocationLink" style="float:left; margin-left:10px; color:#6AA1BB; font-family:Georgia, Calibri, Arial; font-size:14px; "  id="btnChangeLocation">Change</div>
           </div>
           <div id="TryAgainWrapper" style="float:left; display:none;">
           <div style="float:left; margin-left:10px; color:#6AA1BB; font-family:Georgia, Calibri, Arial; font-size:14px; ">|</div>
           <div id="TryAgain" class="LocationLink" style="float:left; margin-left:10px; color:#6AA1BB; font-family:Georgia, Calibri, Arial; font-size:14px; ">Try Again</div>
           </div>

           </div>
           
           
</div>
</div>

            
            
        </div>



</div>