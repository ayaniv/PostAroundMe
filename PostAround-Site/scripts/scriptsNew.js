// to disable/enable post button in add message
function SetPostButtonState(on) {
    if (on) {
        $("#PostButton").removeClass('Submit-Disable');
        $("#PostButton").html("Post");
        //requestRunning = false;
    } else {
        $("#PostButton").addClass('Submit-Disable');
        $("#PostButton").html("<img src='images/loading.gif' style='width:20px; height:20px;' />");
    }
}





function Linkify(inputText) {
    //URLs starting with http://, https://, or ftp://
    var replacePattern1 = /(\b(https?|ftp):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/gim;
    var replacedText = inputText.replace(replacePattern1, '<a href="$1" target="_blank">$1</a>');

    //URLs starting with www. (without // before it, or it'd re-link the ones done above)
    var replacePattern2 = /(^|[^\/])(www\.[\S]+(\b|$))/gim;
    replacedText = replacedText.replace(replacePattern2, '$1<a href="http://$2" target="_blank">$2</a>');

    return replacedText;
}


function SetMapCanvas(lat, lng) {
    var center = new GLatLng(lat, lng);

    var icon = GetMarker();
    var markerOptions = { icon: icon };

    var marker = new GMarker(center, markerOptions);

    var jsMap = new GMap2(document.getElementById("map_canvas1"));
    jsMap.setCenter(center, 15);
    jsMap.setUIToDefault();

    jsMap.setMapType(G_NORMAL_MAP);
    jsMap.checkResize();
    jsMap.addOverlay(marker);
}


function GetMarker() {
    var myIcon = new GIcon();
    myIcon.image = siteUrl + 'images/markers/image.png';
    myIcon.shadow = siteUrl + 'images/markers/shadow.png';
    myIcon.iconSize = new GSize(24, 31);
    myIcon.shadowSize = new GSize(40, 31);
    myIcon.iconAnchor = new GPoint(12, 31);
    myIcon.infoWindowAnchor = new GPoint(12, 0);
    myIcon.printImage = siteUrl + 'images/markers/printImage.gif';
    myIcon.mozPrintImage = siteUrl + 'images/markers/mozPrintImage.gif';
    myIcon.printShadow = siteUrl + 'images/markers/printShadow.gif';
    myIcon.transparent = siteUrl + 'images/markers/transparent.png';
    myIcon.imageMap = [14, 0, 17, 1, 18, 2, 20, 3, 20, 4, 21, 5, 22, 6, 22, 7, 23, 8, 23, 9, 23, 10, 23, 11, 23, 12, 23, 13, 23, 14, 23, 15, 22, 16, 22, 17, 21, 18, 21, 19, 20, 20, 19, 21, 19, 22, 18, 23, 17, 24, 16, 25, 15, 26, 15, 27, 14, 28, 13, 29, 12, 30, 11, 30, 10, 29, 10, 28, 9, 27, 8, 26, 7, 25, 6, 24, 6, 23, 5, 22, 4, 21, 3, 20, 3, 19, 2, 18, 2, 17, 1, 16, 1, 15, 1, 14, 0, 13, 0, 12, 0, 11, 0, 10, 1, 9, 1, 8, 1, 7, 2, 6, 2, 5, 3, 4, 4, 3, 5, 2, 7, 1, 10, 0];
    return myIcon;
}



// load google maps v2
google.load("maps", "2");
$(function () {
    
    //variable declaration
    // save the current slider uptoMeters value
    var TRESHOLD = 10;
    var POST_WIDTH = 284;
    var currSliderValue = null;
    var singleton = true;
    var getMessageState = 0; //{0: ready, 1:busy}
    var maxMessagesPerScreen = 20;
    var gmtHours = 0;
    var lastCall = null;
    var a = 1;
    var allResults = []; //= GetMessages(); // window.data;
    var resultsNum = 0;
    var currResults;
    var msgNumber = 0;
    var containersSize = [];
    var currHeight = 540;
    var currContainer;
    var numberOfColumns = 4;
    var itemsPerColumn = 4;
    var mouse_is_inside_categories = false;
    var mouse_is_inside_categories_clicked = false;
    var mouse_is_inside_sort_clicked = false;
    var mouse_is_inside_sort = false;
    var mouse_is_inside_addpost = false;
    var pageNum = 1;
    var maxPage = 1;
    var lastResults;
    var hasValue = false;
    var uptoMeters = -1;
    var isFirstTime = true;
    var allowScrolling = false;
    var fromNumber = 0;
    var stopLoadMore = false;
    var arrayCurrCategoriesID = [];
    var sortBy = 0;
    var isMine = 0;
    var lock_close_add_message_window = false;
    var maxYpos = 0;
    var boxesHeightsInRow;
    var screenWidth = 0;
    var msgsPerRow = 0;
    var prevScrolling = 0;
    var currPostCategory = "";
    var myMap;
    var jsCenter;
    var requestRunning = false;
    var getMessagesRunning = false;
    var arrangerRunning = false;
    var PopUpIsOpened = false;
    var lastBottomMargin = 0;
    var currZoomLevel = 0;
    // if not support in Geolocation
    isBrowserSupportGeoocation = true;
    CheckBrowserSupport();
    DisableAutoDiscoverForUnsupportedBrowsers();

    //set init values
    mouse_is_inside_popup = false;
    mouse_is_inside = false;
    mouse_is_clicked_inside = false;
    SetTimeZone();
    function SetTimeZone() {
        var currDate = new Date()
        gmtHours = -currDate.getTimezoneOffset() / 60;
    }
    $('#PopUpLoadingDiv')
    .ajaxSend(function () {

        $(this).show();
        //$("#MessagesContainer").fadeTo("slow", 0.33);
    })
    .ajaxComplete(function () {
        $(this).hide();
        
        if (PopUpIsOpened) {

            FB.XFBML.parse();
            gapi.plusone.go('GplusContainer', { "size": "medium" });

            var tempLat = $('#BigBoxContainer').attr('box-lat');
            var tempLon = $('#BigBoxContainer').attr('box-lon');
            SetMapCanvas(tempLat, tempLon);

            //
            

        }

    })
    .ajaxStop(function () {
        $(this).hide();


    });




    function GetAddressFromLatLon() {



        var center = new GLatLng(myLat, myLon);
        var geocoder = new GClientGeocoder();
        geocoder.getLocations(center, function (response) {

            if (response && response.Status.code == 200) {
                address = response.Placemark[0].address;
                ShowPosts();
            }
        });

    }

    GetDataFromQueryString();
    function GetDataFromQueryString() {
        if (getParameterByName("lat") != "" && getParameterByName("lon") != "") {
            myLat = getParameterByName("lat");
            myLon = getParameterByName("lon");
            GetAddressFromLatLon();
        } else if (getParameterByName("address") != "") {
            PerformGoToLocation(getParameterByName("address"))
        }
    }




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

    function RenderAddThis() {
        addthis.toolbox('.addthis_toolbox');
    }

    function FixAddThisAjax() {

        
        var script = 'http://s7.addthis.com/js/250/addthis_widget.js#pubid=ra-4fdef26e46826d05';
        if (window.addthis) {
            window.addthis = null;
            //window.addthis.ost = 0;
            //window.addthis.ready();

            //fix for blank counter
            window._adr = null;
            window._atc = null;
            window._atd = null;
            window._ate = null;
            window._atr = null;
            window._atw = null;
        }
        $.getScript(script);
    }





    $("#loadingDiv")
    .ajaxSend(function () {

        $(this).show();
        //$("#MessagesContainer").fadeTo("slow", 0.33);
    })
    .ajaxComplete(function () {
        $(this).hide();

        //$("#MessagesContainer").fadeTo("slow", 1);
    })
    .ajaxStop(function () {
        $(this).hide();


    });

    $("a", "#addMessageAddressSearchButton").button();

    function htmlDecode(value) {
        return $('<div/>').html(value).text();
    }

    function htmlEncode(value) {
        return $('<div/>').text(value).html();
    }

    // to avoid loading messgae when getMessgaeIsActive.
    // 0 ready, 1 busy
    function SetGetMessagesState(state) {
        getMessageState = state;
    }

    function GetGetMessagesState() {
        return getMessageState;

    }


    


    $("#slider").slider({
    
        value: 10500,
        range: "min",
        min: 0,
        max: 11000,
        step: 1000,
        change: function (event, ui) {
            fromNumber = 0;
            if (ui.value > 10000) {
                // go to DB and bring all
                uptoMeters = -1;
                StartTimerAndGetMessages(false);
                SetZoom(2);


            }
            else {

                // filter results by meters
                if (myLon != "" && myLat != "") {
                    uptoMeters = ui.value;

                    StartTimerAndGetMessages(false);

                    currZoomLevel = ui.value / 1000;
                    if (currZoomLevel > 10)
                        SetZoom(9);
                    else if (currZoomLevel == 10)
                        SetZoom(10);
                    else if (currZoomLevel == 9)
                        SetZoom(11);
                    else if (currZoomLevel == 8)
                        SetZoom(12);
                    else if (currZoomLevel == 7)
                        SetZoom(13);
                    else if (currZoomLevel == 6)
                        SetZoom(14);
                    else if (currZoomLevel == 5)
                        SetZoom(14);
                    else if (currZoomLevel == 4)
                        SetZoom(15);
                    else if (currZoomLevel == 3)
                        SetZoom(15);
                    else if (currZoomLevel == 2)
                        SetZoom(15);
                    else if (currZoomLevel == 1)
                        SetZoom(17);
                    else if (currZoomLevel == 0)
                        SetZoom(19);

                    //currResults = jQuery.grep(allResults, function (a) { return a.Distance <= ui.value && a.Distance >= 0 });

                } else {
                    alert("Please Insert Location");
                }
            }


            //            if (currResults != null)
            //                resultsNum = currResults.length;
            //            else
            //                resultsNum = 0;


            //maxPage = Math.ceil(resultsNum / (numberOfColumns * itemsPerColumn));
            //ShowMessages(currResults);
        },
        slide: function (event, ui) {
            if (ui.value > 10000) {
                $("#amount").val("ALL");
            } else {
                if (ui.value < 1000)
                    if (ui.value <= 0) {
                        $("#amount").val("Here");
                        ui.value = 0;
                    }
                    else {
                        $("#amount").val(ui.value + "m");
                    }
                else {

                    $("#amount").val((ui.value / 1000) + "KM");
                }

            }
        }
    });




    ShowPosts();
    function ShowPosts() {

        if (getParameterByName("isMine") == "1") {
            $("#btnMyPosts").html("All Posts");
            $("#btnMyPosts").addClass("selected")
            isMine = 1;
        }

        // If has location data in cookies, display shows in that location
        if (address != "" && myLat != "" && myLon != "") {
            address = address.ReplaceAll("+", " ");
            GetPosition();
        } else {
            // fresh new user - if it's not a direct link, means it's homepage - show all posts
            if (!isDirectLink) {
                uptoMeters = -1;
                StartTimerAndGetMessages(true);
            }
        }

    }


    ApplyMobilePhoneRules();
    function ApplyMobilePhoneRules() {
        if (isMobile) {
            ZeroiseBoxes();
            
            ApplyMobileUI();

            //user on mobile phone
            // auto ask for auto-detact
            // hide feedback panel
            $("#MainHeader").removeClass('FixedHeader');
            $("#LogoHeader").css('background', '');
            $("#LogoHeader").css('margin-top', '-4px');
            $("#MapSpacing").hide();
            $(".feedback-panel").hide();
            GetPosition();
           
            

          



        }
    }

    function ApplyMobileUI() {
        
        $('body').css("overflow", "hidden");
        $("#mobileHeader").show();
        $("#TopHeader").hide();
        $("#BottomDiv").hide();
        $(".feedback-panel").hide();
    }




    $('#TryAgain').click(function () {
        GetPosition();
    });


    $('#TryAgainWrapperAddPost').click(function () {
        $('#TopMessageAddPost').hide();
        RunAutoDicoverInAddMessage();
    });


    $('#TextLinkAddPost').click(function () {
        if ($('#AddMessageWindow').css("display") == "none")
            ShowAddMessageWindow(true);
        else
            $('#xbutton').click();
    });

    $('#liAddPost').click(function () {
        if ($('#AddMessageWindow').css("display") == "none")
            ShowAddMessageWindow(true);
        else
            $('#xbutton').click();
    });

    $('#txtPopupDetails1').focus(function () {

        ShowAddMessageWindow(true);
    });









    $('[placeholder]').focus(function () {
        var input = $(this);
        if (input.val() == input.attr('placeholder')) {
            input.val('');
            input.removeClass('placeholder');
        }
    }).blur(function () {
        var input = $(this);
        if (input.val() == '' || input.val() == input.attr('placeholder')) {
            if (input.attr('id') != 'amount' && input.attr('id') != 'content') {
                //this is protection for 'amount' and 'search location'
                input.addClass('placeholder');
                input.val(input.attr('placeholder'));
            }
        }
    }).blur();


    $('[placeholder]').parents('form').submit(function () {
        $(this).find('[placeholder]').each(function () {
            var input = $(this);
            if (input.val() == input.attr('placeholder')) {
                input.val('');
            }
        })
    });



    function hasPlaceholderSupport() {
        var input = document.createElement('input');
        return ('placeholder' in input);
    }


    $("#content").focus(function () {
        $(this).css('background-position', '0px -35px');
    });
    $("#content").blur(function () {
        if ($("#content").val() == '') {
            //            if (myLon == "" && myLat == "") {
            //                $("#WelcomeBubble").show();
            //                $("#AutoDiscoverBubble").hide();
            //            }
            //$("#content").val('Street Address, City, State');
            $(this).css("background", "#FFF url('images/locationInputBg.png') 0 0");
        }
        else {
            hasValue = true;
        }
        return false;
    });



    function SetSlide() {

        $("#slider").slider("value", 2000);
        $("#amount").val("2KM");



    }


    $("#bubbleOk").click(function () {

        var url = siteUrl + "/Handlers/SaveLocation.ashx";

        var myJSON = {
            "dontShowMeAgainWelcome": "1"
        };



        $.ajax({
            type: 'POST',
            url: url,
            data: myJSON,
            sync: false,
            dataType: "json",
            success: function (data) { $("#WelcomeBubble").hide(); }
        })



    });

    $(".TopButton").hover(function () {
        $(this).css("background-position", "0px -143px");
    }, function () {
        $(this).css("background-position", "0px -111px");
    });

    function DoScroll() {
        var scroll = document.body.scrollTop;
        if (scroll < 150) {
            $('html, body').animate({ scrollTop: 300 }, "slow");

        }
    }

    $("#headerBtnAddPost").click(function () {
        $(".TopButton").click();
    });

    $(".TopButton").click(function () {
        $("#AddMessageWindow").css("margin-top", -300);
        //if (currentUser != null) {
        //$("#txtPopupDetails").val($(""#content").val());
        if ($("#AddMessageWindow").css("display") == "none") {

            // DO SCROLL IF NEEDED
            //DoScroll();

            ShowAddMessageWindow(true);


        }
        else {

            HideAddMessageWindow();

        }
        //} else {
        //alert("Please Log In");
        //}


    });

    function HideAddMessageWindow() {
        $('#txtPopupDetails1').show();
        $("#AddMessageWindow").hide();
        $('#fuzz').hide();
        $('#PleaseLogin').hide();
    }

    function ShowAddMessageWindow(isNewMessage) {

        $('#txtPopupDetails1').hide();
        //SetPostButtonState(true);

        if (currentUser != null) {
            ManageBrowserSupport();
            $('.qq-upload-drop-area').hide();

            if (isNewMessage) {
                SetPostToFacebookCheckBoxIfPermissionAlreadyGranted();

                if (HasAddress())
                    ShowLocationInAddMessgae();
                else
                    ShowSearchLocationInAddMessage();
            }

        }





        $("#AddMessageWindow").show();
        $('#txtPopupDetails').focus();
        $('#fuzz').fadeIn();
    }








    $(".DropDown li").hover(function () {

        $(this).addClass("DropDownBg");
        $(this).css("background-color", $(this).children("span:first").css("background-color"));
        $(this).children().eq(2).css("color", "#FFF");
        //$(this).children().eq(2).css("font-weight", "bold");
        $(this).children().eq(1).hide();
    }, function () {
        $(this).removeClass("DropDownBg");
        $(this).css("background-color", "");
        $(this).children().eq(2).css("color", "#82898E");
        //$(this).children().eq(2).css("font-weight", "normal");
        $(this).children().eq(1).show();
    });

    //    function FilterResultsByCategoryID(collection, catId) {
    //        alert("Yaniv");
    //        if (catId == 0)
    //            currResults = collection;
    //        else
    //            currResults = jQuery.grep(collection, function (a) { return a.catID == catId });

    //        if (currResults != null)
    //            resultsNum = currResults.length;
    //        else
    //            resultsNum = 0;


    //        $.when(ShowMessages(currResults)).then(ArrangeBoxes($('#MessagesContainer').children().length));

    //    }

    var convert = function (convert) {
        return $("<span />", { html: convert }).text();
    };


    function SetCategoryNameInButton(html) {
        var word = $(html).children("span:last").html();
        word = convert(word);
        word = TruncString(word, 10);
        $("#btnCategory").text(word);

    }

    $("#catsBar li").hover(function () {
        if ($(this).attr("isSelected") != "true") {
            $(this).css("background-color", "#FCFCFC");

        }
    },
    function () {
        if ($(this).attr("isSelected") != "true") {
            $(this).css("background-color", "#F0F0F0");

        }
    }

    );


    function HighlightCategoryInBar(catId) {

        //turn off everything
        var childs = $('#catsBar').children("li");
        for (var i = 0; i < childs.length; i++) {
            $(childs[i]).children(".SelectedCategoryInBar").hide();
            $(childs[i]).css("background-color", "#F0F0F0");
            $(childs[i]).children().eq(3).css("color", "#82898E");
            $(childs[i]).attr("isSelected", "false");
        }

        //turn on specific category
        if (catId > 0) {
            var categoryLI = $("#catsBar").find('input[value="' + catId + '"]"').parent();

            categoryLI.children(".SelectedCategoryInBar").show();
            categoryLI.css("background-color", categoryLI.children(".Color").css("background-color"));
            categoryLI.children().eq(3).css("color", "#FFF");
            categoryLI.attr("isSelected", "true");
        }

    }

    var tempIndex;
    $("#catsBar li").click(function () {
        if ($(this).attr("isSelected") != "true") {
            arrayCurrCategoriesID.push($(this).children("input").val());

            fromNumber = 0;
            $.when(ZeroiseBoxes()).then(GetMessages());

            $(this).children(".SelectedCategoryInBar").show();
            $(this).css("background-color", $(this).children(".Color").css("background-color"));
            $(this).children().eq(3).css("color", "#FFF");
            $(this).attr("isSelected", "true");

        } else {

            tempIndex = arrayCurrCategoriesID.indexOf($(this).children("input").val());
            arrayCurrCategoriesID.splice(tempIndex, 1);


            fromNumber = 0;
            $.when(ZeroiseBoxes()).then(GetMessages());


            $(this).children(".SelectedCategoryInBar").hide();
            $(this).css("background-color", "#FCFCFC");
            $(this).children().eq(3).css("color", "#82898E");
            $(this).attr("isSelected", "false");
        }

    });

    $("#CategoriesBox li").click(function () {

        var catId = $(this).children("input").val();
        arrayCurrCategoriesID = [];
        if (catId > 0) {
            arrayCurrCategoriesID.push(catId);
        }
        HighlightCategoryInBar(catId);


        fromNumber = 0;
        $.when(ZeroiseBoxes()).then(GetMessages());

        $(this).css("background-color", "");
        $(this).children().eq(2).css("color", "#82898E");
        $(this).children().eq(1).show();

        //SetCategoryNameInButton($(this))

        mouse_is_inside_categories_clicked = false;
        $("#CategoriesBox").hide();
    });


    $("#SortBox li").click(function () {

        sortBy = $(this).children("input").val();

        if ((sortBy == 1) && (myLon == "" && myLat == ""))
            alert("Please Insert Location");
        else {
            fromNumber = 0;
            $.when(ZeroiseBoxes()).then(GetMessages());

            $("#btnSort").html($(this).html())
        }



        mouse_is_inside_sort_clicked = false;
        $("#SortBox").hide();

    });

    //    function SortResultsBy(sortMethodId) {
    //        alert("sort");
    //        if (sortMethodId == 1)
    //            currResults = currResults.sort(DistanceComparator);
    //        else
    //            currResults = currResults.sort(DateComparator).reverse();


    //        $.when(ShowMessages(currResults)).then(ArrangeBoxes($('#MessagesContainer').children().length));
    //    }

    function DistanceComparator(a, b) {
        return parseInt(a.Distance) - parseInt(b.Distance);

    }

    function DateComparator(a, b) {
        return parseInt(a.msgId) - parseInt(b.msgId);

    }


    function FlushErrorMessages() {
        errorText = "";
        $("#ddlCategory").css("border-color", "#C8C8C8");
        $("#txtPopupTitle").css("border-color", "#C8C8C8");
        $("#txtPopupDetails").css("border-color", "#C8C8C8");
        $(".ui-button").css("border-color", "#C8C8C8");
        $('#addMessageAddressInput').css("border-color", "#C8C8C8");
        $("#MandatoryFieldsMessage").hide();
    }

    var errorText;
    function IsClientFieldsOfAddMessageHasError() {
        var flag = false;
        errorText = "";
        if (currPostCategory == "") {
            $("#ddlCategory").css("border-color", "#FF0000");
            errorText = "Category"
            flag = true;
        } else {
            $("#ddlCategory").css("border-color", "#C8C8C8");
        }


        if (($.trim($("#txtPopupTitle").val()) == '') || ($.trim($("#txtPopupTitle").val()) == 'Add Title...')) {
            $("#txtPopupTitle").css("border-color", "#FF0000");
            if (errorText != "")
                errorText = errorText + ", ";
            errorText = errorText + "Title";
            flag = true;
        } else {
            $("#txtPopupTitle").css("border-color", "#C8C8C8");
        }


        if (($.trim($("#txtPopupDetails").val()) == '') || ($.trim($("#txtPopupDetails").val()) == "Post to your neighbors here !")) {
            $("#txtPopupDetails").css("border-color", "#FF0000");
            if (errorText != "")
                errorText = errorText + ", "
            errorText = errorText + "Details";
            flag = true;
        } else {
            $("#txtPopupDetails").css("border-color", "#C8C8C8");
        }
        if ($("#txtAddMessageLat").val() == "" || $("#txtAddMessageLon").val() == "") {
            $(".ui-button").css("border-color", "#FF0000");
            $('#addMessageAddressInput').css("border-color", "#FF0000");
            //Radio2Click();
            if (errorText != "")
                errorText = errorText + ", "
            errorText = errorText + "Location";
            flag = true;
        } else {
            $(".ui-button").css("border-color", "#C8C8C8");
        }


        return flag;
    }

    function AskForPermision() {
        FB.login(function (response) {
            CheckPermission();
        }, { scope: 'publish_stream' });
    }



    function CheckPermission() {
        FB.api('/me/permissions', checkAppUserPermissions);

        function checkAppUserPermissions(response) {
            if (response.data[0].publish_stream != 1)
                $("#ChkFacebook").click();
        }
    }

    function SetPostToFacebookCheckBoxIfPermissionAlreadyGranted() {

        FB.api('/me/permissions', SetCheckBoxToTrue);

        function SetCheckBoxToTrue(response) {

            if (response.data[0].publish_stream == 1) {
                $("#chkFacebookTrue").show();
                $("#chkPostToWall").attr('checked', true);
            }

        }
    }



    $("#PostButton").click(function () {



        var hasProblem = IsClientFieldsOfAddMessageHasError();

        if (hasProblem == true) {
            $("#MandatoryFields").html(errorText);
            $("#MandatoryFieldsMessage").show();
            return false;
        }

        else {

            SetPostButtonState(false);


            $("#MandatoryFieldsMessage").hide();

            if (address != "") {
                // to avoid the problem with edit message without inserting location
                $('#moreButtonsText').html(address + " ");
                //ChangeToSmallHeader();
            }

            //SetSlide();
            SendPostToServer();

        }

    });






    function InitLastCall() {
        var lastCall1 = new Object();
        lastCall1.myLat = myLat;
        lastCall1.myLon = myLon;
        lastCall1.uptoMeters = uptoMeters;
        lastCall1.gmtHours = gmtHours;
        lastCall1.fromNumber = fromNumber;
        lastCall1.currCatId = arrayCurrCategoriesID;
        lastCall1.sortBy = sortBy;
        lastCall1.isMine = isMine;
        lastCall1.maxMessagesPerScreen = maxMessagesPerScreen;
        return lastCall1;
    }

    function CheckGetMessageParamsChange() {
        if (lastCall == null)
            return true;
        else {
            if (lastCall.myLat != myLat)
                return true;
            if (lastCall.myLon != myLon)
                return true;
            if (lastCall.uptoMeters != uptoMeters)
                return true;
            if (lastCall.gmtHours != gmtHours)
                return true;
            if (lastCall.fromNumber != fromNumber)
                return true;
            if (lastCall.currCatId != arrayCurrCategoriesID)
                return true;
            if (lastCall.sortBy != sortBy)
                return true;
            if (lastCall.isMine != isMine)
                return true;
            if (lastCall.maxMessagesPerScreen != maxMessagesPerScreen)
                return true;
        }

        return false;
    }


    function SliderIsChanged() {
        if (lastCall == null)
            return true;
        else if (lastCall.uptoMeters != uptoMeters)
            return true;

        return false;
    }





    function SetPaging(data, pageNum) {
        //var str = "<b>[from]-[to] of [sum] posts around you !</b>"
        var str = "<b>showing [sum] posts around you !</b>"
        str = str.replace("[sum]", data.length);
        var currPageFirstMessageNum = (pageNum - 1) * (numberOfColumns * itemsPerColumn) + 1;
        var currPageLastMessageNum = (pageNum) * (numberOfColumns * itemsPerColumn);
        if (currPageLastMessageNum > data.length)
            currPageLastMessageNum = data.length;

        //str = str.replace("[from]", currPageFirstMessageNum).replace("[to]", currPageLastMessageNum);

        //$('#geoHeadText').html(str);

    }

    function SetAmountOfPosts(num) {
        var str = "<b>showing [sum] posts around you !</b>"
        str = str.replace("[sum]", num);
        //$('#geoHeadText').html(str);
    }


    function SendPostToServer() {

        if (requestRunning) { // don't do anything if an AJAX request is pending
            return;
        }

        var url = siteUrl + "/Handlers/SetMessage.ashx";

        var myJSON = {

            //categorId
            "catID": currPostCategory,

            //Title
            "title": $("#txtPopupTitle").val(),

            //Details
            "description": $("#txtPopupDetails").val(),

            //Photo
            "image": $("#txtImage").val(),

            //Location: Latidute
            "lat": $("#txtAddMessageLat").val(),

            //Location: Longitude
            "lon": $("#txtAddMessageLon").val(),

            //Location: Address
            "address": unescape($("#txtAddMessageAddress").val()),

            //post to wall
            "postToWall": $("#chkPostToWall").is(':checked'),

            //message id - for edit posts
            "msgId": $("#txtAddMessageMsgId").val(),

            //messate type, not in use, just for future option
            "type": "1"
        };



        var res = $.ajax({
            type: 'POST',
            url: url,
            data: myJSON,
            sync: false,
            dataType: "json",
            success: function (data) {

                if (data > 0) {
                    var latlon = myJSON.lat + "," + myJSON.lon;
                    if ($("#chkPostToWall").is(':checked'))
                        PostToWall(myJSON.description, myJSON.title, 'www.postaround.me', "Just posted around " + GetStatefromAddress(address), myJSON.image, 'http://www.postaround.me/post/' + data, latlon);


                    HideAddMessageWindow();
                    arrayCurrCategoriesID = [];
                    sortBy = 0;
                    isMine = 0;
                    ZeroiseBoxes();
                    maxYpos = 0;

                    FlushScreen();
                    $("#txtAddMessageMsgId").val('')

                    if (SliderIsChanged()) {
                        $.when(ChangeToSmallHeader()).then(SetSlide());
                    } else {
                        // dont wait, just get messgaes
                        StartTimerAndGetMessages(true);
                    }

                } else {

                    $("#MandatoryFields").html("Server Returned Error. Try again");
                    $("#MandatoryFieldsMessage").show();

                }
            },

            beforeSend: function () {
                requestRunning = true;
            },
            complete: function () {
                requestRunning = false;
                SetPostButtonState(true);
            }

        }).responseText;




    }

    function FlushScreen() {

        //categorId
        currPostCategory = "";
        $("#addPostBtnCategoryText").html('<span style="margin-left:5px; padding-top:3px; float:left;">Choose Category...</span>');

        //Title
        $("#txtPopupTitle").val('');

        //Details
        $("#txtPopupDetails").val('');
        $("#txtPopupDetails").height(70);
        $("#txtPopupDetails1").blur();

        //Photo
        $("#RemoveImage").click();

        //Location: Latidute
        $("#txtAddMessageLat").val('');

        //Location: Longitude
        $("#txtAddMessageLon").val('');

        //Location: Address
        $("#txtAddMessageAddress").val('');
        $("#divAddress").html('');
        $("#divManualAddress").hide();
        $("#CurrLocation").hide();
        $("#addMessageAddressInput").val('');

        //post to wall
        $("#chkPostToWall").attr('checked', false);

        //message id - for edit posts
        $("#txtAddMessageMsgId").val('');

        //set radio buttons off --yaniv radio
        //setRadiosOff();

        //show the placeholder in add messages fields
        $('#PopupBox').children().find('[placeholder]').blur();

        //flush error messages
        FlushErrorMessages();




    }

    $('#content').keydown(function (e) {

        $(this).css("background", "#FFF");

        if (e.keyCode == 13) {
            $('#SearchBtn').click();
        } else {
            if (!hasValue) {
                $('#content').val('');
                hasValue = true;
            }
        }


    });

    $('#txtAddressChange').keydown(function (e) {

        if (e.keyCode == 13) {
            $('#SearchBtn').click();
        }


    });

    $('#addMessageAddressInput').keydown(function (e) {

        if (e.keyCode == 13) {
            $('#addMessageAddressSearchButton').click();
        }


    });

    function ClearPositionCookie() {

        //call ajax to save cookie

        var url = siteUrl + "/Handlers/ClearLocationCookie.ashx";

        $.ajax({
            type: 'POST',
            url: url,
            sync: false,
            dataType: "json",
            success: function (data) { window.location.href = siteUrl; }
        });

    }


    $('#addMessageAddressSearchButton').click(function () {

        GetLatLngToAddMessage($('#addMessageAddressInput').val());
    });



    $('#ChangeLocationAddMessage').click(function () {
        $('#ChangeLocationAddMessage').hide();
        $('#divManualAddress').show();
        $('#divAddress').hide();


    });

    $('#ChangeLocationAddMessage').hover(function () {
        $(this).addClass('underline pointer');
    },

        function () {
            $(this).removeClass('underline pointer');
        }
    );

    function SaveLocationInCookie() {
        //call ajax to save cookie

        var url = siteUrl + "/Handlers/SaveLocation.ashx";

        var myJSON = {
            "lat": myLat,
            "lng": myLon,
            "address": escape(address)
        };



        $.ajax({
            type: 'POST',
            url: url,
            data: myJSON,
            sync: false,
            dataType: "json",
            success: function (data) { /*$('#SaveLocation').hide(); $('#LocationSaved').show();*/ }
        });


    }



    $('#AutoDiscover').hover(function () {
        if (isBrowserSupportGeoocation)
        { }
        $('#autoDiscoverText').fadeIn();

    },

        function () {
            if (isBrowserSupportGeoocation) { }
            $('#autoDiscoverText').fadeOut();

        }
    );

    $('#btnChangeLocation').click(function () {
        ToggleMapPanel(false)
        MakeAddressLinkabilityDie();
        $('#TopMessage').hide();
        $('#SearchLocation').show();
        if ($('#MapPas').css("display") == "none") {
            //ToggleMapPanel();
        }

    });


    $('#btnShowMap').click(function () {
        ToggleMapPanel(true)

    });


    $('#btnChangeLocationAddPost').click(function () {
        $('#divManualAddress').show();
        $('#TopMessageAddPost').hide();
    });


    function ToggleMapPanel(isRegular) {

        if (($('#MapPas').css("display") != "none") && isRegular) {

            //it is open. then CLOSE
            $('#MapPas').slideUp("slow", "easeInOutSine");
            $('#MapReal').fadeOut();


        }
        else {

            

            //it is closed. then OPEN
            $('#MapPas').slideDown("slow", "easeInOutSine");
            $('#MapReal').fadeIn();
            ResizeMap(myMap);
            

        }

    }






    $('.LocationLink').hover(function () {
        $(this).css("text-decoration", "underline");
    },

        function () {
            $(this).css("text-decoration", "none");

        }
    );

    function ChangeToSmallHeader() {

        $.when(ChangeToSmallHeaderStep1()).then(ChangeToSmallHeaderStep2());

    }

    function ChangeToSmallHeaderStep2() {
        if ($('#MapPas').css("display") != "none") {
            $('#MapPas').slideUp("slow", "linear");
            MakeAddressLinkability();

            $("#CategoriesBar").fadeIn();

            
        }

      

    }

    function ChangeToSmallHeaderStep1() {
        showMyLocation(myLat, myLon);

        if ($('#MapPas').css("display") != "none") {
            $('#MapPasText').fadeOut();
            $('#moreButtonsText').css("cursor", "pointer");
            $('#LocationLinks').show();
            $('#TopMessage').show();
            $('#SearchLocation').hide();
        }




    }




    function MakeAddressLinkabilityDie() {
        $('#moreButtonsText').die('click');
        $('#moreButtonsText').die('mouseover');
        $('#moreButtonsText').die('mouseout');
        $('#moreButtonsText').css("color", "#333");
    }

    function MakeAddressLinkability() {
        MakeAddressLinkabilityDie();
        //$('#moreButtonsText').css("color", "#6AA1BB");
        $('#moreButtonsText').live('click', function () { ToggleMapPanel(true) });
        $('#moreButtonsText').live('mouseover', function () { $(this).css("text-decoration", "underline"); });
        $('#moreButtonsText').live('mouseout', function () { $(this).css("text-decoration", "none"); });
    }



    $('.slider-button-off').live('click', function () {
        if ($(this).parents('.slider-frame').attr("IsPrivate") != "true") {
                $(this).parents('.slider-frame').children('.slider-button').addClass('on').html('<span class="PrivateIcon PrivateIconOn"></span>Private');
                $(this).parents('.slider-frame').children('.slider-button').css("background-position", "0px 0px");
                $(this).css("display", "none").css("left", "0").fadeIn().html('<span class="PublicIcon"></span>Public');
                $(this).parents('.slider-frame').attr("IsPrivate", "true");
                $(this).parents('.AddComment').children('#Comment').css('border', "1px dashed #6AA1BB");
                $(this).parents('.AddComment').children('#Comment').attr('placeholder', 'Reply to poster only...');
            } else {
                $(this).parents('.slider-frame').children('.slider-button').removeClass('on').html('<span class="PublicIcon PublicIconOn"></span>Public');
                $(this).parents('.slider-frame').children('.slider-button').css("background-position", "-8px 0px");
                $(this).css("display", "none").css("left", "50%").fadeIn().html('<span class="PrivateIcon"></span>Private');
                $(this).parents('.slider-frame').attr("IsPrivate", "false");
                $(this).parents('.AddComment').children('#Comment').css('border', "solid 1px #cbd2d4");
                $(this).parents('.AddComment').children('#Comment').attr('placeholder', 'Post a comment...');
        }
        $(this).parents('.AddComment').children('#Comment').focus();
            });

            $('.slider-button').live('click', function () {
                $(this).parents('.slider-frame').children('.slider-button-off').click();
            });





    $('#AutoDiscover').hover(function () {
        $(this).addClass('underline pointer');
    },

        function () {
            $(this).removeClass('underline pointer');
        }
    );

    $('#SaveLocation').hover(function () {
        $(this).addClass('underline pointer');
    },

        function () {
            $(this).removeClass('underline pointer');
        }
    );



    $('#addMessageAddressInput').click(function () {
        if ($(this).val() == "Enter address, location, city or zipcode...") $(this).val('')
    });

    $('#addMessageAddressInput').blur(function () {
        if ($(this).val() == '') $(this).val('Enter address, location, city or zipcode...')
    });



    $('#txtAddressChange').click(function () {
        if ($(this).val() == "Enter address, location, city or zipcode...") $(this).val('')
    });

    $('#txtAddressChange').blur(function () {
        if ($(this).val() == '') $(this).val('Enter address, location, city or zipcode...')
    });

    function RemoveAfter(msgId) {
        var i = 0;
        var j = 0;
        var msgIndex = 0;

        var array = $("#MessagesContainer").children();
        var found = false;
        while ((found == false) && (i < array.length)) {
            if ($(array.eq(i)).attr("box-id") == msgId) {
                msgIndex = i;
                found = true;
            }

            i++;
        }
        if (i == array.length || found == true) {
            fromNumber = msgIndex;
            for (j = msgIndex; j < array.length; j++)
                $(array.eq(j)).remove();
        }
    }


    function ShowImmediateComment(id, body, msgId, box, isPrivate) {
        // create json data with the comment details
        var currCommentsContainer = $("#MessagesContainer").find('[box-id=' + msgId + ']').find("#currCommentsView");
        var currCommentsContainerPopUp = $(box).find("#currCommentsView");



        var currentTime = new Date();

        var myJSON = {
            "ID": id,
            "Mine": true,
            "avatarImageUrl": currentUser.Image,
            "commentUserLink": currentUser.link,
            "body": body,
            "strDate": currentTime.format("d mmm yyyy"),
            "strTime": currentTime.format("HH:MM"),
            "name": currentUser.FirstName + " " + currentUser.LastName
        };

        // put the data in the template
        var markup;
        var currComment

        if (PopUpIsOpened) {
            markup = unescape($("#TemplateCommentBig").html());

            /* Compile markup string as a named template */
            $.template("CommentTemplate", markup)

            currComment = $.tmpl("CommentTemplate", myJSON);
 
            if (isPrivate == 'true') {
                $(currComment).find('.SingleComment').addClass('PrivateComment');
                $(currComment).find('.PosterOnly').show();
            }

            // push the template on comments area
            $(currComment).appendTo(currCommentsContainerPopUp);
        }
        //            if (!isDirectLink) {
        markup = unescape($("#TemplateComment").html());

        /* Compile markup string as a named template */
        $.template("CommentTemplate", markup)

        currComment = $.tmpl("CommentTemplate", myJSON);

 
        if (isPrivate == 'true') {
            $(currComment).find('.SingleComment').addClass('PrivateComment');
            $(currComment).find('.PosterOnly').show();
        }


        // push the template on comments area
        $(currComment).appendTo(currCommentsContainer);
        
        



    }




    function IncreaseCommentsNum(box) {

        var comments = $(box).find("#commentsNum");
        var commentsNum = $(comments).html();
        $(comments).html(++commentsNum);

    }


    function DecreaseCommentsNum(box) {

        var comments = $(box).find("#commentsNum");
        var commentsNum = $(comments).html();
        $(comments).html(--commentsNum);

    }

    $('.SingleComment').live('mouseover', function () { var element = $(this).find('#HideComment'); if (element != "") { $(element).show(); } });
    $('.SingleComment').live('mouseout', function () { var element = $(this).find('#HideComment'); if (element != "") { $(element).hide(); } })
    
    $('.Box').live('mouseover', function () { var element = $(this).find('.OnPostButtons'); if (element != "") { $(element).show(); } });
    $('.Box').live('mouseout', function () { var element = $(this).find('.OnPostButtons'); if (element != "") { $(element).hide(); } })

    $('.ShareButton').live('click', function () { ShowSharingButtons.apply(this); });
    //$('.SharingArea').live('mouseout', function () { HideSharingButtons.apply(this); });

    function HideSharingButtons() {
        var sharing_button = $(this).find('.ShareButton');
        var sharing_div = $(this).find('.SharingDiv');
        var sharing_area = $(this);

        if ($(sharing_area).attr('open')) {
            $(sharing_area).removeAttr('open');
            $(sharing_button).show();
            $(sharing_div).hide();
            
        }
    }


    function RenderAndShowButtons(sharing_button, sharing_div, func) {
        
        if (typeof func === 'function') { //check if b is a function
            func(); //invoke

        RenderAddThis();
        $(sharing_button).fadeOut('fast', function () {
            $(sharing_div).show();
           
        });

        }
    }

    function AddAttribute(to, name, value) {
        $(to).attr(name, value);
    }

    function ShowSharingButtons() {

        var sharing_button = $(this).parents('.MessageName').find('.ShareButton');
        var sharing_div = $(this).parents('.MessageName').find('.SharingDiv');
        var sharing_area = $(this).parents('.SharingArea');
        if (!$(this).parents('.SharingArea').attr('open')) {
            
            RenderAndShowButtons(sharing_button, sharing_div, function () {
                AddAttribute(sharing_area, 'open', 'true');
            });
        }
    }



    



    $('.Border').live('mouseover', function () { $(this).css("border-color", "#6AA1BB"); ($(this).find('.ImageBox')).css('opacity', '0.5'); });
    $('.Border').live('mouseout', function () { $(this).css("border-color", "#E2DDCF"); ($(this).find('.ImageBox')).css('opacity', '1'); });
    $('.ImageBox').live('click', function () { ShowPopUp.apply(this); });

    $('.zoomIn').live('click', function () { ShowPopUp.apply(this); });
    $('.zoomIn').live('mouseover', function () { $(this).addClass('underline'); });
    $('.zoomIn').live('mouseout', function () { $(this).removeClass('underline'); });

    //    $('#CommentsWord').live('click', function () { ShowComments.apply(this); });
    //    $('#CommentsWord').live('mouseover', function () { $(this).addClass('underline pointer'); });
    //    $('#CommentsWord').live('mouseout', function () { $(this).removeClass('underline pointer'); });

    //$('#Comment').live('keyup', function (e) { if (e.keyCode != 13) return;  });
    $('#Comment').live('keyup', function (e) {
        OrderElements();
    });

    $('#BtnPostComment').live('click', function () { PostComment($(this).parents('.Box'), $(this).parents('.AddComment').children('textarea').val(), $(this).parents('.Buttons').find('.slider-frame')) });

    $('#Comment').live('focus', function () {
        if ($(this).val() == "Post a comment...") {
            $(this).removeClass('TextColorBlack');
            $(this).val('')
        }
    });
//    $('#Comment').live('blur', function () {
//        if ($(this).val() == "") {
//            $(this).addClass('TextColorBlack');
//            $(this).val("Post a comment...")
//        }
//    });

    $('#HidePost').live('click', function () { DeletePost.apply(this); });
    //$('#HidePost').live('mouseover', function () { $(this).addClass('pointer'); });
    //$('#HidePost').live('mouseout', function () { $(this).removeClass('pointer'); });

    $('#HideComment').live('click', function () { HideComment.apply(this); });
    $('.SmallXButton').live('mouseover', function () { $(this).css('background-position-x', '-393px'); });
    $('.SmallXButton').live('mouseout', function () { $(this).css('background-position-x', '-140px'); });

    $('#EditPost').live('click', function () { EditPost.apply(this); });
    $('#Comment').live('focus', function () { if (IsLoggedIn()) { SetAutoGrow.apply(this); CommentTextAreaEventFucus.apply(this); } });
    $('#Comment').live('blur', function () { CommentTextAreaEventBlur.apply(this); });
    //$('#EditPost').live('mouseover', function () { $(this).addClass('pointer'); });
    //$('#EditPost').live('mouseout', function () { $(this).removeClass('pointer'); });

    
    $('.BoxLocation').live('mouseover', function () { $(this).parents(".BoxHead").find(".FullAddress").show(); });
    $('.BoxLocation').live('mouseout', function () { $(this).parents(".BoxHead").find(".FullAddress").hide(); });

    
    
    $(".SlimDropDown").live('mouseover', function () { $(this).css("background-color", "#F5F5F5");  });
    $(".SlimDropDown").live('mouseout', function () { $(this).css("background-color", "#DEE2E3"); });
    $(".SlimDropDown").live('click', function () { 
    
            if ($(this).children('.InlineText').text() == "Everyone") 
            {
                $(this).children('.InlineText').text('Poster Only');
                $(this).children('.PublicCommentIcon').hide();
                $(this).children('.PrivateCommentIcon').show(); 
            }
            else {
                $(this).children('.InlineText').text('Everyone')
                $(this).children('.PublicCommentIcon').show();
                $(this).children('.PrivateCommentIcon').hide(); 
            }
                
                });

    $(".MyButton").live('mouseover', function () { $(this).addClass("Hover"); });
    $(".MyButton").live('mouseout', function () { $(this).removeClass("Hover"); });


    $("#ShowOnMap").live("click",
    function () {

        //DisplayMap.apply(this);
        ShowPopUp.apply(this);
    });

    $("#Marker").live("click",
    function () {
        $('#ShowOnMap').click();
    });




    function ShowMessageForEdit(data) {





        //categorId
        currPostCategory = data.catID;
        //ALSO IN FIELD
        var inputField = $("#CategoriesBoxAddMessage").find('input[value="' + data.catID + '"]"');
        $("#addPostBtnCategoryText").html(inputField.parent().html());

        //Title
        $("#txtPopupTitle").val(data.title);

        //Details
        $("#txtPopupDetails").val(data.description);

        //Photo
        $("#txtImage").val(data.image);
        //ALSO IN FIELD
        if (data.image != "") {
            //show image path in fileuploader list
            ShowImageInFileUploaderList(data.image);
        }

        //Location: Latidute
        $("#txtAddMessageLat").val(data.latitude);

        //Location: Longitude
        $("#txtAddMessageLon").val(data.longitude);

        //Location: Address
        $("#txtAddMessageAddress").val(data.msgAddress);
        //ALSO IN FIELD --yaniv radio
        //setRadio('radio1');
        $("#divAddress").html(data.msgAddress);
        $("#CurrLocation").show();
        $("#divManualAddress").hide();



        //message id - for edit posts
        $("#txtAddMessageMsgId").val(data.msgId);

        // FINALLY - show the window
        ShowAddMessageWindow(false);


    }



    function ShowImageInFileUploaderList(strImage) {
        $(".qq-upload-list").empty();
        var item = '<li><span class="qq-upload-file" style="font-size:10px">' + strImage + '</span></li>';

        $(item).appendTo($(".qq-upload-list"));

        $("#RemoveImage").show();

    }


    function SetColors() {

        var currColor = "";
        $('.Line').each(function () {
            currColor = $(this).attr("color");
            $(this).css("background-color", currColor);
        });
    }


    $('#AboutArea').click(function () {
        if ($("#AboutBox").css("display") == "none")
            $("#AboutBox").show();
        //$("#AboutBox").css("margin-left.show();
        else
            $("#AboutBox").hide();
    });



    $('#divLogin').hover(function () {
        $(this).css("background-color", "#487690");
        if (currentUser != null) {
            $("#MoreBox").show();
        }

    }, function () {
        $(this).css("background-color", "");
        if (currentUser != null) {
            $("#MoreBox").hide();
        }
    });



    $('#liAddPost').hover(function () {
        $(this).css("background-color", "#487690");

    }, function () {
        $(this).css("background-color", "");

    });

    $('#liCategory').hover(function () {
        $(this).css("background-color", "#487690");
        $("#CategoriesBox").show();
        //$("#SortBox").show();

        //$('#topShpitz').animate({marginLeft: "300px"});

    }, function () {
        $(this).css("background-color", "");
        $("#CategoriesBox").hide();
        //$("#SortBox").hide();
        //$('#topShpitz').animate({ marginLeft: "42px" });
    });




    $('#liSort').hover(function () {
        $(this).css("background-color", "#487690");
        $("#SortBox").show();
        //$('#topShpitz').animate({marginLeft: "300px"});

    }, function () {
        $(this).css("background-color", "");
        $("#SortBox").hide();
        //$('#topShpitz').animate({ marginLeft: "42px" });
    });

    $('#divAbout').hover(function () {
        $(this).css("background-color", "#487690");
        $("#AboutBox").show();

    }, function () {
        $(this).css("background-color", "");
        $("#AboutBox").hide();
    });

    var menuWidth = 0;
    if ($('#divLogin').css('width'))
        menuWidth = parseInt($('#divLogin').css('width').replace("px", ""));

    $('#MoreBox').css("width", menuWidth + 34);
    $('#MoreBox li').css("width", menuWidth + 24);

    $('#xbutton').click(function () {
        $('#txtPopupDetails1').show();
        $("#txtAddMessageMsgId").val('');
        FlushScreen();
        HideAddMessageWindow();
    });

    $('#xbuttonLoginMsg').click(function () {

        HideAddMessageWindow();
    });

    $('#xbuttonPopUp').click(function () {
        $(this).parents(".PopupBox").hide();
        $('#fuzz').hide();
    });



    $('#xbuttonFeedback').click(function () {
        $('a.feedback-tab').click();
    });

    $('#xbuttonMoreButtons').click(function () {
        HideMoreButtonsArea(40);
    });


    $('#MoreBox').hover(function () {
        mouse_is_inside = true;
    }, function () {
        mouse_is_inside = false;
    });

    $('#PopUp').hover(function () {
        mouse_is_inside_popup = true;
    }, function () {
        mouse_is_inside_popup = false;
    });


    $("#UserSettings").hover(function () {
        mouse_is_clicked_inside = true;
    }, function () {
        mouse_is_clicked_inside = false;
    });

    $('#SortBox').hover(function () {
        mouse_is_inside_sort = true;
    }, function () {
        mouse_is_inside_sort = false;
    });



    $('#btnSort').hover(function () {
        mouse_is_inside_sort_clicked = true;
    }, function () {
        mouse_is_inside_sort_clicked = false;
    });



    $('#CategoriesBox').hover(function () {
        mouse_is_inside_categories = true;
    }, function () {
        mouse_is_inside_categories = false;
    });



    $('#btnCategory').hover(function () {
        mouse_is_inside_categories_clicked = true;
    }, function () {
        mouse_is_inside_categories_clicked = false;
    });



    $("body").mouseup(function () {
        if (!mouse_is_inside && !mouse_is_clicked_inside) $('#MoreBox').hide();
        if (!mouse_is_inside_categories && !mouse_is_inside_categories_clicked) $('#CategoriesBox').hide();
        if (!mouse_is_inside_sort && !mouse_is_inside_sort_clicked) $('#SortBox').hide();
        if (PopUpIsOpened && !mouse_is_inside_popup) ClosePopUp();
        
    });

    $(".MoreBox li").hover(function () {

        $(this).css("background-color", "#57849d");
        $(this).css("color", "#fefefd");

    },
        function () {
            $(this).css("background-color", "");
            $(this).css("color", "");
        });







    $("#btnMyPosts").click(function () {

        //allowScrolling = true;
        //ShowGeoHead();
        if ($(this).hasClass("selected")) {
            $(this).removeClass("selected");
            $(this).html("My Posts");
            isMine = 0;
        }
        else {
            $(this).html("All Posts");
            //CloseAllButtons();
            $(this).addClass("selected");
            if (currentUser != null) {
                isMine = 1;
            }
        }
        if (!isDirectLink) {
            fromNumber = 0;
            ZeroiseBoxes();
            GetMessages();
        } else {
            window.location = siteUrl + "?isMine=1";
        }

    });

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


    //    $("#btnSort").click(function () {

    //        if ($("#SortBox").css("display") == "none") {
    //            $("#SortBox").show();
    //        } else {
    //            $("#SortBox").hide();
    //        }



    //    });

    //    $("#btnCategory").click(function () {
    //        if ($("#CategoriesBox").css("display") == "none") {
    //            $("#CategoriesBox").show();
    //        } else {
    //            $("#CategoriesBox").hide();
    //        }
    //    });

    // 


    //    function CloseAllButtons() {
    //        if ($("#btnKeyword").hasClass("selected")) {
    //            $("#btnKeyword").removeClass("selected");
    //            HideMoreButtonsArea(67);
    //        }
    //        if ($("#btnCategory").hasClass("selected")) {
    //            $("#btnCategory").removeClass("selected");
    //            HideMoreButtonsArea(67);
    //        }
    //        if ($("#btnLocation").hasClass("selected")) {
    //            $("#btnLocation").removeClass("selected");
    //            HideMoreButtonsArea(40);
    //        }
    //        if ($("#btnMyPosts").hasClass("selected")) {
    //            $("#btnMyPosts").removeClass("selected");
    //        }
    //        if ($("#btnDistance").hasClass("selected")) {
    //            $("#btnDistance").removeClass("selected");
    //            $("#SliderBar").hide();
    //            HideMoreButtonsArea(40);
    //        }

    //    }





    $('textarea[maxlength]').keydown(function () {
        var max = parseInt($(this).attr('maxlength'));
        if ($(this).val().length > max) {
            $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
        }
    });

    


    //feedback

    var feedbackTab = {

        speed: 300,
        containerWidth: $('.feedback-panel').outerWidth(),
        containerHeight: $('.feedback-panel').outerHeight(),
        tabWidth: $('.feedback-tab').outerWidth(),

        init: function () {

            $('.feedback-panel').css('height', feedbackTab.containerHeight + 'px');

            $('a.feedback-tab').click(function (event) {

                if ($('.feedback-panel').hasClass('open')) {

                    $('#fuzz').fadeOut();
                    //$('#fuzz').css('z-index', '200');
                    $('.feedback-panel').animate({ left: '-' + feedbackTab.containerWidth }, feedbackTab.speed)
                        .removeClass('open');
                } else {
                    if (currentUser != null) {
                        $('#txtFeedbackName').val(currentUser.FirstName + " " + currentUser.LastName);
                    }

                    $('#fuzz').fadeIn();
                    //$('#fuzz').css('z-index', '99');
                    $('.feedback-panel').animate({ left: '0' }, feedbackTab.speed)
                        .addClass('open');
                }
                event.preventDefault();
            });
        }
    };

    feedbackTab.init();



    $("#PostFeedback").click(function () {

        var email = $("input#email").val();
        var message = $("textarea#message").val();
        var response_message = "Thank you for your comment, see ya!"

        var url = siteUrl + "/Handlers/SetFeedback.ashx";

        var myJSON = {

            "name": $("#txtFeedbackName").val(),
            "email": $("#txtFeedbackEmail").val(),
            "message": $("#txtFeedbackMessage").val()
        };



        var res = $.ajax({
            type: 'POST',
            url: url,
            data: myJSON,
            sync: false,
            dataType: "json",
            success: function () {
                //$('#form-wrap').html("<div id='response-message'></div>");
                //$('#response-message').html("<p>" + response_message + "</p>")
                $('#feedbackForm').hide();
                $('#response-message').show()

            .hide()
            .fadeIn(500)
            .animate({ opacity: 1.0 }, 1000)
            .fadeIn(0, function () {
                $('.feedback-panel')
                .animate({ left: '-' + (feedbackTab.containerWidth /*+ feedbackTab.tabWidth*/) },
                (feedbackTab.speed))
                .removeClass('open');

                $('#fuzz').fadeOut();
                $('#fuzz').css('z-index', '200');
                $('#response-message').hide();
                $("#txtFeedbackName").val('');
                $("#txtFeedbackEmail").val('')
                $("#txtFeedbackMessage").val('');
                $('#feedbackForm').show();

            })
            }

        });


        return false;
    });


    // feedback end



    $("#xbuttonAbout").click(function () {
        $("#BottomTextBox").hide();
    });


    function CheckBrowserSupport() {
        if (!Modernizr.geolocation) {
            isBrowserSupportGeoocation = false;
        }
    }


    function SetAutoGrow()
    {
        if (isBrowserSupportGeoocation) {
            $(this).autogrow();
        }
    }

    function DisableAutoDiscoverForUnsupportedBrowsers() {
        if (!isBrowserSupportGeoocation) {
            $("#AutoDiscover").css("cursor", "default");
            $("#AutoDiscover").unbind('click');
            $("#AutoDiscover").unbind('hover');
            $("#AutoDiscover").attr("title", "");
            $("#AutoDiscover").css("background-position", "-1 -74px");
            //$("#autoDiscoverText").hide();
        }
    }

    if (isBrowserSupportGeoocation) {
        $('#txtPopupDetails').autogrow();
    }

    function ManageBrowserSupport() {
        if (!isBrowserSupportGeoocation) {
            if (myLat == "" && myLon == "" && address == "") {
                //-- yaniv radio
                //$('label[for="radio1"]').addClass("ui-state-disabled");
                //Radio2Click();
                //setRadio('radio2');
            }
            else {
                //-- radio
                //$('label[for="radio1"]').removeClass("ui-state-disabled");
            }
        }

    }




    //---- ADD MESSAGE STUFF BEGIN

    $("#addPostBtnCategory").click(function () {
        if ($("#CategoriesBoxAddMessage").css("display") == "none") {
            $("#CategoriesBoxAddMessage").show();
        } else {
            $("#CategoriesBoxAddMessage").hide();
        }
    });

    $("#CategoriesBoxAddMessage li").click(function () {


        currPostCategory = $(this).children("input").val();


        $(this).css("background-color", "");
        $(this).children().eq(2).css("color", "#3c3c3c");
        $(this).children().eq(2).css("font-weight", "normal");
        $(this).children().eq(1).show();

        $("#addPostBtnCategoryText").html($(this).html())
        mouse_is_inside_categories_clicked = false;
        $("#CategoriesBoxAddMessage").hide();
    });




    $('#CategoriesBoxAddMessage').hover(function () {
        mouse_is_inside_categories = true;
    }, function () {
        mouse_is_inside_categories = false;
    });

    $('#btnCategory').hover(function () {
        mouse_is_inside_categories_clicked = true;
    }, function () {
        mouse_is_inside_categories_clicked = false;
    });

    $("#divAddressChange").click(function () {

        ShowSearchLocationInAddMessage();

    });










    $(".Checkbox").hover(function () {
        $(this).css("background-position", "-16px -61px");
    }, function () {
        $(this).css("background-position", "0px -61px");
    });

    $("#ChkFacebook").click(function () {
        $(this).css("background-position", "0px -61px");
        if ($("#chkFacebookTrue").css("display") == "none") {
            AskForPermision();

            $("#chkFacebookTrue").show();
            $("#chkPostToWall").attr('checked', true);

        } else {
            $("#chkFacebookTrue").hide();
            $("#chkPostToWall").attr('checked', false);
        }

    });



    //---- ADD MESSAGE STUFF END

    function PostToWall(message, title, caption, details, image, link, latlon) {

        var hasProblem = false;
        var params = {};
        params['message'] = message;
        params['name'] = title;
        params['caption'] = caption;
        params['description'] = details;
        params['link'] = link;
        if (image != "" && image != null) {
            params['picture'] = 'http://www.postaround.me/UploadedResized/' + image;
        }
        else {
            params['picture'] = image = "http://maps.googleapis.com/maps/api/staticmap?center=" + latlon + "&zoom=14&size=150x150&maptype=roadmap&sensor=true&markers=icon:http://postaround.me/images/markers/image.png%7C" + latlon;
        }


        FB.api('/me/feed', 'post', params, function (response) {
            if (!response || response.error) {
            } else { }
        });
    }




    function CloseThePopUp() {
        $('#PopUp').hide();
        $('#fuzz').hide();
        $('#PopUp').empty();
        PopUpIsOpened = false;
        $('body').css("overflow", "scroll");
        $('body').css("overflow-x", "hidden");
        $('#zoomScroll').hide();
    }

    function ClosePopUp() {
        CloseThePopUp();
        history.back();
        //ArrangeAll();
    }



    function ShowPopUp() {
        PopUpIsOpened = true;
        var href = $(this).attr("href");

        var box = $(this).parents(".Box"); // box
        var msgId = box.attr("box-id");

        // not HTML 5 supported
        if (!history.pushState) {
            window.location.href = href;
        } else {

            var stateObj = { id: msgId };

            history.pushState(stateObj, 'Viewing Post #' + msgId, rootDir + 'post/' + msgId);
            var url = href + " #BigBoxContainer, script";
            $('#PopUp').load(url);
            $("#PopUp").show();
            $('#zoomScroll').show();
            $('body').css("overflow", "hidden");




            //$("#fuzz").show();
            //$('#fuzz').css('z-index', '100');
            return false;
        }



    }



    window.onpopstate = function (e) {


        if (e.state !== null) { // state data available

        } else { // no state data available

            if (PopUpIsOpened)
                CloseThePopUp();


        }
    }

    function SendNotification(fromFacebookID, toFacebookID, commentId) {
        if (sendFacebookNotifications == "True") {
            if (fromFacebookID == toFacebookID)
                return;

            var url = "https://graph.facebook.com/" + toFacebookID + "/notifications";
            var params = { access_token: accessToken, template: "@[" + fromFacebookID + "] replied to your post around. Go read it!", href: "pages/PostNotify.aspx?commentId=" + commentId };

            $.ajax({
                type: "POST",
                url: url,
                data: params,
                dataType: "json"
            });
        }



    }




    $('#AddMessageAutoDiscover').click(function () {
        $('#autoDiscoverText').hide();
        RunAutoDicoverInAddMessage();
    });

    //------------------------LOCATION STUFF BEGIN



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
        var markerOptions = { icon: blueIcon
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
        var markerOptions = { icon: icon
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

    function HideWrittenTextInSearchBox() {
        $('#content').val('');
        $('#content').blur();
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

        });

        $.when(ChangeToSmallHeader()).then(SetSlide());

    }


    function ShowGeoHead() {
        if ($("#GeoHead").hasClass("GeoHeadDisable")) {
            $("#GeoHead").removeClass("GeoHeadDisable");
        }
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
        });
        $.when(ChangeToSmallHeader()).then(SetSlide());
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
        var url = "https://maps.google.com/maps?q=" + myLat + "," + myLon;
        window.open(url);

    });


    // mobile start
    


    //$('.MobileSettings').on('click', toggleSettings);

    //function toggleSettings() {
     
    //    var opened = $('.MobileContainer').data('opened');
        
    //    opened ? closeSettings() : openSettings();
    //}

    //function openSettings() {
    //    //$('.MobileTop').css("position", "static");
    //    //$('.MobileContainer').addClass('slideRight').data('opened', true);
    //}

    //function closeSettings(callback) {

        
    //    //$('.MobileContainer').removeClass('slideRight').data('opened', false);
    //    //if (callback) {
    //    //    if (supportTransitions) {
    //    //        $('.MobileContainer').on(transEndEventName, function () {
    //    //            $(this).off(transEndEventName);
    //    //            callback.call();
    //    //        });
    //    //    }
    //    //    else {
    //    //        callback.call();
    //    //    }
    //    //}

    //}

    //mobile end


    //------------------------END LOCATION STUFF



    //----DATA START

    var st;
    var lastScrollTop = 0;
    $(window).scroll(function () {
        if (isMobile) {


            st = $(this).scrollTop();
            if (st > lastScrollTop) {
                // downscroll code
                //$('.MobileTopSecondary').fadeOut('slow');
                $('.MobileBottom').slideUp('fast');
                
            } else {
                // upscroll code
                //$('.MobileTopSecondary').fadeIn('fast');
                $('.MobileBottom').slideDown('fast');
            }
            lastScrollTop = st;


            
        }
        if (isDirectLink || getMessagesRunning || arrangerRunning) {
            // don't do anything in direct link
            // don't do anything if an AJAX request is pending

            return;
        } else if (allowScrolling) {

            if (($(window).scrollTop() > maxYpos / 2) && ($(window).scrollTop() - prevScrolling > 0)) {

                if (!stopLoadMore) {
                    stopLoadMore = true;
                    fromNumber += maxMessagesPerScreen;
                    prevScrolling = $(window).scrollTop();
                    GetMessages();

                } else { }

            }
        }
    });
    function ShowMessages(data) {

        //show messages
        var markup = unescape($("#TemplateBox").html());

        /* Compile markup string as a named template */
        $.template("MessageTemplate", markup)

        var currColumn = $.tmpl("MessageTemplate", data);

        $(currColumn).appendTo("#MessagesContainer");

    }


    function AssignAndWait() {
        currSliderValue = uptoMeters;
        setTimeout(function () {
            if (currSliderValue == uptoMeters) {
                if (singleton) {

                    singleton = false; // to ignore slipped calls
                    lastCall = InitLastCall();
                    $.when(ZeroiseBoxes()).then(GetMessages());
                }
            }
            else {


                // if after 0.5 sec there was still change, wait and then re-call this function
                AssignAndWait();

            }
        }, 500);
    }

    function StartTimerAndGetMessages(isUrgent) {

        if (isUrgent) {
            fromNumber = 0;
            lastCall = InitLastCall();
            $.when(ZeroiseBoxes()).then(GetMessages());
            return;
        }

        // check if the slider is changed
        // wait 0.5 second to see if there is no movement
        // and then check the state
        // if state == 0
        // call the function




        if (CheckGetMessageParamsChange()) {
            if (SliderIsChanged()) {


                // wait until there is no move for 0.5 second

                AssignAndWait();


            }
            else {
                fromNumber = 0;
                $.when(ZeroiseBoxes()).then(GetMessages());
            }
        }







    }






    function GetMessages() {

        if (getMessagesRunning) { // don't do anything if an AJAX request is pending
            return;
        }



        var url = siteUrl + "/Handlers/GetMessages.ashx?currLat=" + myLat + "&currLon=" + myLon + "&uptoMeters=" + uptoMeters + "&timeZone=" + gmtHours + "&fromNumber=" + fromNumber + "&CategoryId=" + arrayCurrCategoriesID + "&SortBy=" + sortBy + "&IsMine=" + isMine + "&TakeNum=" + maxMessagesPerScreen;

        $.ajax({
            url: url,
            sync: false,
            error: function (xhr, ajaxOptions, thrownError) {

                SetGetMessagesState(0);
                singleton = true;
            },
            beforeSend: function () {
                getMessagesRunning = true;
            },

            success: function (data) {
                //AddMultipleMarkers(data);
                SetGetMessagesState(0);
                GetMessagesOnComplete(data);
                //ShowGeoHead();
                singleton = true;
            },
            complete: function () {
                getMessagesRunning = false;
                //RenderAddThis();
                //addthis.counter('.addthis_counter');
            }
        });


    }

    function GetTotalShares(url)
    {
        //facebook
        var fb_url = 'http://graph.facebook.com/?id=' + url;

        //twitter
        var tw_url = 'http://cdn.api.twitter.com/1/urls/count.json?url=' + url;

        //pinterest
        var pin_url = 'http://api.pinterest.com/v1/urls/count.json?callback=&url=' + url;

        //linkedin
        var ln_url = 'http://www.linkedin.com/countserv/count/share?url=' + url + '&format=json';

        //stumble
        var su = 'http://www.stumbleupon.com/services/1.01/badge.getinfo?url=' + url;
    }

    function GetMessagesOnComplete(data) {

        //alert(getMessageState);
        var myData = eval(data);

        if (myData.length == 0 && fromNumber == 0) {
            $('#NoPostsText').show();
            $('#MessagesContainer').hide();
            allowScrolling = false;

        } else {
            allowScrolling = true;
            if ($('#MessagesContainer').css("display") == "none") {
                $('#NoPostsText').hide();
                $('#MessagesContainer').show();
            }

            stopLoadMore = false;
            if (fromNumber == 0) {
                $('#MessagesContainer').empty();
                $('#BottomDiv').css("margin-top", "0px");
            }

            resultsNum += myData.length;
            $.when(ShowMessages(myData)).then(Organizer());
            SetColors();

            if (myData.length < maxMessagesPerScreen)
                stopLoadMore = true;

        }

    }

    function OrderElements() {
        $("#fuzz").css("height", $(document).height());
        //ArrangeBoxesInit();
        ArrangeAll();
    }

    function PostComment(box, body, sliderframe) {
        
        if (body == "")
            return;

        if (currentUser == null) {
            if (!isDirectLink) {
                if (PopUpIsOpened) {
                    alert("Please Login");
                }
                else {
                    ShowAddMessageWindow(true);
                }
            } else {
                alert("Please Login");
            }
            return;
        }
        
        var isPrivate = 'false'
        if (sliderframe != null && isPrivate != 'undefined') {
            isPrivate = sliderframe.attr('isprivate');
        }

        var msgId = $(box).attr("box-id");
        var toFacebookID = $(box).find("#FacebookID").html();
        var toUserID = $(box).find("#UserID").html(); 

        var url = siteUrl + "/Handlers/InsertComment.ashx";

        var myJSON = {
            "messageID": msgId,
            "body": body,
            "isPrivate": isPrivate

        };

        $.ajax({
            type: 'POST',
            url: url,
            data: myJSON,
            sync: false,
            dataType: "json",
            success: function (data) {
                
                
                ShowImmediateComment(data.Id, body, msgId, box, isPrivate);
                $(box).find("#Comment").val('').blur();
                $(box).find("#Comment").height(14);
                $(box).find(".Buttons").hide();

                if (!isDirectLink) {
                    arrangerRunning = true;
                    IncreaseCommentsNum(box);
                    ArrangeAll();
                }
                try
                {
                    SendNotification(currentUser.facebookID, toFacebookID, data.Key);
                } catch(err) {
                }
            }
        });

    }
    function DeletePost() {
        var answer = confirm("Hide that post?")
        if (answer) {
            var box = $(this).parents(".Box"); // div 'Bottom'
            var msgId = box.attr("box-id");

            var url = siteUrl + "Handlers/DeletePost.ashx";

            var myJSON = {
                "messageID": msgId
            };

            $.ajax({
                type: 'POST',
                url: url,
                data: myJSON,
                sync: false,
                dataType: "json",
                success: function (data) { box.remove(); ZeroiseBoxes(); Organizer(); }
            })
        }

    }




    function HideComment() {

        var msgId = $(this).parents('.Box').attr("box-id");
        var comment = $(this).parents("#SingleCommentView");
        var commentId = comment.attr("comment-id");
        var url = siteUrl + "Handlers/HideComment.ashx";

        var currCommentsInBack = $("#MessagesContainer").find('[box-id=' + msgId + ']').find('[comment-id=' + commentId + ']');

        var box = $(this).parents('.Box');
        var myJSON = {
            "commentID": commentId
        };

        $.ajax({
            type: 'POST',
            url: url,
            data: myJSON,
            sync: false,
            dataType: "json",
            success: function (data) {
                arrangerRunning = true;
                DecreaseCommentsNum(box);

                if (PopUpIsOpened) {
                    // delete the comment from behind the popup
                    currCommentsInBack.hide();
                }

                // delete to comment where it deleted
                comment.hide();
                if (!isDirectLink) {

                    ArrangeAll();
                }
            }
        })


    }
    
    function IsLoggedIn() 
    {
        if (currentUser == null)
        {
            $('#fuzz').show();
            //$('#fuzz').css("z-index", 2000);
            $('#PleaseLogin').show();

           


            $('#PleaseLogin').html($('#PopupBox').html());
            $('#xbuttonLoginMsg').live('click', function () { HideAddMessageWindow() });
            return false;
        } else 
        {
            return true;
        }
    }

    function CommentTextAreaEventFucus() {
        //$(this).shiftenter();
        //$(this).height(34);
        
        $(this).parents(".AddComment").children('.Buttons').show();
        OrderElements();
    }

    function CommentTextAreaEventBlur() {
        if ($(this).val() == "Post a comment...")
        {
            $(this).css("height", "14px");
            $(this).parents(".AddComment").children('.Buttons').hide();
            OrderElements();
        }
    }
   

    function EditPost() {


        //$("#AddMessageWindow").css("margin-top", $(document).scrollTop() - 400);

        var box = $(this).parents(".Box"); // div 'Bottom'
        var msgId = box.attr("box-id");

        var url = siteUrl + "/Handlers/GetMessageByID.ashx";

        var myJSON = {
            "msgId": msgId
        };

        $.ajax({
            type: 'POST',
            url: url,
            data: myJSON,
            sync: false,
            dataType: "json",
            success: function (data) { ShowMessageForEdit(data) }
        })


    }






    var winWidth = $(window).width(),
    winHeight = $(window).height();
    var resizeTimeout;

    $(window).resize(function () {

        if (isDirectLink)
            return;

        onResize = function () {

            OrderElements();
        }

        //New height and width
        var winNewWidth = $(window).width(),
        winNewHeight = $(window).height();

        // compare the new height and width with old one
        if (winWidth != winNewWidth || winHeight != winNewHeight) {
            window.clearTimeout(resizeTimeout);
            resizeTimeout = window.setTimeout(onResize, 10);
        }
        //Update the width and height
        winWidth = winNewWidth;
        winHeight = winNewHeight;
    });


    //----DATA END



    //-- DATA ARRANGE START

    var isArranging = false;

    function ArrangeAll() {

        $.when(ZeroiseBoxes()).then(Organizer());
    }

    function ZeroiseBoxes() {

        prevScrolling = 0;
        $.when(ZeroiseVariables()).then(ArrangeBoxesInit());
    }

    function ZeroiseVariables() {
        maxYpos = 0;
        //fromNumber = 0;

    }


    

    function ArrangeBoxesInit() {

        screenWidth = $('html, body').width() - 40;
        if (screenWidth < 1025) {
            $('#LeftWing').css("margin-left", "15px");
            $('#moreButtons').css("margin-left", "15px");
            $('#AddMessageWindow').css("margin-left", "16px");
            $('#CategoriesWrapper').css("display", "none");

            //iphone   
            //isMobile = true;
            //ApplyMobilePhoneRules();
            
          

            //$('#MessagesContainer').css("margin-left", "85px");
        } else {
            $('#CategoriesWrapper').css("display", "block");
            if ((screenWidth == 1383) || (screenWidth == 1400)) {
                $('#LeftWing').css("margin-left", "10px");
                $('#moreButtons').css("margin-left", "10px");
                $('#AddMessageWindow').css("margin-left", "11px");

                //$('#MessagesContainer').css("margin-left", "7px");
                screenWidth = 1420;
            } else {
                $('#LeftWing').css("margin-left", "39px");
                $('#moreButtons').css("margin-left", "39px");
                $('#AddMessageWindow').css("margin-left", "40px");
            }
        }

        msgsPerRow = Math.floor(screenWidth / POST_WIDTH) < 1 ? 1 : Math.floor(screenWidth / POST_WIDTH);
        var rowWidth = msgsPerRow * POST_WIDTH - 11 + "px";
        $('#MessagesContainer').css("width", rowWidth);
        $('#catsBar').css("width", rowWidth);

        $('#MessagesContainer').css("margin-left", "auto");
        $('#MessagesContainer').css("margin-right", "auto");
        boxesHeightsInRow = new Array(msgsPerRow);
        for (i = 0; i < boxesHeightsInRow.length; i++) {
            boxesHeightsInRow[i] = 0;
        }
    }



    function GetLowestColumn() {
        var j = 0;
        var minColumnHeight = boxesHeightsInRow[0];
        var minColumnIndex = 0;

        for (j = 1; j < msgsPerRow; j++) {
            if (boxesHeightsInRow[j] + TRESHOLD < minColumnHeight) {
                minColumnHeight = boxesHeightsInRow[j];
                minColumnIndex = j;
            }
        }
        var minColumn = { index: minColumnIndex, height: minColumnHeight };
        return minColumn;
    }

    function Organizer() {

        var posts = $('#MessagesContainer').children();
        var postsLength = 0;
        postsLength += $('#MessagesContainer').children().length;
        var i = 0;
        var currPostHeight = 0;

        var startIndex = 0;
        if (fromNumber != null && fromNumber != 'undefined' && fromNumber != "")
            startIndex = fromNumber;

        //Edge condition: Erase/Add Comment
        if (maxYpos == 0)
            startIndex = 0;



        for (i = startIndex; i < postsLength; i++) {
            currPostHeight = parseInt($(posts.eq(i)).css("height").replace("px", ""));

            if (i < msgsPerRow) {
                $(posts.eq(i)).css("left", POST_WIDTH * i + "px");
                $(posts.eq(i)).css("top", "0px");
                boxesHeightsInRow[i] += currPostHeight;

                if (currPostHeight > maxYpos)
                    maxYpos = currPostHeight;

            } else {
                // find the lowest column
                var minColumn = GetLowestColumn();

                // and put the next post there
                $(posts.eq(i)).css("left", POST_WIDTH * minColumn.index + "px");
                $(posts.eq(i)).css("top", minColumn.height + "px");

                // increase the column height watcher
                boxesHeightsInRow[minColumn.index] += currPostHeight;

                if (minColumn.height + currPostHeight > maxYpos) {
                    maxYpos = minColumn.height + currPostHeight;
                }

            }

            $(posts.eq(i)).fadeIn("slow");
        }
        if (i == postsLength) {
            $("#fuzz").css("height", $(document).height());
            $("#fuzz").css("width", $(document).width());
            arrangerRunning = false;
            isArranging = false;
        }

        if (maxYpos > 500) {
            $('#MessagesContainer').css("min-height", maxYpos);
        }

    }




    //-- DATA ARRANGE END
   
    


    



});

