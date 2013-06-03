<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Loader.ascx.cs" Inherits="Controls_Loader" %>
        
        
        <div id="loadingDiv" style="z-index:500; width:80px; height:80px; position:fixed; margin:auto; top:50%; margin-left:-40px; left:50%; display:block; background:url('images/loadingBg.png')" >
        
            <img src="<%=siteUrl %>images/loading.gif" style="width:64px; height:64px; left:8px; top:8px; position:absolute;" />
        
        </div>