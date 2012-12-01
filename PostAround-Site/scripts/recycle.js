--- static map in singlepost
<img src="http://maps.googleapis.com/maps/api/staticmap?center=<%=BigBoxLat %>,<%=BigBoxLon %>&zoom=15&size=319x218&maptype=roadmap&sensor=true&markers=icon:http://postaround.me/images/markers/image.png%7C<%=BigBoxLat %>,<%=BigBoxLon %>" />


--like button on box

<div class="product" style="float:left;">
        <fb:like href="<%=siteUrl %>post/${msgId}" layout="button_count"
        show_faces="false" width="60" height="20"
        action="like" colorscheme="light"></fb:like>
    </div>

--- select range
 //    $.fn.selectRange = function (start, end) {
    //        return this.each(function () {
    //            if (this.setSelectionRange) {
    //                this.focus();
    //                this.setSelectionRange(start, end);
    //            } else if (this.createTextRange) {
    //                var range = this.createTextRange();
    //                range.collapse(true);
    //                range.moveEnd('character', end);
    //                range.moveStart('character', start);
    //                range.select();
    //            }
    //        });
    //    };


----custom variable
            _gaq.push(['_setCustomVar',
                  1,                   // This custom var is set to slot #1.  Required parameter.
                  'Location',           // The top-level name for your online content categories.  Required parameter.
                  searchPhrase,  // Sets the value of "Section" to "Life & Style" for this particular aricle.  Required parameter.
                  3                    // Sets the scope to page-level.  Optional parameter.
            ]);

----address on message
<div id="Marker" title="Show address on map" ></div>

                    <div id="ShowOnMap" title="Show address on map" class="addr">${ReverseAddress(msgAddress)}</div>

-----locaion radio buttons
 <div id="Location" style="width:336px">
        <input type="radio" id="radio1" name="radio"  /><label for="radio1">Current Location</label>
		<input type="radio" id="radio2" name="radio"  /><label for="radio2">Other Location</label>
</div>


----------- xbutton for message
<div style="width:24px; height:24px; background:#eaeff1; border:1px solid #57849D; top:14px; right:10px; position:absolute">
             <div style="margin-right:7px; margin-top:3px; background: url('images/icons.png') repeat scroll -140px -143px; float: right;
             height: 14px; width: 11px;"></div>
             </div>

----------- search field
<div style="margin:0 auto; width:922px;  " id="SearchLocation">
      <div style=" clear:both; padding: 10px 25px 10px 20px; width:330px; float:left; color:#505050; font-family: Trebuchet MS, Arial; text-align:left; font-size:18px;">
        <span style="text-transform:uppercase; font-weight:bold; float:right;">type your address to get started</span>      
        <span style="color:#a6a6a6; font-style:italic; font-size:11px; float:right; margin-top:-4px;">e.g. <b>Xinhai Rd. Taipei, Taiwan</b></span>
        
      </div>
            
      
            <div class="PostBox" style="margin:2px">
        
            <div id="Links" class="TopLinks">
            
            <span style="margin-left:5px; margin-right:5px; display:none;">|</span>
            <span style="display:none">Show messages on map</span>
                    
            </div>
            <div class="Field">
                <div class="AutoDiscoverButton" id="AutoDiscover"></div>
                <div id="autoDiscoverText" style="display:none; position:absolute; width:383px; height:34px; margin:6px; margin-left:50px; background:#f78c1d url('images/btnBg.png') repeat-x; z-index:5; padding:1px; padding-left:45px; font-size:24px; font-style:italic; font-family:Calibri, Arial; color:#FFF "><b>On Wifi?</b> Click to Auto-Discover</div>
                <input type="text" maxlength="245" id="content" class="BlackText" placeholder="Street Address, City, State" />
                <div class="Search" title="Get Posts Around"  id="SearchBtn"></div>
            </div>
            <div class="TopLinks" style="margin-left:7px; display:none; font-weight:normal; float:left; font-size:11px; font-style:italic">
            
                <div id="wifiBubble" style="margin-top:3px; margin-right:2px; float:left; background:url('images/forwifi.png'); width:87px; height:26px;"></div>
            
            </div>



            
            
            <div id="AutoDiscoverBubble1" style="display:none; position:absolute;  margin-top:75px; margin-left:0px; background:url('images/bubble6.png') no-repeat; width:244px; height:45px;">
            <div style=" padding-top:7px; font-family:Calibri,Arial; padding-left:20px; font-style:italic; font-size:18px; color:#3a3a3a;">
            
            </div>
            </div>


            
        </div>
      </div>
