//-- Google  Maps V3
function initialize() {

    var input = /** @type {HTMLInputElement} */(document.getElementById('content'));
    var autocomplete = new google.maps.places.Autocomplete(input);

    var infowindow = new google.maps.InfoWindow();
    var marker = new google.maps.Marker({
        map: map
    });

    google.maps.event.addListener(autocomplete, 'place_changed', function () {
        infowindow.close();
        marker.setVisible(false);
        input.className = '';
        var place = autocomplete.getPlace();
        if (!place.geometry) {
            // Inform the user that the place was not found and return.
            input.className = 'notfound';
            return;
        }

        // If the place has a geometry, then present it on a map.
        if (place.geometry.viewport) {
            map.fitBounds(place.geometry.viewport);
        } else {
            map.setCenter(place.geometry.location);
            map.setZoom(17);  // Why 17? Because it looks good.
        }
        marker.setIcon(/** @type {google.maps.Icon} */({
            url: place.icon,
            size: new google.maps.Size(71, 71),
            origin: new google.maps.Point(0, 0),
            anchor: new google.maps.Point(17, 34),
            scaledSize: new google.maps.Size(35, 35)
        }));
        marker.setPosition(place.geometry.location);
        marker.setVisible(true);

        var address = '';
        if (place.address_components) {
            address = [
              (place.address_components[0] && place.address_components[0].short_name || ''),
              (place.address_components[1] && place.address_components[1].short_name || ''),
              (place.address_components[2] && place.address_components[2].short_name || '')
            ].join(' ');
        }

        infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
        infowindow.open(map, marker);
    });

}

google.maps.event.addDomListener(window, 'load', initialize);


function DisplayShortAddress(lat, lon, element) {


    if (lat.length < 8 || lon.length < 8) {
        $(element).text('');
        return
    }

    var reverseGeocode = "";
    var reverseGeocodeShort = "";
    var geocoder = new GClientGeocoder();
    var latlng = new GLatLng(lat, lon);


    geocoder.getLocations(latlng, function (response) {
        if (response && response.Status.code == 200) {

            reverseGeocode = response.Placemark[0].address;
            if (reverseGeocode.length > 32) {
                reverseGeocodeShort = reverseGeocode.substring(0, 30) + "..."
                $(element).text(reverseGeocodeShort);
            } else {
                $(element).text(reverseGeocode);
            }
            $(element).parent().children("#FullAddress").text(reverseGeocode);

        }



    });


}


function GetAddressFromLatLon() {



    var center = new GLatLng(myLat, myLon);
    var geocoder = new GClientGeocoder();
    geocoder.getLocations(center, function (response) {

        if (response && response.Status.code == 200) {
            address = response.Placemark[0].address;
            GetPosition();
        }



    });


}


function showAddress(position) {

    myLat = position.coords.latitude;
    myLon = position.coords.longitude;

    var center = new GLatLng(myLat, myLon);
    var geocoder = new GClientGeocoder();


    geocoder.getLocations(center, function (response) {
        if (response && response.Status.code == 200) {
            address = response.Placemark[0].address;
        } else {
            address = "My Location (" + myLat + ", " + myLon + ")";
        }

        ShowAdressDetailsInAddMessage(address, myLat, myLon);
        showAddressInBar(myLat, myLon, address);

    });
}

function showAddressInAddMessage(searchPhrase, lat, lng) {

    var center = new GLatLng(lat, lng);
    var geocoder = new GClientGeocoder();

    myLat = lat;
    myLon = lng;

    geocoder.getLocations(center, function (response) {
        if (response && response.Status.code == 200) {
            address = response.Placemark[0].address;
        } else {
            address = searchPhrase;
        }

        $("#CurrLocation").show();
        $("#divManualAddress").hide();
        ShowAdressDetailsInAddMessage(address, myLat, myLon);

    });


}


function showAddressInBar(lat, lng, searchPhrase) {
    //MakeAddressLinkability();
    var center = new GLatLng(lat, lng);
    var geocoder = new GClientGeocoder();

    myLat = lat;
    myLon = lng;

    geocoder.getLocations(center, function (response) {
        if (response && response.Status.code == 200) {
            address = response.Placemark[0].address;
        } else {
            address = searchPhrase;
        }


        $('#moreButtonsText').html(address + " ");



        $('#moreButtonsText').show();

        // Save Default Location
        SaveLocationInCookie();
        $.when(ChangeToSmallHeader()).then(SetSlide());
    });



}

