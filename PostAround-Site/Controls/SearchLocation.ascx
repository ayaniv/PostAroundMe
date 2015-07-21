<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SearchLocation.ascx.cs" Inherits="Controls_SearchLocation" %>

        
      <div id="SearchLocation" class="PostBox">

      
      <div class="Field">
      <div class="AutoDiscoverButton" id="AutoDiscover"></div>
      <div id="autoDiscoverText"  data-i18n="header.show-my-location"></div>
      
      <div class="uiStickyPlaceholderInput uiStickyPlaceholderEmptyInput autoDiscoverInput">
                                <input type="text" maxlength="245" id="content" placeholder="" class="BlackText inputWithPlaceHolder"/>
                                <div class="placeholderField" data-i18n="header.type-address"></div>
      </div>

          
      <div class="Search" title="Get Posts Around" data-i18n="[title]header.get_posts_around;" id="SearchBtn">
          <span class="SearchbBtnText" data-i18n="header.go"></span>
          <span class="goArrow"></span>
      </div>
      </div>
      
     


            
        
        </div>