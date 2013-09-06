<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SearchLocation.ascx.cs" Inherits="Controls_SearchLocation" %>

        
      <div id="SearchLocation" class="PostBox">

      
      <div class="Field">
      <div class="AutoDiscoverButton" id="AutoDiscover"></div>
      <div id="autoDiscoverText" style="position:absolute; display:none; height:14px; background:#f78c1d url('<%=siteUrl%>images/btnBg.png') repeat-x; z-index:5; padding:2px; margin-left:39px; border:1px solid #FFF; margin-top:1px; font-size:12px; font-family:Calibri, Arial; color:#FFF ">Show My Location</div>
      
      <div class="uiStickyPlaceholderInput uiStickyPlaceholderEmptyInput" style="float:left;">
                                <input type="text" maxlength="245" id="content" class="BlackText inputWithPlaceHolder"/>
                                <div class="placeholderField">Type your address to find out... (Address, City, State or ZIP Code)</div>
      </div>

          
      <div class="Search" title="Get Posts Around"  id="SearchBtn"></div>
      </div>
      
     


            
        
        </div>