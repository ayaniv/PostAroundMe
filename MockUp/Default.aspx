﻿<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <script type="text/javascript" src="scripts/sample.js"></script>
    <script type="text/javascript" src="scripts/gears_init.js"></script>

    
</head>
<body>
    <form id="form1" runat="server">
    <div>



<p id="status"></p>




<script type="text/javascript">

init();

function init() {
  if (!window.google || !google.gears) {
    addStatus('Gears is not installed', 'error');
    return;
  }
  





  addStatus('Getting location...');

  function successCallback(p) {
    var address = "city: " + p.gearsAddress.city + ', '
                  + "streetNumber:" + p.gearsAddress.streetNumber + ', '
                  + "street:" + p.gearsAddress.street + ', '
                  + "country:" + p.gearsAddress.country + ' ('
                  
                  + p.latitude + ', '
                  
                  + p.longitude + ')';

    clearStatus();
    addStatus('Your address is: ' + address);

    var lat = 32.07826// 25.091075; 
    var lon = 34.773861 //121.559835;  
    
    var d = calcDist(p.latitude, p.longitude, lat , lon);
    
    addStatus('Your distance from dizingof square is: ' + d + ' meters');
  }
  
    function toRad(Value) {
        
        return Value * Math.PI / 180;
    }
    
    function calcDist(lat1, lon1, lat2, lon2) 
    {
    
        var R = 6371; // Radius of the earth in km
        var dLat = toRad(lat2-lat1);  // Javascript functions in radians
        var dLon = toRad(lon2-lon1); 
        var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
                Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) * 
                Math.sin(dLon/2) * Math.sin(dLon/2); 
        var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
        var d = R * c * 1000; // Distance in m
        return Math.ceil(d);
    }
    

  

    

  function errorCallback(err) {
    var msg = 'Error retrieving your location: ' + err.message;
    setError(msg);
  }

  try {
    
   var geolocation = google.gears.factory.create('beta.geolocation');
    
    geolocation.getCurrentPosition(successCallback,
                                   errorCallback,
                                   { enableHighAccuracy: true,
                                   gearsAddressLanguage: "he-IL",
                                     gearsRequestAddress: true });
  } catch (e) {
    setError('Error using Geolocation API: ' + e.message);
    return;
  }

}

</script>
    
    </div>
    </form>
</body>
</html>

