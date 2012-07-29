<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LoginMessage.ascx.cs" Inherits="Controls_LoginMessgae" %>
<%@ Register src="FacebookLoginButton.ascx" tagname="FacebookLoginButton" tagprefix="uc1" %>

  <div id="PopupBox" class="PopupBox" style="padding:6px; position:relative; width:339px;">

       <div style="float:left; width:100%">

      
            <div style="float:left; font-size:20px; margin-bottom:10px; color:#000; font-family:Georgia ,Calibri, Arial; font-style:italic">
                Please Log In
            </div>

     <div id="xbuttonLoginMsg" style="width:14px; height:16px; clear:both; float: right; top:0; right:0; padding: 10px; position:absolute; cursor: pointer;">
         <div style="margin-right:1px; background: url('images/icons.png') repeat scroll -140px -143px; float: right;
             height: 14px; width: 11px;">
         </div>
     </div>

     <div style="margin:20px; margin-right:30px; margin-top:40px;">
         <div style="text-align:center; background-color:#EAEDEE; padding:20px;">
             
             <div>
             <uc1:FacebookLoginButton ID="FacebookLoginButton1" runat="server" />
             </div>
             

         </div>
     </div>



 
      </div>  
        
            </div>
    