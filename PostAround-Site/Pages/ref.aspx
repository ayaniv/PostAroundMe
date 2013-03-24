<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ref.aspx.cs" Inherits="Pages_ref" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <script type="text/javascript">

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

        var postId;
        if (getParameterByName("postId") != "") {
            postId = getParameterByName("postId");
        }

        window.top.location.href = "http://localhost/postaround/post/" + postId;

    </script>
    </div>
    </form>
</body>
</html>
