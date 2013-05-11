<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PopUp.ascx.cs" Inherits="Controls_PopUp" %>

<div id="zoomScroll" style="background-color:rgba(255, 255, 255, 0.93); position:fixed; filter:alpha(opacity=20); margin:0; padding:0; z-index:9999; top:0; right:0; bottom:0; left:0; overflow-x: auto; overflow-y: scroll; display:none;">
<div id="ClosePopUp" style="float:right; padding:20px;"><img src="<%=homePage %>images/close.png" /></div>
<img id="PopUpLoadingDiv" src="images/loading.gif" style="display:none; width:64px; height:64px; margin-left:-32px; left:50%; top:30%; z-index:9999; position:absolute;" />
<div id="PopUp" class="PopupBox" style="position:absolute; width:640px; margin-top:20px;  min-height:500px; background-color:#FFF; z-index:200; left:50%; margin-left:-320px; box-shadow: 1px 1px 10px #000; -moz-box-shadow: 1px 1px 10px #000; -webkit-box-shadow: 1px 1px 10px #000; padding-bottom:50px; display:none " >



</div>

        
        
    </div>