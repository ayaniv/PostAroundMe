<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SiteLocationBar.ascx.cs" Inherits="Controls_SiteLocationBar" %>




<div id="TopMessage" style="display:none; ">

<div id="SliderBar" class="Slider">
                <div style="width:246px;">
                    
                    <label for="amount" style="float:left">Up to Distance:</label>
	                <input readonly="readonly" value="ALL" type="text" id="amount" style="float:right; background:transparent; border:0; color:#666; font-weight:bold; font-size:16px; font-style:italic; width:50px; font-family:Calibri,Arial; text-align:right; padding:0px; margin:0px;  " />
	            </div>
	            <div style="width:244px; float:left; margin-top:2px;">
                    <div id="slider"></div>
                </div>
            </div>

<div id="moreButtons" style="float:left; margin-left:39px;">

<div style="float:left;">

<div style="float:left; padding:10px; padding-top:12px; height:100%; width:27px;">
 <img src="images/baloon.png" style="width:27px; height:31px;" />
</div>



<div style="float:left; padding:10px; padding-left:0; width:auto;" >

           
           
           
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