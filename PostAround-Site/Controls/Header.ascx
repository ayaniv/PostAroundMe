<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Header.ascx.cs" Inherits="Controls_Header" %>
<%@ Register src="LoginPanel.ascx" tagname="Facebook" tagprefix="uc1" %>

<%@ Register src="FacebookLike.ascx" tagname="FacebookLike" tagprefix="uc1" %>
<%@ Register src="GooglePlus.ascx" tagname="GooglePlus" tagprefix="uc1" %>
<%@ Register src="AddNewPostWindow.ascx" tagname="NewPost" tagprefix="uc1" %>


<div id="heading" class="header"> <%--header--%>
        
    <div class="MainHead">
        <div class="LogoClear"><a href="<%=homePage %>"><img border="0" src="images/logo_neto.png" title="Location Based Bulletin Board" width="258" height="50" /></a></div>
        <div  class="LogoText">what's good in the hood</div>
    
        <div class="Wrapper" style="display:none">
        <div id="WelcomeBubble" class="Bubble">
            <div id="bubbleText" class="BubbleText">
                <span style="float: left;"><b>Tip: </b>Start here by typing your address</span>
            </div>
        </div>

       <div id="AutoDiscoverBubble" class="Bubble" style="margin-left:217px">
            <div class="BubbleText">
                <span style="float: left;">On <b>WiFi?</b> click here for auto discover</span>
            </div>
        </div>
        </div>


        <div class="PostBox">
        
            <div id="Links" class="TopLinks">
            Enter your address and see what's good in your hood !          
            <span style="margin-left:5px; margin-right:5px; display:none;">|</span>
            <span style="display:none">Show messages on map</span>
                    
            </div>
            <div class="Field">
                <div class="AutoDiscoverButton" title="Auto Discover My Location" id="AutoDiscover"> </div>
                <input type="text" maxlength="245" id="content" class="BlackText" placeholder="Street Address, City, State" />
                <div class="Search" title="Get Posts Around"  id="SearchBtn"></div>
            </div>


            
        </div>




       <uc1:Facebook ID="Facebook" runat="server" />

   

        
       <div id="moreButtons" class="TopMessage">
           
           <div style="float:left; height:20px; overflow:hidden; max-width:740px;" id="moreButtonsText"><strong>Postaround.me is a  location based bulletin board.</strong> Read and Share posts around your location.</div>
           
           
           <div style="width:160px; float:right;">
           <div style="float:left; width:100px; height:20px;">
                <uc1:FacebookLike ID="FacebookLike" runat="server" />
            </div>

           <div style="float:right; width:60px;  height:20px;">
                <uc1:GooglePlus ID="GooglePlus" runat="server" /> 
            </div>
           
            </div>
            
            
        </div>


        <div class="GeoHead">
                        <div class="TopButton" id="FireButton">
                
                <div style="float:left; margin-top:8px; background:url('images/icons.png') -184px -142px; width:24px; height:18px; margin-left:10px;"></div>
                <div style="float:left; font-size:14px; color:#FFF; font-weight:bold; margin-left:5px; margin-top:9px;">Add new post</div>
                
            </div>
             
            <div id="btnCategory" class="ChooseCategory" onselectstart='return false;' >
                
                    <ul>


                        <li style="float:left; margin:0px; font-weight:bold;" id="btnCategoryText">
                        
                        <span style="background-color:#e3e3e3;" class="Color"></span>

                        <span class="Option">All Categories</span>
                        
                        </li>
                    </ul>
                
                <div class="MoreIcon"></div>
            </div>

                <div id="CategoriesBox" class="DropDown">
                <div style="height:1px; background-color:#ccdae1; width:184px; margin-left:201px;"></div>
                

                <asp:Repeater runat="server" ID="rptCategoriesColumn1">

                <HeaderTemplate>
                    <ul>
                </HeaderTemplate>

                <ItemTemplate>
                    <li onselectstart='return false;'>
                    <asp:TextBox runat="server" ID="txtDropDownCategoryId" type="text" style="display:none"></asp:TextBox>
                    <asp:Label runat="server" id="ltrlDropDownColor" CssClass="Color"></asp:Label>
                    <asp:Label runat="server" ID="ltrlDropDownOption" CssClass="Option" ></asp:Label>
                    </li>
                </ItemTemplate>


                <FooterTemplate>
                    </ul>
                </FooterTemplate>


                </asp:Repeater>

               <asp:Repeater runat="server" ID="rptCategoriesColumn2">

                <HeaderTemplate>
                    <ul>
                </HeaderTemplate>

                <ItemTemplate>
                    <li onselectstart='return false;'>
                    <asp:TextBox runat="server" ID="txtDropDownCategoryId" type="text" style="display:none"></asp:TextBox>
                    <asp:Label runat="server" ID="ltrlDropDownColor" CssClass="Color"></asp:Label>
                    <asp:Label runat="server" ID="ltrlDropDownOption" CssClass="Option" ></asp:Label>
                    </li>
                </ItemTemplate>


                <FooterTemplate>
                    </ul>
                </FooterTemplate>


                </asp:Repeater>
       
       
    </div>


            
            
 

           <div id="btnSort" class="ChooseCategory" style="width:124px">
                
                    <ul>
                        <li style="float:left; margin:0px; font-weight:bold;" id="btnSortText">Sort By Newest</li>
                    </ul>
                
                <div class="MoreIcon"></div>
            </div>




              <div id="SortBox" class="DropDown SortDropDown">
                
                

                

                
                    <ul>
                

                
                    <li onselectstart='return false;'>
                        Sort By Newest
                        <input style="display:none" value="0">
                    </li>

                    <li onselectstart='return false;'>
                        Sort By Distance
                        <input style="display:none" value="1">
                    </li>
                


                
                    </ul>
                


                
       
       
    </div>




 
            <div id="SliderBar" class="Slider">
                <div style="width:246px;">
                    
                    <label for="amount" style="float:left">Up to Distance:</label>
	                <input readonly="readonly" value="ALL" type="text" id="amount" style="float:right; background:transparent; border:0; color:#6AA1BB; font-weight:bold; font-size:16px; font-style:italic; width:50px; font-family:Calibri,Arial; text-align:right; padding:0px; margin:0px;  " />
	            </div>
	            <div style="width:244px; float:left; margin-top:2px;">
                    <div id="slider"></div>
                </div>
            </div>
             
            

        </div>


    
     <div id="Map" class="PopupBox" style="width:516px; background-color:#FFF; height:440px; opacity:1; filter:alpha(opacity=100); z-index:200; margin-left:320px;  margin-top:55px; box-shadow: 1px 1px 10px #000; -moz-box-shadow: 1px 1px 10px #000; -webkit-box-shadow: 1px 1px 10px #000; display:none " >
        <div style="width:100%; height:40px; background-image:url('images/addMessageBgTop.gif'); background-repeat:repeat-x; ">
            <div style="padding:9px; font-size:20px; font-weight:500; color:#57849d;">
                <div class="PopupTitle">&nbsp;</div>
                <div style="float:right; cursor:pointer;" class="xbuttonPopUp">x</div>
                
            </div>
       </div>
                   <div style="width:100%; height:1px; background-color:#c9dfec;"></div>
            <div style="padding-top:9px; padding-bottom:9px;">

        <div id="map_canvas" style="width:515px; height:266px;"></div> 
        
        </div>
        <div style="width:100%; height:1px; background-color:#c9dfec;"></div>
        <div id="MapAddress" style="padding:9px; color:#57849d; font-size:13px; font-weight:bold;">

        
        
        </div>
    </div>

    </div>

        </div> <%--end header--%>

        <div class="AddMessage" id="AddMessageWindow" style="display:none; margin-top:-2px; position:absolute; z-index:300; margin-left:60px; height:318px; width:867px;">

        <div style="position:absolute; margin-top:-2px; background:url('images/addMessage_corners.png') 0px -70px; width:15px; height:7px; margin-left:40px;"></div>

            <div>
                <div style="float:left; width:14px; height:12px;background:url('images/addMessage_corners.png') 0px 0px;"></div>
                <div style="float:left; width:833px; height:12px; background:url('images/addMessage_bg1.png')"></div>
                <div style="float:left; width:20px; height:12px;background:url('images/addMessage_corners.png') 0px -57px"></div>
            </div>

            <div>
                <div style="float:left; width:14px; height:280px; background:url('images/addMessage_bg_left.png')"></div>
                
                <div style="float:left; width:833px; height:280px; background:#FFF url('images/addMessage_bg.png');">
                    <uc1:NewPost ID="NewPost1" runat="server" /> 
                </div>

                <div style="float:left; width:20px; height:280px; background:url('images/addMessage_bg_right.png')"></div>
            </div>

            <div>
                <div style="float:left; width:14px; height:21px; background:url('images/addMessage_corners.png') 0px -13px;"></div>
                <div style="float:left; width:833px; height:21px; background:url('images/addMessage_bg3.png')"></div>
                <div style="float:left; width:20px; height:21px;background:url('images/addMessage_corners.png') 0px -35px;"></div>
            </div>


            
        
        </div>
