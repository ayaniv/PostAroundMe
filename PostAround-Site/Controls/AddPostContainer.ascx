<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddPostContainer.ascx.cs" Inherits="Controls_AddPostContainer" %>
<%@ Register src="AddNewPostWindow.ascx" tagname="NewPost" tagprefix="uc1" %>
<%@ Register src="LoginMessage.ascx" tagname="LoginMessage" tagprefix="uc1" %>

<div class="AddMessage" id="AddMessageWindow" style="display:none; margin-top:-2px; position:absolute; z-index:300; margin-left:60px; height:318px; width:867px;">

        <div style="position:absolute; margin-top:-2px; background:url('images/addMessage_corners.png') 0px -70px; width:15px; height:7px; margin-left:40px;">
        </div>

            <div>
                <div style="float:left; width:14px; height:12px;background:url('images/addMessage_corners.png') 0px 0px;"></div>
                <div style="float:left; width:833px; height:12px; background:url('images/addMessage_bg1.png')"></div>
                <div style="float:left; width:20px; height:12px;background:url('images/addMessage_corners.png') 0px -57px"></div>
            </div>

            <div>
                <div style="float:left; width:14px; height:280px; background:url('images/addMessage_bg_left.png')"></div>
                
                <div style="float:left; width:833px; height:280px; background:#FFF url('images/addMessage_bg.png');">
                    
                    <uc1:NewPost ID="NewPost1" runat="server" Visible="false" /> 
                    <uc1:LoginMessage ID="LoginMessage" runat="server" Visible="false" /> 
                    
                </div>

                <div style="float:left; width:20px; height:280px; background:url('images/addMessage_bg_right.png')"></div>
            </div>

            <div>
                <div style="float:left; width:14px; height:21px; background:url('images/addMessage_corners.png') 0px -13px;"></div>
                <div style="float:left; width:833px; height:21px; background:url('images/addMessage_bg3.png')"></div>
                <div style="float:left; width:20px; height:21px;background:url('images/addMessage_corners.png') 0px -35px;"></div>
            </div>


            
        
        </div>
