<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShowMap.ascx.cs" Inherits="Controls_ShowMap" %>

<div id="Map" class="PopupBox" style="width:516px; background-color:#FFF; height:440px; opacity:1; filter:alpha(opacity=100); z-index:200; margin-left:320px;  box-shadow: 1px 1px 10px #000; -moz-box-shadow: 1px 1px 10px #000; -webkit-box-shadow: 1px 1px 10px #000; display:none " >
        <div style="width:100%; height:40px; background-image:url('images/addMessageBgTop.gif'); background-repeat:repeat-x; ">
            <div style="padding:9px; font-size:20px; font-weight:500; color:#57849d;">
                <div class="PopupTitle">&nbsp;</div>

    <div id="xbuttonPopUp" style="width:14px; height:11px; float: right; padding: 10px; padding-top: 4px; cursor: pointer;">
         <div style="background: url('images/icons.png') repeat scroll -140px -143px; float: right;
             height: 14px; width: 11px;">
         </div>
     </div>


    
                
            </div>
       </div>
                   <div style="width:100%; height:1px; background-color:#c9dfec;"></div>
            <div style="padding-top:9px; padding-bottom:9px;">

        <div id="map_canvas" style="width:515px; height:266px;"></div> 
        
        </div>
        <div style="width:100%; height:1px; background-color:#c9dfec;"></div>
        <div id="MapAddress" style="padding:9px; color:#333; font-size:13px; font-weight:bold;">
        
        </div>
        <div style="clear:both; padding:9px; padding-top:0px; color:#57849d; font-size:13px; text-decoration:underline; cursor:pointer;" id="SetThisAsMyAddress">
        See more posts around this location
        </div>
        <div style="clear:both; padding:9px; padding-top:0px; color:#57849d; font-size:13px; text-decoration:underline; cursor:pointer;" id="ViewOnMapSite">
        Open location with Google Maps
        </div>
        
    </div>