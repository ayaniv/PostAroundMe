<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LoginMessage.ascx.cs" Inherits="Controls_LoginMessgae" %>
<%@ Register src="FacebookLoginButton.ascx" tagname="FacebookLoginButton" tagprefix="uc1" %>

  <div id="PopupBox" class="PopupBox" style="padding:6px; position:relative; width:323px;">

       <div style="float:left; width:100%; border:1px solid #C8C8C8;">

      


     <div id="xbuttonLoginMsg" style="width:14px; height:16px; clear:both; float: right; top:0; right:0; padding: 10px; position:absolute; cursor: pointer;">
         <div style="margin-right:1px; background: url('images/icons.png') repeat scroll -140px -143px; float: right;
             height: 14px; width: 11px;">
         </div>
     </div>

     <div style="background-color:#EAEDEE;">
         <div style="text-align:center; padding:20px;">
             
              <div>
             <uc1:FacebookLoginButton ID="FacebookLoginButton1" runat="server" />
             </div>
             <div style="margin-top:10px; color:#424E55; font-family:Trebuchet MS, Arial, Sans-Serif; text-align:left;">
             We just ask for your basic details:
             <ul style="text-align:left; font-size:12px; margin-left:16px;">
             <li style="list-style-type:square">Name, Profile picture, Gender, User ID</li>
             <li  style="list-style-type:square">Your email address</li>
             <li  style="list-style-type:square">Your birthday</li>
             </ul>
             We will never post ANYTHING on your behalf, unless you ask for it.
             Sign Up NOW it's fun and easy :)
             </div>

         </div>
     </div>



 
      </div>  
        
            </div>
    