<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LoginMessage.ascx.cs" Inherits="Controls_LoginMessgae" %>
<%@ Register src="FacebookLoginButton.ascx" tagname="FacebookLoginButton" tagprefix="uc1" %>

  <div id="PopupBox" class="PopupBox" style="padding:6px; position:relative; width:323px;">

       <div style="float:left; width:100%; border:1px solid #C8C8C8;">

      




                   <div id="xbuttonLoginMsg"class="SmallXButtonWrapper" style="padding:10px">
            <div class="SmallXButton" style="display: block;">
            </div>
        </div>



     <div style="background-color:#EAEDEE;">
         <div style="text-align:center; padding:20px;">
             
             <span style="font-weight:bold; font-family:Trebuchet MS, Arial, Sans-Serif; font-size:20px">Join Now - It's Free!</span>
             <div style="color:#5f676c; margin-left:20px; margin-top:10px; width:250px; font-family:Trebuchet MS, Arial, Sans-Serif; text-align:left;">
             <ul>
             <li>Sign up NOW. And get a free access to add posts, reply to others' posts, get notifications on replies and get updated with the opportunities in your vicinity.</li>
             <li style="padding-top:16px;">We just ask for your basic details.</li>
             <li>We don't store your password.</li>
             <li>We will never post ANYTHING on your behalf, unless you ask for it.</li>
             
             </ul>
             
             
             
             </div>

         </div>
         
         <div style="background-color:#5c74a9;">
         <div style="width:16px; margin:auto; height:8px; background:url('images/icons.png') -132px -76px"></div>

          <div style="text-align:center; padding:12px 20px 20px 20px;">
             <uc1:FacebookLoginButton ID="FacebookLoginButton1" runat="server" />
             </div>

         </div>
     </div>



 
      </div>  
        
            </div>
    