<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LoginPanel.ascx.cs" Inherits="Controls_LoginPanel" %>



<script type="text/javascript">

    $(function () {



    });    
        
</script>

<div id="fb-root"></div>
<asp:LinkButton CssClass="FacebookLoginButton" id="btnFacebook" runat="server" 
    onclick="btnFacebook_Click"><span class="FacebookLoginButtonText">Login</span></asp:LinkButton>

      
      
        <div class="UserBox" id="divLogedIn" style="display:none" runat="server"> 
            <div class="Text">
                <div class="Name" id="UserName" runat="server"></div>
            </div>

            <div class="Text">
                <div class="Image" id="UserImage" runat="server"></div>

                <div id="UserSettings" style="width:50px; padding:2px; cursor:pointer; z-index:10; margin-left:30px; margin-top:4px;  -moz-user-select: none; -webkit-user-select: none;">
                    <span class="Account">More</span>
                    <div class="Icon" style="z-index:10;"></div>
                </div>
            </div>

      <div id="MoreBox" class="MoreBox">
            <ul>
            <li id="btnMyPosts" style="height:16px; border-top:1px dotted #c0c0c0; border-bottom:1px dotted #c0c0c0; margin-top:5px; padding-top:5px; padding-bottom:5px; font-weight:bold; padding-left:5px;color:#82898E; cursor:pointer">My Posts</li>
            <li id="btnSettings" style="padding-top:1px; padding-bottom:1px; font-weight:bold; padding-left:2px; color:#82898E; cursor:pointer; display:none;">Settings</li>
            <li id="logoutLink" style="height:26px; position:relative; border-bottom:1px dotted #c0c0c0; "><asp:LinkButton runat="server" id="lnkbLogOut" onclick="lnkbLogOut_Click" CssClass="LogoutLink">Logout</asp:LinkButton></li>
            </ul>
            
            
      </div>

        </div>




 <asp:Literal runat="server" ID="ltrlClientResponse"></asp:Literal>