function showPosition(position) {

    //MakeAddressLinkability();
    var center = new GLatLng(position.coords.latitude, position.coords.longitude);
    var geocoder = new GClientGeocoder();
    //allowScrolling = true;
    myLat = position.coords.latitude;
    myLon = position.coords.longitude;

    geocoder.getLocations(center, function (response) {
        if (response && response.Status.code == 200) {
            address = response.Placemark[0].address;

            //showMyLocation(myLat, myLon);

            //Save Location
            SaveLocationInCookie();

            $('#moreButtonsText').html(address + " ");
        }
        $.when(ChangeToSmallHeader()).then(SetSlide());
    });

}


function GetLatLngToAddMessage(address) {

    var geocoder = new GClientGeocoder();

    geocoder.getLatLng(
        address,
        function (point) {
            if (!point) {
                alert(address + " not found");
            } else {

                var lat = point.lat();
                var lng = point.lng();

                showAddressInAddMessage(address, lat, lng);
                showAddressInBar(lat, lng, address);
            }
        }
  );
}

function GetLatLng(address) {

    var geocoder = new GClientGeocoder();

    geocoder.getLatLng(
        address,
        function (point) {
            if (!point) {
                alert("Location Not Found.\nEnter address or place around you, in any language");
            } else {
                //allowScrolling = true;

                var lat = point.lat();
                var lng = point.lng();

                myLat = lat;
                myLon = lng;

                showAddressInBar(lat, lng, address);


            }
        }
  );
}


function SetLocationInAddressBar() {
    if (history.pushState) {
        var address_no_space = address.ReplaceAll(",", "").ReplaceAll(" ", "_").ReplaceAll("/", "_")
        var stateObj = { "address": address };
        history.pushState(stateObj, 'Viewing Posts Around ' + address, rootDir + 'in/' + address_no_space);
    }
}

// Auto Discover on the homepage
function GetPosition() {
    // if you have address already
    if (address != "" && myLat != "" && myLon != "") {
        //allowScrolling = true;
        $('#moreButtonsText').html(address + " ");
        $.when(ChangeToSmallHeader()).then(SetSlide());
    } else {
        //ShowMoreButtonsArea(40);
        if (window.navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(
            showPosition, errorCallback, {
                enableHighAccuracy: true, maximumAge: 600000
            }
    );
        } else {
            $('#moreButtonsText').html("<b>Your browser doesn't support it...</b> please type your address manually...");
        }
    }
}



function ShowLocationInAddMessgae() {
    GetAddress(false);
    $("#CurrLocation").show();
    $("#divManualAddress").hide();
}


function HasAddress() {
    if (address != "" && myLat != "" && myLon != "")
        return true;
    return false;
}

function RunAutoDicoverInAddMessage() {

    GetAddress(true);
    $("#CurrLocation").show();
    $("#divManualAddress").hide();


};



function ShowSearchLocationInAddMessage() {

    $("#txtAddMessageLat").val('');
    $("#txtAddMessageLon").val('');

    $("#CurrLocation").hide();
    $("#divManualAddress").show();


};


function inverseOrder(marker, b) {
    return -GOverlay.getZIndex(marker.getPoint().lat());
}


function importanceOrder(marker, b) {
    return GOverlay.getZIndex(marker.getPoint().lat()) + marker.importance * 1000000;
}

function createMarker(latlng, markerOptions, importance) {
    var marker = new GMarker(latlng, markerOptions);
    marker.importance = importance;
    GEvent.addListener(marker, "click", function () {
        var myHtml = latlng.toString();
        myMap.openInfoWindowHtml(latlng, myHtml);
    });
    return marker;
}

function AddMultipleMarkers(data) {

    /// צריך להביא את כל המרקרים ולא רק את החבילה הנוכחית אחרת אל תציג את זה

    var myData = eval(data);

    // Create our "tiny" marker icon
    var blueIcon = new GIcon(G_DEFAULT_ICON);
    blueIcon.image = "http://gmaps-samples.googlecode.com/svn/trunk/markers/blue/blank.png";

    // Set up our GMarkerOptions object
    var markerOptions = {
        icon: blueIcon
        , zIndexProcess: importanceOrder

    };

    var latlng;
    var marker;
    for (var i = 0; i < myData.length; i++) {
        latlng = new GLatLng(myData[i].latitude, myData[i].longitude);
        marker = createMarker(latlng, markerOptions, 0);
        myMap.addOverlay(marker);
    }
}




