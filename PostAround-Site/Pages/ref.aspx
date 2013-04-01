<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ref.aspx.cs" Inherits="Pages_ref" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        var secretCode = '<%=secretCode %>';
        var siteUrl = '<%=siteUrl %>';
        var siteUrlSecured = '<%=siteUrlSecured %>';
    </script>
    <script src="<%=siteUrlSecured %>scripts/compress/jquery.js" type="text/javascript"></script>
</head>
<body>
    <div id="fb-root"></div>
<script type="text/javascript">


   
    window.fbAsyncInit = function () {
        FB.init({
            appId: '<%=FaceBookAppKey %>', // App ID
            channelUrl: '//<%= siteUrlSecured%>/channel.aspx', // Channel File
            status: true, // check login status
            cookie: true, // enable cookies to allow the server to access the session
            xfbml: true  // parse XFBML
        });

          // Additional initialization code here

        var userID;
          FB.getLoginStatus(function (response) {
              if (response.status === 'connected') {

                  FB.api('/me', function (response) {

                      userID = GetUserIdByFacebookID(response.id);
                     
                  });


                 
              } else if (response.status === 'not_authorized') {
                  //alert("not_authorized");
              } else {
                  //alert("not connected");
              }
          });
      };

    // Load the SDK's source Asynchronously
    (function (d) {
        var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
        if (d.getElementById(id)) { return; }
        js = d.createElement('script'); js.id = id; js.async = true;
        js.src = "//connect.facebook.net/en_US/all.js";
        ref.parentNode.insertBefore(js, ref);
    }(document));

    function GetUserIdByFacebookID(facebookid) {


        var url = siteUrlSecured + "/Handlers/SaveInCookie.ashx";

        var myJSON = {
            "facebookID": facebookid,
            "secretCode": secretCode
        };



        $.ajax({
            type: 'POST',
            url: url,
            data: myJSON,
            sync: false,
            dataType: "json",
            success: function (data) { Redirect(); }


        })
    }



    function getParameterByName(name) {
        name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
        var regexS = "[\\?&]" + name + "=([^&#]*)";
        var regex = new RegExp(regexS);
        var results = regex.exec(window.location.search);
        if (results == null)
            return "";
        else
            return decodeURIComponent(results[1].replace(/\+/g, " "));
    }

    function Redirect() {
        var postId;
        if (getParameterByName("postId") != "") {
            postId = getParameterByName("postId");
            window.top.location.href = siteUrl + "/post/" + postId;
        } else {
            window.top.location.href = siteUrl; 
        }
    }



</script>

    <form id="form1" runat="server">
    <div>

        Redirects to <a href="http://postaround.me" target="_top">PostAround.Me | Local Pinboard</a>...
    <script type="text/javascript">

 
 









    </script>
    </div>
    </form>
</body>
</html>
