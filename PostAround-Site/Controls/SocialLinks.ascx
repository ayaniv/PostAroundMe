<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SocialLinks.ascx.cs" Inherits="Controls_SocialLinks" %>

<%@ Register src="FacebookLikePage.ascx" tagname="FacebookLike" tagprefix="uc1" %>
<%@ Register src="GooglePlus.ascx" tagname="GooglePlus" tagprefix="uc1" %>

     


           <div id="Gplus" style="float:right; width:60px;  height:20px;">
                <uc1:GooglePlus ID="GooglePlus" runat="server" /> 
            </div>


                       <div style="float:right; width:100px; height:20px;">
                <uc1:FacebookLike ID="FacebookLike" runat="server" />
            </div>
           
     
