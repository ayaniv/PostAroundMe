<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddPostContainer2.ascx.cs" Inherits="Controls_AddPostContainer2" %>


<%@ Register src="AddNewPostWindow.ascx" tagname="NewPost" tagprefix="uc1" %>
<%@ Register src="LoginMessage.ascx" tagname="LoginMessage" tagprefix="uc1" %>

<div class="AddMessage" id="AddMessageWindow" style="display:none; margin-top:39px; top:0; z-index:1001; position:fixed; margin-left:40px; ">


                <div style="box-shadow: 0px 6px 6px #666; -moz-box-shadow: 0px 6px 6px #666; -webkit-box-shadow: 0px 6px 6px #666; border:1px solid #FFF; border-top:0; float:left; padding-bottom:5px;  background:#fcfcfc;">
                    
                    <uc1:NewPost ID="NewPost1" runat="server" Visible="false" /> 
                    <uc1:LoginMessage ID="LoginMessage" runat="server" Visible="false" /> 
                    
                </div>
        
        </div>
