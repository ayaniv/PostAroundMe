

$(document).ready(function() {
    
    
	var a = 1;    
    var myLat;
    var myLon;
    var results = window.data;
    var msgNumber = 0;
    var containersSize = [];
    var res1 = results;
	var currHeight;
    var currContainer;
	var numberOfColumns = 4;
	var itemsPerColumn = 4;
	mouse_is_inside=false; 
	ShowMessages();
	
    navigator.geolocation.getCurrentPosition(
		showPosition, errorCallback, {
				enableHighAccuracy: true, maximumAge:600000
				}
    );
    
    
        
    
    function errorCallback(error) {
		// Update a div element with error.message.
    }

    function showPosition(position) {
    
		myLat = position.coords.latitude;
		myLon = position.coords.longitude;

alert(myLat +","  + myLon);
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



    var hasValue = false;
    $("#content").focus(function()
    {
        if (hasValue == false)
            $(this).val('');
		$(this).animate({"height": "60px"}, "fast" );
		return false;
    });

    
    $("#content").blur(function()
    {
    if ($("#content").val() == '')
    {
        $("#content").animate({"height": "30px"}, "fast" );
        hasValue = false;
        $("#content").val('Share your post around...');
    }
    else
    {
        hasValue = true;
    }
    return false;
    });
    
    function getGap(element)
    {
		return calcDist(element.latitude, element.longitude, myLat, myLon) 
    }
    
    
     
    
    $( "#slider" ).slider({
			value:500,
			min: 0,
			max: 5000,
			step: 100,
			change: function( event, ui ) {
			    res1 =  jQuery.grep(results, function (a) { return /*(getGap(a)*/ a.Distance <= ui.value });
			    ShowMessages();
			},
			slide: function( event, ui ) {
				$( "#amount" ).val( ui.value + "m" );
			}
		});
		$( "#amount" ).val(  $( "#slider" ).slider( "value" ) + "m" );

    
    function ShowMessages()
    {
         var i = 0;
         var container = "#container"
		for (i=1; i<=numberOfColumns;i++)
		{
			$(container + i).empty();
		}		

        for (i=0; i<res1.length; i+= itemsPerColumn)
        {
            showColumn(i,res1);
        }
    }
    
    $("#FireButton").click(function () {
        $("#txtPopupDetails").val($("#content").val()),
        ShowAddMessageWindow();
     
     
      });
      
      $("#PostButton").click(function () {
      
        AddMessage();
        HideAddMessageWindow();
      });
    
    function AddMessage() {
        
        var myJSON = { "msgId":"" , 
                       "latitude": myLat ,
                       "longitude": myLon ,
                       "category": "brro",
                       "userid": "",
                       "Name":"Yaniv Aharon",
                       "title":$("#txtPopupTitle").val(),
                       "description": $("#txtPopupDetails").val(),
                       "image":"images/facebookAvatar.jpg",
                       "Date":"",
                       "Time":"",
                       "type": "",
                       "Distance":"0",
                       "CommentsNumber":"0"
                       };
                       
        AddItem(myJSON);
        
        
    }
    
    function AddItem(JsonItem)
    {
        data = data.reverse();
        data.push(JsonItem);
        data = data.reverse();
        res1 = data;
        ShowMessages();
    }
    
    function showColumn(startIndex, collection)
    {
        msgNumber++;
        var res2 = [];
        var i=0;
        var j=startIndex / numberOfColumns + 1;
        containersSize[j - 1] = -1 * itemsPerColumn; 
        
        for (i=startIndex; i< startIndex + itemsPerColumn && i < collection.length; i++)
        {
            res2.push(collection[i]);
            containersSize[j - 1] += 1;
        }
        var markup = unescape($("#TemplateBox").html());
        
        /* Compile markup string as a named template */
        $.template( "MessageTemplate", markup );
        var boxId = "newId" + msgNumber
        $("#BoxTest").attr("id",boxId);
        $( "#" + boxId).live('click', function(){  SetSize.apply(this); });
        //$("#BoxTest").live('click', function(){  SetSize.apply(this); });
        var tempName = "#container" + j;
        var d = new Date();
        var i = d.getTime();
        $(tempName).empty();
        $.tmpl( "MessageTemplate", res2).appendTo( tempName );
               
        
    }
    
    
    
    
	function SetSize()
	{
		
		if ($(this).css("height") == "130px") //close
		{
		
			$(this).animate({"height": "266px"}, "normal");
			$(this).find('.MoreInfo').fadeIn();
			$(this).find('#Comment').text("");
			$(this).find('#Comment').focus();
			
			currContainer = $(this).parents("div").attr('rel');
			if (currContainer != null)
				containersSize[currContainer] += 1;
			/*    
			currHeight = $(this).parents("div").height() + 133;
			if (currHeight > maxHeight)
			{
				$(this).parents("div").height(currHeight);
				$('#BottomDiv').animate({"margin-top": currHeight-maxHeight + "px"}, "normal");
				maxHeight = currHeight;
			}
			*/
			
			
			
				
			a = 2;
		}
		else //open
		{
			$(this).animate({"height": "130px"}, "normal");
			$(this).find('.MoreInfo').fadeOut();      
			
			if ($(this).find('#Comment').text() == "")
				$(this).find('#Comment').text("Write a comment...");
			a = 1;
			
			currContainer = $(this).parents("div").attr('rel');
			if (currContainer != null)
				containersSize[currContainer] -= 1;
			
		  /*
			currHeight = $(this).parents("div").height() - 133;
			if (maxHeight > currHeight)
			{
				$(this).parents("div").height(currHeight);
				$('#BottomDiv').animate({"margin-top": maxHeight-currHeight + "px"}, "normal");
				maxHeight = currHeight;
			}
		  */
			
		}
		
		
		currHeight = GetMaxValue(containersSize) * 133;
		$('#BottomDiv').animate({"margin-top": currHeight + "px"}, "normal");
		
		
	}
	
	//Adjust height of overlay to fill screen when page loads
    $("#fuzz").css("height", $(document).height());
    
    
    function HideAddMessageWindow()
    {
    
        $('#PopupBox').fadeOut();
        $('#fuzz').fadeOut();
    }
    
    $('#PopupBox').hover(function(){ 
        
        mouse_is_inside=true; 
        $('#xbutton').hover(function(){ 
        //debugger;
          mouse_is_inside=false; 
        })
    }, function(){ 
        mouse_is_inside=false; 
    });
    
    

    $("body").mouseup(function(){ 
        if(! mouse_is_inside)
        {
         HideAddMessageWindow()
        }
    });
      
    
    
    function ShowAddMessageWindow()
    {
        $('#PopupBox').fadeIn();
        $('#fuzz').fadeIn();
    }
    
    
    $(window).bind("resize", function(){
        $("#fuzz").css("height", $(window).height());
    });
    
    
        
	function GetMaxValue(collection)
	{
		if (collection == null)
			return 0;
		var max = collection[0];
		var i = 1;
		for(i = 1; i < collection.length; i++)
		{
			if (collection[i] > max)
				max = collection[i];
		}
		
		return max;
		
	}
	
	
	
	$("#LeftArrow").click(function () { 
        res1 =  jQuery.grep(results, function (a) { return  a.msgId <= 16 });
        ShowMessages();
});
	
	$("#RightArrow").click(function () { 
	
	    res1 =  jQuery.grep(results, function (a) { return  a.msgId > 16 });
        ShowMessages();
		
	});
	

	$(".CommercialBox").click(function () { 
	
		SetSize.apply(this);
	});

	$(".BoxTest").click(function () { 
	
		SetSize.apply(this);
	});
        
        
        
});