-----------


    <p>
    PostAround is fun and easy way to share with your neighbors. <br />
    Know a good restarurant around? Need a ladder to borrow? Looking for a babysitter? Anything you want to share with your neighborhood? <br />
    Just post it around and find out what's good in your hood !


    
    </p>

function GetMessages1() {
    console.info("GetMessages:" + fromNumber);


    singleton = true;
    var isChanged = false;
    var applyChange = false;
    if (lastCall == null) {
        // first time that called - no need to use timing functions and state
        lastCall = InitLastCall();
        GetMessagesContinue();
    }
    else {
        // check if changed from last time - to ignore double call with same parameters
        isChanged = CheckGetMessageParamsChange();

        if (isChanged) {
            //check if slider change to set timing function
            var flag = SliderIsChanged();
            if (flag) {

                //set timeout to check if slider is changed again
                AssignAndSleep();

            } else {
                // if this is not the timer that changed - just get the messages
                GetMessagesContinue();
            }
        }


    }

    //        function AssignAndSleep() {
    //            
    //            Sleep();
    //        }






}


function GetMessagesContinue() {
    console.info("GetMessagesContinue:" + fromNumber);
    //GetMessagesOnReady();
    setTimeout(function () {
        if (GetGetMessagesState() == 0) {
            SetGetMessagesState(1);
            GetMessagesOnReady();
        }
        else {

            //setTimeout(function () {
            GetMessagesContinue();
            //}, 500);
        }

    }, 500);
}

function AssignAndSleep() {
    //assign
    currSliderValue = uptoMeters;
    // wait until there is no move for 0.5 second
    setTimeout(function () {
        if (currSliderValue == uptoMeters) {
            if (singleton) {
                console.info("GetMessages:" + fromNumber + " No Move");
                singleton = false; // to ignore slipped calls
                lastCall = InitLastCall();
                GetMessagesContinue();
            }
        }
        else {

            console.info("GetMessages:" + fromNumber + "--Has Moved");
            // if after 0.5 sec there was still change, wait and then re-call this function
            AssignAndSleep();

        }
    }, 500);

}




                <div class="Wrapper" style="display:none">
        <div id="WelcomeBubble" class="Bubble">
            <div id="bubbleText" class="BubbleText">
                <span style="float: left;"><b>Tip: </b>Start here by typing your address</span>
            </div>
        </div>

       <div class="Bubble" style="margin-left:217px">
            <div class="BubbleText">
                <span style="float: left;">On <b>WiFi?</b> click here for auto discover</span>
            </div>
        </div>
        </div>


        --LOGO

                <div style="width:273px; height:80px; background-color:#faf8f3; position:absolute; left:50%; margin-left:-136px;">
        <div style="width:2px; height:100%; background:url('images/separtor_vertical_white_brown.png') repeat-y; left:0; float:left"></div>
        <div style="width:269px; text-align:center; height:100%; background:url('images/logoBg.png') repeat-x; float:left;">
        
            <div class="LogoClear"><a href="<%=homePage %>"><img src="images/logoHead.png" title="Location Based Pinboard"  style="width:246px; height:43px; border:0" /></a></div>
            <div class="LogoText">Location Based Pinboard</div>
        
        
        </div>
        <div style="width:2px; height:100%; background:url('images/separtor_vertical_brown_white.png') repeat-y; float:left;"></div>
        </div>

        --LOGO END