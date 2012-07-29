<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test.aspx.cs" Inherits="Pages_test" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title></title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">
  html { height: 100% }
  body { height: 100%; margin: 0; padding: 0 }
  #map_canvas { height: 100% }
</style>
<script type="text/javascript"
    src="http://maps.googleapis.com/maps/api/js?key=<%=ConfigurationManager.AppSettings["GoogleKeyV3"] %>&sensor=false">
</script>
<script type="text/javascript">

    function initialize() {


        var latlng = new google.maps.LatLng(25.023602, 121.5549197);
        var myOptions = {
            zoom: 15,
            center: latlng,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        var map = new google.maps.Map(document.getElementById("map_canvas"),
        myOptions);

        var marker = new google.maps.Marker({
            position: latlng,
            title: "Post Around Me !"
        });

        // To add the marker to the map, call setMap();
        marker.setMap(map);
        
    }

</script>
</head>
<body onload="initialize()">
 
  <div id="map_canvas" style="width:600px; height:400px"></div>  
    
 
</body>
</html>




