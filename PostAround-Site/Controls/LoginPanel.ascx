<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LoginPanel.ascx.cs" Inherits="Controls_LoginPanel" %>



<%--<script type="text/javascript">
        window.fbAsyncInit = function () {
            FB.init({ appId: '<%= FaceBookAppKey %>',
                status: true,
                cookie: true,
                xfbml: true,
                oauth: true
            });
        };

    // Load the SDK Asynchronously
//    (function () {
//        var e = document.createElement('script'); e.async = true;
//        e.src = 'scripts/all.js';
//        document.getElementById('fb-root').appendChild(e);
//    } ());

        
</script>--%>

<div id="fb-root"></div>
<asp:LinkButton OnClientClick="return false;" id="btnFacebook" CssClass="btnFacebook HeaderButton" style="color:inherit; cursor:pointer;  text-decoration:none; float:right" runat="server"  onclick="btnFacebook_Click"><span style="font-size:inherit">Login</span></asp:LinkButton>

      
      
        <div class="UserBox HeaderButton" id="divLogedIn"  style="float:right; position:relative; cursor:pointer; margin-top:-6px;  display:none" runat="server"> 
            <div class="Text" id="UserArea">
                
                <div class="Image" id="UserImage" runat="server" ></div>
                <div class="Name" id="UserName" runat="server" style="margin-top:-3px" ></div>
                
 
                
            </div>

           <div id="MoreBox" class="MoreBox" style="margin-top:33px; ">
      
            <ul>
            <li id="btnMyPosts" style="cursor:pointer;">My Posts</li>
            <li id="btnSettings" style="display:none; cursor:pointer;">Settings</li>
            <li id="logoutLink" ><asp:LinkButton runat="server" id="lnkbLogOut" onclick="lnkbLogOut_Click" CssClass="LogoutLink">Logout</asp:LinkButton></li>
            </ul>
            
            
      </div>

        </div>





 <asp:Literal runat="server" ID="ltrlClientResponse"></asp:Literal>
 <asp:Literal runat="server" ID="ltrlClearSavedLocation"></asp:Literal>


 