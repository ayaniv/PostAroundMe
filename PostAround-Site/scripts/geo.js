
//<![CDATA[
// Load jQuery and Google Maps
google.load("jquery", "1");
google.load("maps", "2");

var privacy = false;
var developer = false;

function developerToggle(){
	if (!privacy && !developer)
	{
		$("#mainColumn").addClass("mainColumnLeft");
		$("h3").addClass("doubleBorder");
	}
	
	if (privacy)
	{
		$(".privacy").addClass("hidden");
		privacy = false;
	}
	
	if (developer)
	{
		$("#mainColumn").removeClass("mainColumnLeft");
		$("#footer").removeClass("containerFull");
		$("h3").removeClass("doubleBorder");
		$(".floater").addClass("hidden");
		$(".developer").addClass("hidden");
		developer = false;
		this.href = "#";
	}
	else {
		$(".floater").removeClass("hidden");
		$(".developer").removeClass("hidden");
		$("#footer").addClass("containerFull");
		developer = true;
		this.href = "#developer";
		//pageTracker._trackEvent("MoreInfo","Developer");
	}
}

function privacyToggle(){
	if (!privacy && !developer)
	{
		$("#mainColumn").addClass("mainColumnLeft");
		$("#container").addClass("containerFull");
		$("h3").addClass("doubleBorder");
	}
	
	if (developer)
	{
		$(".developer").addClass("hidden");
		developer = false;
	}
	
	if (privacy)
	{
		$("#mainColumn").removeClass("mainColumnLeft");
		$("#container").removeClass("containerFull");
		$("h3").removeClass("doubleBorder");
		$(".floater").addClass("hidden");
		$(".privacy").addClass("hidden");
		privacy = false;
		this.href = "#";
	}
	else {
		$(".floater").removeClass("hidden");
		$(".privacy").removeClass("hidden");
		privacy = true;
		this.href = "#privacy";
		pageTracker._trackEvent("MoreInfo","Privacy");
	}
}

google.setOnLoadCallback(function() {
	var ipLocated = false;
	var ipMap = null;
	var geocoder = new GClientGeocoder();
	
	PR_TAB_WIDTH = 4;
	prettyPrint();
	
	if (/#privacy$/.test(window.location.href))
	{
		privacyToggle();
	}
	if (/#developer$/.test(window.location.href))
	{
		developerToggle();
	}
	
	$("#privacyLink").click(privacyToggle);
	$("#developerLink").click(developerToggle);
	
	if (!privacy){
		$(".privacy").addClass("hidden");
	}
	if (!developer){
		$(".developer").addClass("hidden");
	}
	
	if (google.loader.ClientLocation)
	{
		ipLocated = true;
		var center = new GLatLng(google.loader.ClientLocation.latitude, google.loader.ClientLocation.longitude);
		$("#ipLocationName").html(google.loader.ClientLocation.address.city + ", " + google.loader.ClientLocation.address.region.toUpperCase());
		$("<span>.</span>").insertAfter("#ipLocationName");	//crazy way to add a non-bold period after the address
		updateIpMap(center);
	}
	else {
		$("#ipLocationName").html("... Actually, I can't guess your location this way.");
	}
	
	$(document).ajaxError(function(event, XMLHttpRequest, ajaxOptions, thrownError)
	{
		pageTracker._trackEvent("AjaxError", XMLHttpRequest.status + "");
 	});
	
	var url = "http://ipinfodb.com/ip_query.php";
	$.get("http://npdoty.name/ip-proxy.php",{"url": url},function(data){
		var cityState = $(data).find("City").text();
		cityState += ", " + $(data).find("RegionName").text();
		if (cityState.length < 3)
		{
			cityState = "... Actually, I can't guess your location this way";
		}
		$("#ipLocationName2").html(cityState);
		$("<span>.</span>").insertAfter("#ipLocationName2");	//crazy way to add a non-bold period after the address

		if (!ipLocated)	//if Google ipLocation didn't work, then update the map with ipinfodb's information
		{
			var latitude = $(data).find("Latitude").text();
			var longitude = $(data).find("Longitude").text();
			var center = new GLatLng(latitude, longitude);
			if (latitude && longitude)
			{
				ipLocated = true;
			}
		}
		updateIpMap(center);
	});

	function updateIpMap(center)
	{
		if (GBrowserIsCompatible()) {
			if (ipLocated)
			{
				if (ipMap == null) {
					ipMap = new GMap2(document.getElementById("ipMap"));
					ipMap.setMapType(G_PHYSICAL_MAP);
				}
				if (center != null) {
					ipMap.setCenter(center, 13);
				}
			}
			else {
				$("#ipMap").addClass("hidden");
			}
		}
		else {
			//could add static map here
			$("#ipMap").addClass("hidden");
		}
	}	
	
	var geolocationErrorMessages = ["due to an unknown error", "because you didn't give me permission", "because your browser couldn't determine your location", "because it was taking too long to determine your location"]; 
	
	if (navigator.geolocation)
	{
		$("#supportedBrowser").html(" (and you are)");
		$("#findLocation").click(function(){
			$("#findLocation").html("Determining your location...").addClass("disabled");
			pageTracker._trackEvent("Geolocation","W3cAttempt");
			navigator.geolocation.getCurrentPosition(function(position){
				$("#foundError").html("");
				$("#foundLatLngMessage").html("Your browser has reported your coordinates as: ");
				var outputString = "Lat: " +position.coords.latitude + ", Lon: " + position.coords.longitude;
				if (position.coords.speed)
				{
					outputString += ", Speed: " + position.coords.speed;
				}
				if (position.coords.heading)
				{
					outputString += ", Heading: " + position.coords.heading;
				}
				if (position.coords.accuracy)
				{
					outputString += ", Accuracy: " + Math.round(position.coords.accuracy) + " meters";
				}
				
				$("#foundLatLng").html(outputString);
				
				if (GBrowserIsCompatible()) {
					var jsCenter = new GLatLng(position.coords.latitude, position.coords.longitude);
					var marker = new GMarker(jsCenter);
					$("#jsMap").removeClass("hidden");
					var jsMap = new GMap2(document.getElementById("jsMap"));
					jsMap.setCenter(jsCenter, 15);
					jsMap.setMapType(G_PHYSICAL_MAP);
					jsMap.addOverlay(marker);
				}
				
				$("#reverseGeocoding").removeClass("hidden");
				
				geocoder.getLocations(jsCenter, function(response){
					if (!response || response.Status.code != 200) {
						$("#reverseAddress").html("Whoops, reverse geocoding failed with error:" + response.Status.code);
					} else {
						place = response.Placemark[0];
						$("#reverseAddress").html(place.address);
					}
				});
				resetFindLink();
			},
			function(error){
				pageTracker._trackEvent("Geolocation","W3cError");
				$("#foundError").html("Sorry, I couldn't guess your location this way " + geolocationErrorMessages[error.code] + ".");
				resetFindLink();
			},
			{enableHighAccuracy: true, maximumAge: 120000});
			
			function resetFindLink(){
				$("#findLocation").html("Find my location again").removeClass("disabled");
			}
			
			return false;
		});
	}
	else {
		$("#findLocation").addClass("disabled").html("Browser not supported.");
		$("#suggestedSupportedBrowser").removeClass("hidden");
	}
});
//]]>
