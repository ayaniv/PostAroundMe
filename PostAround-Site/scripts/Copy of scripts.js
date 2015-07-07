

$(document).ready(function () {


    var a = 1;
    var myLat;
    var myLon;
    var allResults; //= GetMessages(); // window.data;
    var resultsNum;
    var currResults;
    var msgNumber = 0;
    var containersSize = [];

    var currHeight = 540;
    var currContainer;
    var numberOfColumns = 4;
    var itemsPerColumn = 4;
    mouse_is_inside = false;
    mouse_is_clicked_inside = false;

    var pageNum = 1;
    var maxPage = 1;
    var lastResults;




    $('#loadingDiv')
    .ajaxSend(function () {
        $(this).show();
        $('#MessagesContainer').fadeTo("slow", 0.33);
    })
    .ajaxComplete(function () {
        $(this).hide();
        $('#MessagesContainer').fadeTo("slow", 1);
    })
    //    .ajaxStop(function () {
    //        alert('stop');
    //        LoadingAnimation(0).apply(this);
    //        //        $(this).hide();
    //        //        $('#MessagesContainer').fadeTo("slow", 1);
    //    })
    ;

    //    var isLoading = 1;
    //    function LoadingAnimation(mode) {
    //        if (mode = 1) {

    //            $(this).show();
    //            $('#MessagesContainer').fadeTo("slow", 0.33);
    //            isLoading = 1;
    //        }
    //        else {
    //            debugger;
    //            if (isLoading = 1) {
    //                $(this).hide();
    //                $('#MessagesContainer').fadeTo("slow", 1);
    //                isLoading = 0;
    //            }
    //        }
    //    }


    navigator.geolocation.getCurrentPosition(
		showPosition, errorCallback, {
		    enableHighAccuracy: true, maximumAge: 600000
		}
    );

    function errorCallback(error) {
        // Update a div element with error.message.
    }

    function showPosition(position) {

        myLat = position.coords.latitude;
        myLon = position.coords.longitude;

        GetMessages();
    }


    function toRad(Value) {
        return Value * Math.PI / 180;
    }

    function calcDist(lat1, lon1, lat2, lon2) {

        var R = 6371; // Radius of the earth in km
        var dLat = toRad(lat2 - lat1);  // Javascript functions in radians
        var dLon = toRad(lon2 - lon1);
        var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
                Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) *
                Math.sin(dLon / 2) * Math.sin(dLon / 2);
        var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        var d = R * c * 1000; // Distance in m
        return Math.ceil(d);
    }



    var hasValue = false;
    $("#content").focus(function () {
        if (hasValue == false)
            $(this).val('');
        $(this).animate({ "height": "60px" }, "fast");
        return false;
    });


    $("#content").blur(function () {
        if ($("#content").val() == '') {
            $("#content").animate({ "height": "30px" }, "fast");
            hasValue = false;
            $("#content").val('Share your post around...');
        }
        else {
            hasValue = true;
        }
        return false;
    });

    function getGap(element) {
        return calcDist(element.latitude, element.longitude, myLat, myLon)
    }




    $("#slider").slider({
        value: 5000,
        min: 0,
        max: 5000,
        step: 100,
        change: function (event, ui) {

            currResults = jQuery.grep(allResults, function (a) { return /*(getGap(a)*/a.Distance <= ui.value });
            maxPage = Math.ceil(currResults.length / (numberOfColumns * itemsPerColumn));
            ShowMessages(currResults);
        },
        slide: function (event, ui) {
            $("#amount").val(ui.value + "m");
        }
    });
    $("#amount").val($("#slider").slider("value") + "m");


    function ShowMessages(data) {

        var i = 0;
        var container = "#container"
        for (i = 1; i <= numberOfColumns; i++) {
            $(container + i).empty();
        }

        //set paging details
        SetPaging(data, pageNum);


        var currPageFirstMessageNum = (pageNum - 1) * (numberOfColumns * itemsPerColumn);
        var currPageLastMessageNum = (pageNum) * (numberOfColumns * itemsPerColumn);
        if (currPageLastMessageNum > data.length)
            currPageLastMessageNum = data.length;

        //show messages

        for (i = currPageFirstMessageNum; i < currPageLastMessageNum; i += itemsPerColumn) {
            showColumn(i, data);
        }
    }

    $("#FireButton").click(function () {
        if (currentUser != null) {
            $("#txtPopupDetails").val($("#content").val());
            ShowAddMessageWindow();
        } else {
            alert("Please Log In");
        }


    });





    $("#PostButton").click(function () {

        AddMessage();
        HideAddMessageWindow();
    });




    function GetMessages() {

        var url = siteUrl + "Handlers/GetMessages.ashx?currLat=" + myLat + "&currLon=" + myLon;

        var result = $.ajax({
            url: url,
            sync: false,
            success: function (data) { SetAllResults(eval(data)); ShowMessages(eval(data)); }
        }).responseText;


    }

    function SetAllResults(data) {

        allResults = data;
        resultsNum = data.length;

        currResults = allResults;


        maxPage = Math.ceil(data.length / (numberOfColumns * itemsPerColumn));


    }

    function SetPaging(data, pageNum) {
        var str = "<b>[from]-[to] of [sum] posts around you !</b>"
        str = str.replace("[sum]", data.length);
        var currPageFirstMessageNum = (pageNum - 1) * (numberOfColumns * itemsPerColumn) + 1;
        var currPageLastMessageNum = (pageNum) * (numberOfColumns * itemsPerColumn);
        if (currPageLastMessageNum > data.length)
            currPageLastMessageNum = data.length;

        str = str.replace("[from]", currPageFirstMessageNum).replace("[to]", currPageLastMessageNum);

        $('#geoHeadText').html(str);

    }

    function AddMessage() {

        var url = siteUrl + "/Handlers/SetMessage.ashx";



        var myJSON = {

            "lat": myLat,
            "lon": myLon,
            "catID": $("#ddlCategories").val(),
            "userID": currentUser.userID,
            "title": $("#txtPopupTitle").val(),
            "description": $("#txtPopupDetails").val(),
            "image": "images/facebookAvatar.jpg",
            "type": "1"

        };



        var res = $.ajax({
            type: 'POST',
            url: url,
            data: myJSON,
            sync: false,
            dataType: "json",
            success: function (data) { GetMessages(); }
        }).responseText;



    }

    function AddItem(JsonItem) {
        data = data.reverse();
        data.push(JsonItem);
        data = data.reverse();
        currResults = data;
        ShowMessages();
    }

    function showColumn(startIndex, collection) {

        msgNumber++;
        var res2 = [];
        var i = 0;
        var j = (startIndex / numberOfColumns) % numberOfColumns + 1;
        containersSize[j - 1] = -1 * itemsPerColumn;

        for (i = startIndex; i < startIndex + itemsPerColumn && i < collection.length; i++) {
            res2.push(collection[i]);
            containersSize[j - 1] += 1;
        }
        var markup = unescape($("#TemplateBox").html());

        /* Compile markup string as a named template */
        $.template("MessageTemplate", markup);
        var boxId = "newId" + msgNumber;
        //$("#BoxTest").attr("id", boxId);



        //var title = $(this).find("#Title");

        /*
        title.live('click', function () { SetSize.apply($("#" + boxId)); });

        $("#" + boxId).live('click', function () { SetHovers.apply(this) });
        */

        //$("#" + boxId).live('click', function () { SetSize.apply(this); SetHovers.apply(this) });

        var tempName = "#container" + j;
        var d = new Date();
        var i = d.getTime();
        $(tempName).empty();
        $.tmpl("MessageTemplate", res2).appendTo(tempName);


    }

    /* Add an onclick handler for the movie template items */




    $('#CommentsWord').live('click', function () { ShowComments.apply(this); });
    $('#CommentsWord').live('mouseover', function () { $(this).addClass('underline pointer'); });
    $('#CommentsWord').live('mouseout', function () { $(this).removeClass('underline pointer'); });

    $('#Comment').live('keydown', function (e) { alert('hi'); /*PostComment(e, msgId, $(this).val()).apply(this);*/ });



    $(".BoxBody").live("click",
    function () {
        SetSize.apply(this);

    });




    //$(".Bottom").die('click', foo);
    //$(".Box.Bottom").die("click");





    function PostComment(e, msgId, data) {
        if (e.keyCode == 13) {

            var url = siteUrl + "Handlers/InsertComment.ashx";

            if (currentUser == null) {
                alert("Please Log In");
                return;
            }


            var myJSON = {
                "messageID": msgId,
                "userID": currentUser.userID,
                "body": data

            };



            var res = $.ajax({
                type: 'POST',
                url: url,
                data: myJSON,
                sync: false,
                dataType: "json",
                success: function (data) { GetMessages(); }
            }).responseText;

        }
    }

    function ShowComments() {



        var box = $(this).parents("div.Bottom"); // div 'Bottom'
        var commentsNum = box.find('#CommentsNum').text();

        if (commentsNum == 0) return;

        var msgId = box.parent().find('#MsgID').text();

        if (!(box).hasClass("isOpen")) {

            (box).addClass("isOpen");

            if (!(box).hasClass("wasOpened")) {
                var url = siteUrl + "Handlers/GetCommentsByMsgID.ashx?id=" + msgId;

                var result = $.ajax({
                    url: url,
                    sync: false,
                    success: function (data) { (box).addClass("wasOpened"); ShowCommentsLayout(eval(data), box); }
                }).responseText;
            } else {

                var commentsContainer = $(box).find('#currCommentsView');
                ExpandBoxLayout(box, commentsContainer);
                commentsContainer.show();
            }

        } else {


            var commentsContainer = $(box).find('#currCommentsView');
            ContractBoxLayout(box, commentsContainer)

            $(box).removeClass("isOpen");


        }




    }



    function ContractBoxLayout(box, commentsContainer) {

        var currHeight = $(commentsContainer).css("height");

        $('#BottomDiv').animate({ "margin-top": "-=" + currHeight }, "normal");

        //$(box).animate({ "height": "-=" + currHeight }, "normal");
        $(box).parent().animate({ "height": "-=" + currHeight }, "normal");
        commentsContainer.hide();
    }

    function ExpandBoxLayout(box, commentsContainer) {

        var currHeight = $(commentsContainer).css("height");

        $('#BottomDiv').animate({ "margin-top": "+=" + currHeight }, "normal");

        commentsContainer.css("height", currHeight);
        $(box).parent().animate({ "height": "+=" + currHeight }, "normal");
        commentsContainer.show();
    }


    function ShowCommentsLayout(data, box) {

        var commentsContainer = $(box).find('#currCommentsView')
        var markup = unescape($("#CommentTemplate").html());
        $.template("CommentTemplate", markup);
        $.tmpl("CommentTemplate", data).appendTo($(commentsContainer));

        ExpandBoxLayout(box, commentsContainer);


    }



    function SetSize() {
        //debugger;
        //if ($(this).css("height") == "130px") //close
        if (!$(this).parent().hasClass("BoxIsOpen")) // close
        {

            $(this).parent().addClass("BoxIsOpen");
            var box = $(this).parent();
            $(this).parent().animate({ "height": "266px" }, "normal");
            $(this).find('.MoreInfo').fadeIn();
            $(this).parent().find('#Comment').text("");
            $(this).parent().find('#Comment').focus();

            var msgId = $(this).find('#MsgID').text();


            //$(this).after($("#CommentsView"));


            //            ($(this).parent()).find('#commentsLink').live('click', function () { ShowComments(box, msgId); });
            //            ($(this).parent()).find('#CommentsWord').live('mouseover', function () { $(this).addClass('underline'); });
            //            ($(this).parent()).find('#CommentsWord').live('mouseout', function () { $(this).removeClass('underline'); });

            //            ($(this).parent()).find('#Comment').live('keydown', function (e) { PostComment(e, msgId, $(this).val()).apply(this); });



            $(this).find('#fullDesc').show();
            $(this).find('#shortDesc').hide();

            currContainer = $(this).parent().parents("div").attr('rel');
            if (currContainer != null)
                containersSize[currContainer] += 1;

        }
        else //open
        {
            $(this).parent().removeClass("BoxIsOpen");
            $(this).parent().animate({ "height": "130px" }, "normal");
            $(this).find('.MoreInfo').hide();

            $(this).find('#fullDesc').hide();
            $(this).find('#shortDesc').show();

            if ($(this).parent().find('#Comment').text() == "")
                $(this).parent().find('#Comment').text("Write a comment...");


            currContainer = $(this).parent().parents("div").attr('rel');
            if (currContainer != null)
                containersSize[currContainer] -= 1;





        }


        currHeight = GetMaxValue(containersSize) * 133;
        $('#BottomDiv').animate({ "margin-top": currHeight + "px" }, "normal");


    }

    //Adjust height of overlay to fill screen when page loads
    $("#fuzz").css("height", $(document).height());


    function HideAddMessageWindow() {

        $('#PopupBox').fadeOut();
        $('#fuzz').fadeOut();
    }

    $('#xbutton').click(function () {
        HideAddMessageWindow()
    });

    //    $('#PopupBox').hover(function () {

    //        mouse_is_inside = true;
    //        $('#xbutton').hover(function () {
    //            mouse_is_inside = false;
    //        })
    //    }, function () {
    //        mouse_is_inside = false;
    //    });



    //    $("body").mouseup(function () {
    //        if (mouse_is_inside)
    //            mouse_is_clicked_inside = true;
    //        else
    //            mouse_is_clicked_inside = false;
    //    });

    //    $("body").mouseup(function () {
    //        if ((!mouse_is_inside) && (!mouse_is_clicked_inside)) {
    //            HideAddMessageWindow()
    //        }
    //    });



    function ShowAddMessageWindow() {
        $('#PopupBox').fadeIn();
        $('#fuzz').fadeIn();
    }


    $(window).bind("resize", function () {
        $("#fuzz").css("height", $(window).height());
    });



    function GetMaxValue(collection) {
        if (collection == null)
            return 0;
        var max = collection[0];
        var i = 1;
        for (i = 1; i < collection.length; i++) {
            if (collection[i] > max)
                max = collection[i];
        }

        return max;

    }



    $("#LeftArrow").click(function () {

        if (pageNum > 1) {
            pageNum--;
            ShowMessages(currResults);
        }


    });

    $("#RightArrow").click(function () {


        if (pageNum < maxPage) {
            pageNum++;
            ShowMessages(currResults);
        }




    });


    //    $(".CommercialBox").click(function () {

    //        SetSize.apply(this);
    //    });

    //    $(".BoxTest").click(function () {

    //        SetSize.apply(this);
    //    });


    $("#btnMyPosts").click(function () {
        if ($(this).hasClass("selected")) {
            $(this).removeClass("selected");

            currResults = lastResults;
            maxPage = Math.ceil(currResults.length / (numberOfColumns * itemsPerColumn));
            ShowMessages(currResults);
        }
        else {
            $(this).addClass("selected");
            lastResults = currResults;
            currResults = jQuery.grep(currResults, function (a) { return a.userid == currentUser.userID });
            maxPage = Math.ceil(currResults.length / (numberOfColumns * itemsPerColumn));
            ShowMessages(currResults);
        }
    });



    $("#btnLocation").click(function () {
        if ($(this).hasClass("selected")) {
            $(this).removeClass("selected");
            HideMoreButtonsArea(167);
        }
        else {
            CloseAllButtons();
            $(this).addClass("selected");

            ShowMoreButtonsArea(167);
        }
    });

    $("#btnCategory").click(function () {
        if ($(this).hasClass("selected")) {
            $(this).removeClass("selected");
            HideMoreButtonsArea(67);

        }
        else {
            CloseAllButtons();
            $(this).addClass("selected");

            ShowMoreButtonsArea(67);


        }
    });

    $("#btnKeyword").click(function () {
        if ($(this).hasClass("selected")) {
            $(this).removeClass("selected");
            HideMoreButtonsArea(67);

        }
        else {
            CloseAllButtons();
            $(this).addClass("selected");

            ShowMoreButtonsArea(67);
        }
    });


    function CloseAllButtons() {
        if ($("#btnKeyword").hasClass("selected")) {
            $("#btnKeyword").removeClass("selected");
            HideMoreButtonsArea(67);
        }
        if ($("#btnCategory").hasClass("selected")) {
            $("#btnCategory").removeClass("selected");
            HideMoreButtonsArea(67);
        }
        if ($("#btnLocation").hasClass("selected")) {
            $("#btnLocation").removeClass("selected");
            HideMoreButtonsArea(167);
        }

    }

    function ShowMoreButtonsArea(height) {
        $('#moreButtons').css("height", height - 26 + "px");
        $('#MessagesContainer').animate({ top: '+=' + height + '' }, "fast", function () { $('#moreButtons').fadeIn(); });
        $('#BottomDiv').animate({ "margin-top": (height) + "px" }, "normal");
    }

    function HideMoreButtonsArea(height) {

        $('#moreButtons').hide();
        $('#MessagesContainer').animate({ top: '-=' + height + '' }, "fast");
        $('#BottomDiv').animate({ "margin-top": "0px" }, "normal");

    }


    function Yaniv(str) {
        return str.subsctring(0, 10);
    }

    $('textarea[maxlength]').keyup(function () {
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
                    $('#fuzz').css('z-index', '200');
                    $('.feedback-panel').animate({ left: '-' + feedbackTab.containerWidth }, feedbackTab.speed)
                    .removeClass('open');
                } else {
                    $('#fuzz').fadeIn();
                    $('#fuzz').css('z-index', '99');
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

        var url = siteUrl + "Handlers/SetFeedback.ashx";

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


    //send comment




});