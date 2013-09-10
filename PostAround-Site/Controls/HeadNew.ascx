<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HeadNew.ascx.cs" Inherits="Controls_Head" %>
     
     <%@ Register src="GAC.ascx" tagname="GAC" tagprefix="uc1" %>
<%--<meta name="viewport" content="width=device-width,initial-scale=0.5,maximum-scale=1" />--%>
     <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <!-- scripts -->

        <script type="text/javascript">

            if (window.location.hash == '#_=_') window.location.hash = '';

            var siteUrl = '<%=HttpUtility.JavaScriptStringEncode(siteUrl) %>';
            var siteUrlSecured = '<%=HttpUtility.JavaScriptStringEncode(siteUrlSecured) %>';
            var currentUser;
            var rootDir = '<%=HttpUtility.JavaScriptStringEncode(rootDir) %>';
            var queryStringAddress = '<%= HttpUtility.JavaScriptStringEncode(addressFromQueryString) %>';
            var queryStringLat = '<%= HttpUtility.JavaScriptStringEncode(latitudeFromQueryString) %>';
            var queryStringLon = '<%= HttpUtility.JavaScriptStringEncode(longitudeFromQueryString) %>';

            var myLat = '<%=HttpUtility.JavaScriptStringEncode(myLat) %>';
            var myLon = '<%=HttpUtility.JavaScriptStringEncode(myLon) %>';
            //var location = unescape("<%=location %>");
            var address = unescape("<%=HttpUtility.JavaScriptStringEncode(address) %>");
            var dontShowMeAgainWelcome = "<%=HttpUtility.JavaScriptStringEncode(dontShowMeAgainWelcome) %>";
            var isMobile = <%=isMobile.ToString().ToLower() %>;
            var isDirectLink = <%=isDirectLink.ToString().ToLower() %>;
            var accessToken = '<%=HttpUtility.JavaScriptStringEncode(accessToken) %>';
            var sendFacebookNotifications = '<%=HttpUtility.JavaScriptStringEncode(sendFacebookNotifications) %>';
            
            
    </script>

                     <script src="<%=siteUrl %>scripts/compress/prototype.js?v07" type="text/javascript"></script>
     
    <script type="text/javascript" src="http://www.google.com/jsapi?key=<%=ConfigurationManager.AppSettings["GoogleKey"] %>"></script>
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=<%=ConfigurationManager.AppSettings["GoogleKeyV3"] %>&sensor=false&libraries=places"></script>


    <script src="<%=siteUrl %>scripts/compress/jquery.js" type="text/javascript"></script>
    
    <script src="<%=siteUrl %>/scripts/compress/jquery-ui.min.js" type="text/javascript"></script>

    <script src="<%=siteUrl %>scripts/compress/modernizr.custom.43477.js" type="text/javascript"></script>
    
    
    
    <script src="<%=siteUrl %>scripts/compress/jquery.tmpl.min.js" type="text/javascript"></script>
    <script src="<%=siteUrl %>scripts/compress/date.format.js" type="text/javascript"></script>
    <script type='text/javascript' src='<%=siteUrl %>scripts/compress/jquery.autogrow-textarea.js'></script>
     
    
    <script src="<%=siteUrl %>scripts/compress/scriptsNew.js" type="text/javascript"></script>
    

 

<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-4fdef26e46826d05"></script>

 <!-- GAC -->
    <uc1:GAC ID="GAC1" runat="server" />

        <!-- css -->
    <link rel="stylesheet" href="<%=siteUrl %>css/screenNew.css" type="text/css" media="screen" charset="utf-8" />
    
    <link rel="stylesheet" href="<%=siteUrl %>css/jquery-ui.css" type="text/css" media="screen" charset="utf-8" />
    <%--<link rel="stylesheet" href="<%=siteUrl %>/css/jquery-ui-1.8.21.custom.css" type="text/css" media="screen" charset="utf-8"></link>--%>
    <link rel="shortcut icon" href="<%=siteUrl %>images/favicon.png" />

    

<!-- Flip Card -->

 

<!-- Flip Card End -->