function showMyLocation(lat, lng) {


    var icon = GetMarker();
    var markerOptions = {
        icon: icon
        , zIndexProcess: importanceOrder

    };

    jsCenter = new GLatLng(lat, lng);
    var marker = new GMarker(jsCenter, markerOptions);
    marker.importance = 100;
    var htmlMap = document.getElementById("MapReal");
    if (htmlMap == null)
        return;
    myMap = new GMap2(htmlMap);

    myMap.setCenter(jsCenter);
    $("#MapReal").show();
    myMap.addOverlay(marker);

    ResizeMap(myMap);
}


function ShowLocationOnMap(lat, lng) {

    var center = new GLatLng(lat, lng);

    var icon = GetMarker();
    var markerOptions = { icon: icon };

    var marker = new GMarker(center, markerOptions);

    var jsMap = new GMap2(document.getElementById("map_canvas"));
    jsMap.setCenter(center, 15);
    jsMap.setUIToDefault();

    jsMap.setMapType(G_NORMAL_MAP);
    jsMap.checkResize();
    jsMap.addOverlay(marker);



    //V3
    //        var latlng = new google.maps.LatLng(lat, lng);
    //        var myOptions = {
    //            zoom: 15,
    //            center: latlng,
    //            mapTypeId: google.maps.MapTypeId.ROADMAP
    //        };
    //        var map = new google.maps.Map(document.getElementById("map_canvas"),
    //        myOptions);

    //        var marker = new google.maps.Marker({
    //            position: latlng,
    //            title: "Post Around Me !"
    //        });

    //        // To add the marker to the map, call setMap();
    //        marker.setMap(map);



    $("#Map").show();
    $("#fuzz").show();
    $('#fuzz').css('z-index', '100');
    ResizeMap(jsMap);

}



function ResizeMap(jsMap) {
    try {
        var center = jsMap.getCenter();
        jsMap.checkResize();
        jsMap.setCenter(center);
    } catch (err) { }
}

function SetZoom(zoomLevel) {
    myMap.setCenter(jsCenter);
    myMap.setZoom(zoomLevel);
}

function ShowAdressDetailsInAddMessage(address, myLat, myLon) {
    $('#divAddress').html(address + " ");
    $('#divAddressApprove').hide();
    $('#divAddressContainer').show();
    $("#divBrowserDontSupport").hide();

    $("#txtAddMessageLat").val(myLat);
    $("#txtAddMessageLon").val(myLon);
    $("#txtAddMessageAddress").val(address);

    SaveLocationInCookie();
}

function GetAddress(force) {

    if (address != "" && myLat != "" && myLon != "" && !force) {
        ShowAdressDetailsInAddMessage(address, myLat, myLon);
    }
    else if (window.navigator.geolocation) {

        $('#divAddress').html('');
        $('#divAddressApprove').show();
        $('#divAddressContainer').hide();
        $("#divBrowserDontSupport").hide();

        navigator.geolocation.getCurrentPosition(
        showAddress, errorCallbackAddMessage, {
            enableHighAccuracy: true, maximumAge: 600000
        }
    );
    } else {

        //$("#divBrowserDontSupport").show();
        //$('#divAddressApprove').hide();
        //$('#divAddressContainer').hide();


        //--yaniv radio
        //Radio2Click();
        //setRadio('radio2');
    }
}


function errorCallbackAddMessage(error) {

    var errMsg = "";
    var showTryAgain = false;
    var errJSON = GetErrorLocationMessage(error);
    if (errJSON.Code == errorCodes.UNKNOWN_ERROR || errJSON.Code == errorCodes.PERMISSION_DENIED) {
        errMsg = errJSON.Message;
        showTryAgain = true;
    } else if (errJSON.Code == errorCodes.TIMEOUT) {
        //navigator.geolocation.getCurrentPosition(showPosition, errorCallback, { enableHighAccuracy: true, maximumAge: 600000 });
    } else {
        errMsg = errJSON.Message;
    }

    if (errMsg != "") {
        $("#divBrowserDontSupport").html(errMsg);
        $("#TopMessageAddPost").show();
        $("#divBrowserDontSupport").show();
        $('#divAddressApprove').hide();
        $('#divAddressContainer').hide();

        $('#LocationLinksAddPost').show();
        if (showTryAgain) {
            $('#TryAgainWrapperAddPost').show();
        }
    }


    //$("#divBrowserDontSupport").html(error.message + " ");
    //        $("#divBrowserDontSupport").show();
    //        $('#divAddressApprove').hide();
    //        $('#divAddressContainer').hide();


}

var errorCodes = { "UNKNOWN_ERROR": 0, "PERMISSION_DENIED": 1, "POSITION_UNAVAILABLE": 2, "TIMEOUT": 3 };

