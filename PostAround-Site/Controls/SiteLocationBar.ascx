<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SiteLocationBar.ascx.cs" Inherits="Controls_SiteLocationBar" %>




<div id="TopMessage" style="display:none; ">

<div id="SliderBar" class="Slider">
                <div style="width:246px;">
                    
                    <label for="amount" style="float:left">Up to Distance:</label>
	                <input readonly="readonly" value="ALL" type="text" id="amount" style="float:right; background:transparent; border:0; color:#666; font-weight:bold; font-size:16px; font-style:italic; width:50px; font-family:Calibri,Arial; text-align:right; padding:0px; margin:0px;  " />
	            </div>
	            <div style="width:244px; float:left; margin-top:4px;">
                    <div id="slider"></div>
                </div>
            </div>

<div id="moreButtons" style="float:left; margin-left:39px;">

<div style="float:left;">

<div style="float:left; padding:10px; padding-top:12px; height:100%; width:27px;">
 <img src="<%=siteUrl %>images/baloon.png" style="width:27px; height:31px;" />
</div>



<div style="float:left; padding:5px 10px 10px 0; width:auto;" >

           
           
           

           <div style="clear:both">
           <div class="LocationText" title="Show/Hide location on map"  id="moreButtonsText"></div>
           </div>
           <div style="float:left; color:#333; font-size:12px; font-weight:bold; font-family:Trebuchet MS, Arial, Sans-Serif; text-transform:uppercase;" data-i18n="header.showing-posts"></div>
           <div id="LocationLinks" style="float:left;">
           <div style="float:left; margin-left:10px; color:#6AA1BB; font-family:Trebuchet MS, Arial, Sans-Serif; font-size:14px; ">|</div>
           <div class="LocationLink" style="float:left; margin-left:10px; color:#6AA1BB; font-family:Trebuchet MS, Arial, Sans-Serif; font-size:14px; "  id="btnShowMap"  data-i18n="header.show-map"></div>
           <div style="float:left; margin-left:10px; color:#6AA1BB; font-family:Trebuchet MS, Arial, Sans-Serif; font-size:14px; ">|</div>
           <div class="LocationLink" style="float:left; margin-left:10px; color:#6AA1BB; font-family:Trebuchet MS, Arial, Sans-Serif; font-size:14px; "  id="btnChangeLocation" data-i18n="header.change"></div>

           </div>
           <div id="TryAgainWrapper" style="float:left; display:none;">
           <div style="float:left; margin-left:10px; color:#6AA1BB; font-family:Georgia, Calibri, Arial; font-size:14px; ">|</div>
           <div id="TryAgain" class="LocationLink" style="float:left; margin-left:10px; color:#6AA1BB; font-family:Georgia, Calibri, Arial; font-size:14px; "  data-i18n="header.try-again"></div>
           </div>

           
           
           
</div>
</div>

            
            
        </div>



</div>