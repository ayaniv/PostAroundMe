<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddPostContainer2.ascx.cs" Inherits="Controls_AddPostContainer2" %>


<%@ Register src="AddNewPostWindow.ascx" tagname="NewPost" tagprefix="uc1" %>
<%@ Register src="LoginMessage.ascx" tagname="LoginMessage" tagprefix="uc1" %>

<div class="AddMessage" id="AddMessageWindow" style="/*display:none*/margin-top:39px; top:0; z-index:1001; position:fixed; margin-left:40px; ">


                <div class="LoginMessage" runat="server" id="Container" style="width:<%=width %>">
                    
                    <uc1:NewPost ID="NewPost1" runat="server" Visible="false" /> 
                    <uc1:LoginMessage ID="LoginMessage" runat="server" Visible="false" /> 
                    
                </div>
        
        </div>
