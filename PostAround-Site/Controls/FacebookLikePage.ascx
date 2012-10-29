<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FacebookLikePage.ascx.cs" Inherits="Controls_FacebookLikePage" %>


<style type="text/css">
 .fb_edge_comment_widget { margin-left:-250px; }
 .fbSendButtonFormContainer .nub { margin-left:250px; }
</style>


<script type="text/javascript">
    (function (d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=<%= FaceBookAppKey %>";
        fjs.parentNode.insertBefore(js, fjs);
    } (document, 'script', 'facebook-jssdk'));
</script>


    <fb:like href="http://www.facebook.com/postaround" send="false" layout="button_count" show_faces="false"></fb:like>