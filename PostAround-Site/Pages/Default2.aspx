<html>
<head>
<title>alert</title>
<script type="text/javascript" src="http://www.google.com/jsapi?key=ABQIAAAA_qDbj9O8jWHuxLQTGoKHuxQ5Q9JvUhEAUrCDpo8PYiILdM7PfBQP5DmD0Z2sDadF4jgi8LvB_UFNdQ"></script>
<script type="text/javascript">
    
    google.load("maps", "2");



    
    if (window.navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
		showAddress, errorCallback, {
		    enableHighAccuracy: true, maximumAge: 600000
		}
    );
    } else {
        alert("Browser Not Supported");
    }

    function errorCallback(error) {
        // Update a div element with error.message.
    }

    function showAddress(position) {
        
        var jsCenter = new GLatLng(position.coords.latitude, position.coords.longitude);
        var geocoder = new GClientGeocoder();

        geocoder.getLocations(jsCenter, function (response) {
            address = response.Placemark[0].address;
            alert(address);
        });
    }
</script>
</head>
<body>
</body>
</html>