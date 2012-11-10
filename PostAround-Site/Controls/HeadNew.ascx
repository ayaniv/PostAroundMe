﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HeadNew.ascx.cs" Inherits="Controls_Head" %>
     
     <%@ Register src="GAC.ascx" tagname="GAC" tagprefix="uc1" %>

     <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <!-- scripts -->

        <script type="text/javascript">

            if (window.location.hash == '#_=_') window.location.hash = '';

            var siteUrl = '<%=siteUrl %>';
            var currentUser;
            var rootDir = '<%=rootDir %>';
            
            var myLat = '<%=lat %>';
            var myLon = '<%=lng %>';
            var address = unescape("<%=address %>");
            var dontShowMeAgainWelcome = "<%=dontShowMeAgainWelcome %>";
            var isMobile = <%=isMobile.ToString().ToLower() %>;
            var isDirectLink = <%=isDirectLink.ToString().ToLower() %>;
            
            
    </script>

                     <script src="<%=siteUrl %>scripts/compress/prototype.js?v07" type="text/javascript"></script>
     
    <script type="text/javascript" src="http://www.google.com/jsapi?key=<%=ConfigurationManager.AppSettings["GoogleKey"] %>"></script>
    <%--<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=<%=ConfigurationManager.AppSettings["GoogleKeyV3"] %>&sensor=false"></script>--%>
    <script src="<%=siteUrl %>scripts/compress/jquery.js" type="text/javascript"></script>
    <script src="<%=siteUrl %>scripts/compress/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
    <script src="<%=siteUrl %>scripts/compress/modernizr.custom.43477.js" type="text/javascript"></script>
    <%--<link href="//fonts.googleapis.com/css?family=Open+Sans:300,400,600,700&amp;subset=latin" rel="stylesheet">--%>
    
    
    <script src="<%=siteUrl %>scripts/compress/jquery.tmpl.min.js" type="text/javascript"></script>
    <script src="<%=siteUrl %>scripts/compress/date.format.js" type="text/javascript"></script>
    <script type='text/javascript' src='<%=siteUrl %>scripts/compress/jquery.autogrow-textarea.js'></script>
    
    <%--<script type="text/javascript" src="<%=siteUrl %>scripts/jquery.smooth-scroll.min.js"></script>--%>
    <script src="<%=siteUrl %>scripts/scriptsNew.js" type="text/javascript"></script>
    
 <!-- GAC -->
    <uc1:GAC ID="GAC1" runat="server" />

        <!-- css -->
    <link rel="stylesheet" href="<%=siteUrl %>/css/screenNew.css" type="text/css" media="screen" charset="utf-8" />
    <link rel="stylesheet" href="<%=siteUrl %>/css/jquery-ui-1.8.21.custom.css" type="text/css" media="screen" charset="utf-8"></link>
    <link rel="shortcut icon" href="<%=siteUrl %>images/favicon.png" />

