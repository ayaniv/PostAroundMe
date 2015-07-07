<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddNewPostWindow.ascx.cs" Inherits="Controls_AddNewPostWindow" %>

<%@ Register src="FileUpload.ascx" tagname="FileUpload" tagprefix="uc1" %>

    <div id="PopupBox" class="PopupBox" style="position:relative; ">


       <div style="float:left;">

      
                
                <input type="text" id="txtAddMessageMsgId" value="" style="display:none;" />

                <input type="text" id="txtAddMessageLat" value="" readonly="readonly" style="display:none;" />
                <input type="text" id="txtAddMessageLon" value=""  readonly="readonly" style="display:none;" />
                <input type="text" id="txtAddMessageAddress" value=""  readonly="readonly" style="display:none;" />

                <input type="checkbox" id="chkPostToWall" style="display:none;" />


    <div class="AddPostField">


        <textarea maxlength="400" id="txtPopupDetails" style="width: 299px; height: 70px; padding-right: 20px; margin-top: 0; float: left; " data-i18n="[placeholder]header.placeholder;[title]post.details;"></textarea>

        <div id="xbutton" style="width: 14px; height: 16px; clear: both; float: right; top: 0; right: 0; padding: 5px; padding-top: 4px; position: absolute; cursor: pointer;">
            <div class="SmallXButton" style="display: block; margin-right:5px;">
            </div>
        </div>
    </div>

                                
                    <div class="AddPostField"><input maxlength="50" type="text" name="txtTitle" id="txtPopupTitle" style="font-family:Arial; font-size:14px; color:#3c3c3c; width:315px; border:solid 1px #c8c8c8; height:19px; padding:4px; padding-top:6px"  data-i18n="[placeholder]post.add-title;[title]post.title;" /></div>
                


                
                    <div id="addPostBtnCategory" data-i18n="[title]post.category" class="AddPostField">
                    
                        <div id="ddlCategory"  style="-moz-user-select: none;-webkit-user-select: none; width:315px; height:19px; border:1px solid #c8c8c8; padding:4px; padding-top:6px; float:left; color:#a3a3a3; font-size:14px; background-color:#FFF; cursor:pointer;" >
                    

                   <ul>


                        <li style="float:left; margin:-3px; color:#3c3c3c" id="addPostBtnCategoryText">
                        
                        <span style="margin-left:6px; padding-top:3px; float:left;" data-i18n="post.choose-category"></span>
                        
                        </li>
                    </ul>

                        
                        
                        
                        
                        
                    
                
                <div class="MoreIcon" style="float:right"></div>



                    
                    </div></div>
                


              <div id="CategoriesBoxAddMessage" class="DropDown" style="display:none; margin:0; margin-top:154px; border-color:#C8C8C8; border-top:0; width:321px;">
                

                <asp:Repeater runat="server" ID="rptCategoriesColumn1">

                <HeaderTemplate>
                    <ul style="width:100%">
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


       
       
    </div>





                


               <div  class="AddPostField" style="width:325px">
                    <div id="file-uploader-demo1">		
	                </div>
                    <uc1:FileUpload ID="FileUpload1" runat="server" />
                </div>
                
      

 
                


 



     <div style="clear:both; overflow:hidden;">

     <div id="CurrLocation" style="display:none;">
         <div class="FreeText" id="divAddressApprove" style="display:none; color: #82898e; margin-top:10px;
             font-size: 14px;">
             <span data-i18n="post.please-click"></span>&nbsp;<b data-i18n="post.allow"></b>&nbsp;<span data-i18n="post.above-to"></span>&nbsp;<b data-i18n="post.share-location"></b>
             </div>
         <div id="divAddressContainer" style="margin-bottom:6px; " >
             <div class="SmallLocationIcon" style="margin-top:4px"></div>
             <div style="float:left; font-size:16px; font-family:Calibri, Arial; font-style:italic; color:#57849D;">Post around:</div>
             <div  id="divAddress" style="clear:both; padding-left: 15px; width:310px; color: #82898e;
                 font-size: 15px;">
                 </div>
                 <div id="divAddressChange" style="width:44px; margin-left:14px; font-size:11px; color:#6fa6b8; text-decoration:underline; cursor:pointer;">(change)</div>
         </div>
         <div id="TopMessageAddPost" style="width:300px; display:none;">
         <div class="FreeText" id="divBrowserDontSupport" style="color: #82898e; margin-top:10px;
             font-size: 14px;"></div>

           <div id="LocationLinksAddPost" style="float:right;">
           <div style="float:left; margin-left:10px; color:#6AA1BB; font-family:Georgia, Calibri, Arial; font-size:14px; ">|</div>
           <div class="LocationLink" style="float:left; margin-left:10px; color:#6AA1BB; font-family:Georgia, Calibri, Arial; font-size:14px; "  id="btnChangeLocationAddPost">Change</div>
           </div>
           <div id="TryAgainWrapperAddPost" style="float:right; display:none;">
           <div style="float:left; margin-left:10px; color:#6AA1BB; font-family:Georgia, Calibri, Arial; font-size:14px; ">|</div>
           <div id="TryAgainAddPost" class="LocationLink" style="float:left; margin-left:10px; color:#6AA1BB; font-family:Georgia, Calibri, Arial; font-size:14px; ">Try Again</div>
           </div>
         </div>

      </div>

         <div class="FreeText" id="divManualAddress" style="margin-right:0px; display:none;">
         <div style="font-size: 20px; color: #57849d; font-family: Calibri, Arial;
         font-style: italic;" data-i18n="post.location-title"></div>
             <div style="float: left;" id="addMessageAddressDiv">


                          <div id="AddMessageAutoDiscover" data-i18n="[title]header.show-my-location" class="AutoDiscover">
                

                             <a href="#">
             
                              <div style="background: url('<%=siteUrl%>images/icons.png') no-repeat scroll -281px -4px; height: 20px;
                     width: 20px; margin-left: 6px; margin-top: 6px;">
                 </div>

             </a>



             </div>



                 <input type="text" id="addMessageAddressInput" class="AddressTextBox" style="width: 219px;
                     height: 18px; border: 1px solid #c0c0c0; font-weight: normal; font-size: 14px;
                     color: #3c3c3c; float:left; padding:4px; padding-top:6px;" data-i18n="[placeholder]post.street-address-state;[title]post.location" />
                     
                     
                     
                     </div>

             <div class="Search" id="addMessageAddressSearchButton">
                

                             <a href="#">
             
                              <div style="height: 17px; width: auto; margin-left: auto; margin-top: -2px; font-size:16px !important; font-weight:bold;" data-i18n="post.go"></div>

             </a>



             </div>
             <div style="clear:both; float:left; font-size:11px; font-style:italic; padding:6px;" data-i18n="post.example">
             </div>
         </div>
     </div>
     <div style="margin-top:10px; display:none; ">
     

         <div id="ChkFacebook" class="Checkbox" >
             <div id="chkFacebookTrue" style="display:none; background: url('<%=siteUrl%>images/icons.png') no-repeat scroll -270px -7px;
                 width: 10px; height: 9px; margin-top: 3px; margin-left: 3px; position: absolute;">
             </div>
         </div>
         <div style="float: left; font-size: 12px; color: #3C3C3C; margin-left: 6px;">
             Post to Facebook</div>


     </div>
                        
                        






</div>
            
            

            <div style="clear:both" >


                <div style="margin-top:12px; float:right;">

                <div id="MandatoryFieldsMessage" style="display:none; float:left; width:246px; color:#FF0000; font-size:13px; ">
                
                <span data-i18n="post.please-fill"></span>
                <div id="MandatoryFields" style="font-weight:bold"></div>
                
                </div>


                    <div id="PostButton" class="Submit" style="float:right" data-i18n="post.post"></div>
                </div>
            </div>
            
        
            </div>
    
    

 
  
  