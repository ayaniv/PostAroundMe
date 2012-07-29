<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LoginPanel.ascx.cs" Inherits="Controls_LoginPanel" %>



<script type="text/javascript">

    $(function () {


        var isLoggedIn = false;
        function SetCurrentUser(data) {

            currentUser = data;
            if (currentUser.Status == 0) {
                currentUser = null
                alert(currentUser.Message);
            }
            else {

                SetUserInPage(currentUser.FirstName + " " + currentUser.LastName, currentUser.Image);

            }

        }






        function SetUserInPage(username, userimage) {
            $('#UserImage').html('<img src=' + userimage + ' style="width:24px; height:24px"/>');
            $('#UserName').text(username);
        }


        $('#logoutLink').click(function () {
            FB.logout();
            currentUser = null;
        });


        window.fbAsyncInit = function () {
            FB.init({ appId: '<%= FaceBookAppKey %>',
                status: true,
                cookie: true,
                xfbml: true,
                oauth: true
            });

            function InsertUpdateFacebookUser(uid, token) {

                var url = siteUrl + "/Handlers/InsertUpdateFacebookUser.ashx";

                var myJSON = {
                    "uid": uid,
                    "token": token
                };



                $.ajax({
                    type: 'POST',
                    url: url,
                    data: myJSON,
                    sync: false,
                    dataType: "json",
                    success: function (data) { SetCurrentUser(data); ShowUserDetails(); }
                });

            }

            function Login(response) {

                var uid = response.authResponse.userID;
                var accessToken = response.authResponse.accessToken;
                InsertUpdateFacebookUser(uid, accessToken);


            }

            function ShowUserDetails() {

                $('#fb-auth').hide();
                $('#divLogedIn').show();
            }

            function ShowLoginButton() {
                $('#fb-auth').show();
                $('#divLogedIn').hide();

            }

            function DeleteUserCookie() {

                var url = siteUrl + "/Handlers/Logout.ashx";


                $.ajax({
                    type: 'POST',
                    url: url,
                    sync: false

                });

            }





            function updateButton(response) {

                var button = document.getElementById('fb-auth');
                var divLogedIn = document.getElementById('divLogedIn');

                if (response.authResponse) {
                    if (!isLoggedIn) {
                        isLoggedIn = true;
                        Login(response);
                    }


                } else {
                    // the user is logged in to Facebook, 
                    //but not connected to the app

                    DeleteUserCookie();
                    ShowLoginButton();

                    button.onclick = function () {


                        FB.login(function (response) {
                            if (response.authResponse) {

                                Login(response);

                            } else {
                                //user cancelled login or did not grant authorization


                            }
                        }, { scope: 'user_birthday, email' });
                    }
                }
            }

            // run once with current status and whenever the status changes
            FB.getLoginStatus(updateButton);
            FB.Event.subscribe('auth.statusChange', updateButton);
        };

        (function () {
            var e = document.createElement('script'); e.async = true;
            e.src = 'scripts/all.js';
            document.getElementById('fb-root').appendChild(e);
        } ());


    });
        
</script>

<div id="fb-root"></div>
<div  class="FacebookLoginButton" id="fb-auth"><span class="FacebookLoginButtonText">Login</span></div>

      
      
        <div class="UserBox" id="divLogedIn" style="display:none"> <!-- none -->
            <div class="Text">
                <div class="Name" id="UserName"></div>
            </div>

            <div class="Text">
                <div class="Image" id="UserImage"></div>

                <div id="UserSettings" style="width:50px; padding:2px; cursor:pointer; z-index:10; margin-left:30px; margin-top:4px;  -moz-user-select: none; -webkit-user-select: none;">
                    <span class="Account">More</span>
                    <div class="Icon" style="z-index:10;"></div>
                </div>
            </div>

      <div id="MoreBox" class="MoreBox">
            <ul>
            <li id="btnMyPosts" style="border-top:1px dotted #c0c0c0; border-bottom:1px dotted #c0c0c0; margin-top:5px; padding-top:5px; padding-bottom:5px; font-weight:bold; padding-left:5px;color:#82898E; cursor:pointer">My Posts</li>
            <li id="btnSettings" style="padding-top:1px; padding-bottom:1px; font-weight:bold; padding-left:2px; color:#82898E; cursor:pointer; display:none;">Settings</li>
            <li id="logoutLink" style="border-bottom:1px dotted #c0c0c0; padding-top:5px; padding-bottom:5px; font-weight:bold; padding-left:5px; color:#82898E; cursor:pointer">Logout</li>
            </ul>
            
            
      </div>

        </div>




 



