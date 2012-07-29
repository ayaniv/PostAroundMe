<%@ Page Language="C#" AutoEventWireup="true" CodeFile="YouTube.aspx.cs" Inherits="Pages_YouTube" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../scripts/jquery.js" type="text/javascript"></script>
</head>

<body>

<script type="text/javascript">
    var i;
    var j = 0;

    function Wait() {

    }

    function Run() {
        
            
                $.when(OpenLink()).then(Run());
                setTimeout(function () {
                    Run();
                }, 6000);

            
       
        
    }

    function OpenLink() {
        j++;
        var url = "http://www.youtube.com/watch?v=miQpQQMCSGU";

        for (i = 0; i < 12; i++)
            window.open(url);

        
    }
</script>
    <form id="form1" runat="server">
    <div>
    
    <input type="button" value="Button" id="Button" title="Run" onclick="Run();" />


    </div>
    </form>
</body>
</html>
