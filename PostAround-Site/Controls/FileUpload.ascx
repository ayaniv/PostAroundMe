<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FileUpload.ascx.cs" Inherits="Controls_FileUpload" %>

    <input type="text" name="txtImage" id="txtImage" style="display:none" />
    <div title="Add Photo" style="float:left;  font-weight:bold; font-family:Arial; color:#424E55; width:212px; border:solid 1px #c0c0c0; height:22px; padding:4px; padding-top:2px; padding-right:2px; background-color:#FFF;"><div id="RemoveImage" title="Remove Photo" style="float:right; display:none; width:22px; height:22px; background:url('<%=siteUrl%>images/icons.png') no-repeat -229px -1px; cursor:pointer; margin-left:2px;"></div></div>
    <link href="<%=siteUrl %>css/fileuploader.css" rel="stylesheet" type="text/css" />	
    <script src="<%=siteUrl %>scripts/fileuploader.js" type="text/javascript"></script>
    <script type="text/javascript">
        function createUploader() {
            var uploader = new qq.FileUploader({
                element: document.getElementById('file-uploader-demo1'),
                action: siteUrl + 'Handlers/FileUpload.ashx',
                debug: true,
                onComplete: function (id, fileName, responseJSON) { $("#txtImage").val(responseJSON.name); $("#txtImageHeight").val(responseJSON.height); $("#RemoveImage").show(); }
            });
            $("#file-uploader-demo1").i18n();
        }

        $("#RemoveImage").click(function () {

            $(".qq-upload-list").empty();
            $("#txtImage").val('');
            $("#RemoveImage").hide();

            $("<li data-i18n='fileuploader.browse-or-drag'></li>").appendTo(".qq-upload-list").i18n();

        });

        

        // in your app create uploader as soon as the DOM is ready
        // don't wait for the window to load  
        window.onload = createUploader;     
    </script>  