function GetErrorLocationMessage(error) {

    var errJSON = {
        "Message": "Ooops... Couldn't get your location. Please click 'Change' to try again or to set it manually",
        "Code": errorCodes.UNKNOWN_ERROR
    };

    switch (error.code) {
        case errorCodes.PERMISSION_DENIED:
            errJSON.Message = "Ooops... Please Allow Location Tracking from Settings and 'Try Again' or click 'Change' to set it manually";
            errJSON.Code = errorCodes.PERMISSION_DENIED;
            break;
        case errorCodes.POSITION_UNAVAILABLE:
            errJSON.Message = "Ooops... Position Unavailable. We coudlnt get your location. Please click 'Change' to set it manually";
            errJSON.Code = errorCodes.POSITION_UNAVAILABLE;
            break;
        case errorCodes.TIMEOUT:
            errJSON.Code = errorCodes.TIMEOUT;
            break;
    }


    return errJSON;
}

function errorCallback(error) {

    var errMsg = "";
    var showTryAgain = false;
    var errJSON = GetErrorLocationMessage(error);
    if (errJSON.Code == errorCodes.UNKNOWN_ERROR || errJSON.Code == errorCodes.PERMISSION_DENIED) {
        errMsg = errJSON.Message;
        showTryAgain = true;
    } else if (errJSON.Code == errorCodes.TIMEOUT) {
        navigator.geolocation.getCurrentPosition(showPosition, errorCallback, { enableHighAccuracy: true, maximumAge: 600000 });
    } else {
        errMsg = errJSON.Message;
    }

    if (errMsg != "") {
        $('#moreButtonsText').html(errMsg);
        $('#LocationLinks').show();
        if (showTryAgain) {
            $('#TryAgainWrapper').show();
        }
    }
}



function HideWrittenTextInSearchBox() {
    $('#content').val('');
    $('#content').blur();
}


function ShowGeoHead() {
    if ($("#GeoHead").hasClass("GeoHeadDisable")) {
        $("#GeoHead").removeClass("GeoHeadDisable");
    }
}

$('#AutoDiscover').click(function () {

    //$('#MapBg').hide();
    $("#WelcomeBubble").hide();
    $("#AutoDiscoverBubble").hide();
    $("#autoDiscoverText").hide();


    $('#moreButtonsText').html("Please click <b>'Allow'</b> above to <b>Share Location</b>...");


    myLat = "";
    myLon = "";
    address = "";

    GetPosition();


    //$('#moreButtonsTextArea').hide();
    //$('#SearchBtn').hide();
    $('#moreButtonsText').css("cursor", "text");
    $('#moreButtonsText').show();
    $('#TopMessage').show();
    $('#SearchLocation').hide();
    $('#LocationLinks').hide();
    //$('#SaveLocation').show();
    //$('#AutoDiscover').hide();
});


function PerformGoToLocation(searchPhrase) {



    MakeAddressLinkabilityDie();

    //$('#MapBg').hide();
    $("#WelcomeBubble").hide();
    $("#AutoDiscoverBubble").hide();
    GetLatLng(searchPhrase);


}

$('#SearchBtn').click(function () {
    var searchPhrase = $('#content').val();
    if (searchPhrase == '') {
        ClearPositionCookie()
    } else {
        PerformGoToLocation(searchPhrase);
    }
});





var currLat = "";
var currLon = "";
var currAddress = "";

function DisplayMap() {

    var box = $(this).parents(".Box"); // div 'Bottom'


    $("#Map").css("margin-top", $(document).scrollTop() + 20);
    currLat = $(box).find("#CurrLat").html();
    currLon = $(box).find("#CurrLng").html();
    currAddress = $(box).find("#FullAddress").html();
    $("#MapAddress").html(currAddress);
    ShowLocationOnMap(currLat, currLon);
}


function SetThisAsMyAddress() {


    showAddressInBar(myLat, myLon, address);

    //$('#moreButtonsText').html(address + " ");
    //$.when(ChangeToSmallHeader()).then(SetSlide());


}


$('#SetThisAsMyAddress').click(function () {

    myLat = currLat;
    myLon = currLon;
    address = currAddress;
    showAddressInBar(myLat, myLon, address);
    $("#xbuttonPopUp").click();

});



$('#ViewOnMapSite').click(function () {

    myLat = currLat;
    myLon = currLon;
    var url = "https://maps.google.com/maps?daddr=" + myLat + "," + myLon;
    window.open(url);

});
//------------------------END LOCATION STUFF