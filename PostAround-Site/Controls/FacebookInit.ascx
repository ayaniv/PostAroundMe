<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FacebookInit.ascx.cs" Inherits="Controls_FacebookInit" %>


<div id="fb-root"></div>
<script type="text/javascript">
    window.fbAsyncInit = function () {
        FB.init({
            appId: '<%=FaceBookAppKey %>', // App ID
            channelUrl: '//<%= siteUrl%>/channel.aspx', // Channel File
            status: true, // check login status
            cookie: true, // enable cookies to allow the server to access the session
            xfbml: true  // parse XFBML
        });

        // Additional initialization code here
    };

    // Load the SDK Asynchronously
    (function (d) {
        var js, id = 'facebook-jssdk'; if (d.getElementById(id)) { return; }
        js = d.createElement('script'); js.id = id; js.async = true;
        js.src = "//connect.facebook.net/en_US/all.js";
        d.getElementsByTagName('head')[0].appendChild(js);
    } (document));
</script>