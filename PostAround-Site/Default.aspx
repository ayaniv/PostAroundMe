<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register src="Controls/HeadNew.ascx" tagname="Head" tagprefix="uc1" %>

<%@ Register src="Controls/Header3.ascx" tagname="Header" tagprefix="uc1" %>
<%@ Register src="Controls/AddPostContainer2.ascx" tagname="AddPost" tagprefix="uc1" %>
<%@ Register src="Controls/Footer2.ascx" tagname="Footer" tagprefix="uc1" %>
<%@ Register src="Controls/FeedbackPanel.ascx" tagname="Feedback" tagprefix="uc1" %>
<%@ Register src="Controls/BottomLoader.ascx" tagname="Loader" tagprefix="uc1" %>
<%@ Register src="Controls/ShowMap.ascx" tagname="ShowMap" tagprefix="uc1" %>
<%@ Register src="Controls/PopUp.ascx" tagname="PopUp" tagprefix="uc1" %>
<%@ Register src="Controls/FacebookInit.ascx" tagname="FacebookInit" tagprefix="uc1" %>
<%@ Register src="Controls/SocialLinks.ascx" tagname="SocialLinks" tagprefix="uc1" %>
<%@ Register src="Controls/MetaTags.ascx" tagname="MetaTags" tagprefix="uc1" %>




<%@ Import Namespace="System.Data" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://ogp.me/ns#" xmlns:fb="http://ogp.me/ns/fb#" xml:lang="en"  xmlns:addthis="http://www.addthis.com/help/api-spec">
<head runat="server">
    
    <uc1:Head runat="server" />
    
    

</head>
<body>



    <div id="mobileHeader" class="MobileContainer" style="display: none">

        <nav class="main-nav" id="main-nav">
          <a href="#">This</a>
          <a href="#">Little</a>
          <a href="#">Piggy</a>
          <a href="#">Went</a>
          <a href="#">To</a>
          <a href="#">Market</a>
        </nav>

        <div class="page-wrap">
            <div class="MobileTop">

                <div class="MobileSettings">
                    <div class="MobileSettingsLine"></div>
                    <div class="MobileSettingsLine"></div>
                    <div class="MobileSettingsLine"></div>
                </div>

                <div class="MobileLogo">
                    <img src="<%=siteUrl %>images/mobile_logo.png" />
                </div>


            </div>
            <div class="MobileTopSecondary">
                    <div class="Wrapper">
                    <div class="MobileTopSecondaryText" style="margin-left:13px;">My Posts</div>
                    <div class="MobileTopSecondaryText" style="margin-left:84px;">Current Location</div>
                    <div class="MobileTopSecondaryText" style="margin-left:123px;">Map</div>
                        </div>
                <div class="Selected"></div>
            </div>

            <div class="MobileLocation">
               Bitzaron 2, Tel Aviv
            </div>

            <div class="MobileBottom">
                <div class="Wrapper">
                <div class="MobileButton">
                    <div class="Entry">
                        <div class="AddPostIconBig"></div>
                        <div class="AddPostText">Add Post</div>
                    </div>
                </div>


                <div class="MobileBottomPas">
                    <div class="Line WhiteBlue"></div>
                    <div class="Line DarkBlue"></div>

                </div>
             
                <div class="MobileButton NoMargin" style="margin-top:15px  !important; margin-left:8px  !important;">
                    <div class="Entry">
                        <div class="AddPostText NoMargin">Everything</div>
                    </div>
               
                </div>

                 <div class="AddPostText NoMargin"  style="margin-top:32px !important; margin-left:5px !important; margin-right:5px !important;">Within</div>

                 <div class="MobileButton NoMargin" style="margin-top:15px !important;">
                    <div class="Entry">
                        <div class="AddPostText NoMargin">2km</div>
                    </div>
                     </div>

    </div>
            </div>
        </div>
    </div>

<uc1:MetaTags ID="MetaTags1" runat="server" />
<uc1:FacebookInit ID="FacebookInit1" runat="server" />





    <form id="form1" runat="server">
    
 
  
  <uc1:Feedback ID="FeedbackPanel" runat="server" />



    
    
    
    

 
    <uc1:Header ID="Header1" runat="server" />
    <uc1:AddPost ID="AddPost1" runat="server" />
   <uc1:ShowMap ID="ShowMap1" runat="server" />
   <uc1:PopUp ID="PopUp1" runat="server" />

  



                

        <div id="NoPostsText" style="display:none;  min-height:500px; text-align:center; color:#505050; position:relative; clear:both; top:0;  width:862px; margin:0 auto; padding:25px 30px;">
        <img id="TextLinkAddPost" style="cursor:pointer" src="<%=siteUrl %>images/yet.png">
        
        </div>

        <div id="MessagesContainer" class="Content">
        
        
        
        </div>
 
         <uc1:Loader ID="Loader1" runat="server" />
        


 
 <div id="fuzz" class="fuzz" style="filter:alpha(opacity=20); display:none">
</div>


<div id="PleaseLogin" class="LoginMessage CenterLoginMessage"></div>








        


 
    
    



    <uc1:Footer ID="Footer" runat="server" /> 

    
    
    
    <script id="TemplateCommentBig" type="text/x-jQuery-tmpl">
                            <div id="SingleCommentView" comment-id="${ID}">
                            <div class="SingleComment" >
                                <div id="commentImage" class="CommentImage">
                                    <img src="${avatarImageUrl}" />
                                </div>
                                
                                <div class="CommentWrapper">
                                
                                    {{if Mine}}
                                    <div id="HideComment" class="SmallXButton"></div>
                                    {{/if}}

                                    <div id="commentUserName">
                                        <a href="${commentUserLink}" target="_blank">${name}</a>
                                        <span id="CommentText" class="CommentText"  dir="${GetLanguageDirection(body)}"  style="direction:${GetLanguageDirection(body)}" >{{html FormatText(body)}}</span>
                                    </div>
                                    
                                    <div class="CommentDate">
                                        <span>${strDate}</span>
                                        <span class="CommentDateAt" data-i18n="messages.at"></span>
                                        <span>${strTime}</span>

                                    </div>
                                    <div class="PosterOnly" style="display:none;">
                                        <span data-i18n="messages.PosterOnly"></span>
                                        <span class="Locker"></span></div>
                                </div>

                            </div>
                            
                            <div class="EndLine" style="background-color:#e2ddcf;">&nbsp;</div>
                            <div class="EndLine" style="background-color:#fcfbf9;">&nbsp;</div>
                        </div>
    </script>
    


    <script id="TemplateComment" type="text/x-jQuery-tmpl">
                            <div id="SingleCommentView" comment-id="${ID}">
                            <div class="SingleComment" >
                                <div id="commentImage" class="CommentImage">
                                    <img src="${avatarImageUrl}" />
                                </div>
                                
                                <div class="CommentWrapper">
                                
                                    {{if Mine}}
                                    <div id="HideComment" class="SmallXButton"></div>
                                    {{/if}}

                                    <div id="commentUserName">
                                        <a href="${commentUserLink}" target="_blank">${name}</a>
                                        <span id="CommentText" class="CommentText"  dir="${GetLanguageDirection(body)}"  style="direction:${GetLanguageDirection(body)}" >{{html FormatText(body)}}</span>
                                    </div>
                                    
                                    <div class="CommentDate">
                                        <span>${strDate} </span>
                                        <span class="CommentDateAt" data-i18n="messages.at"></span>
                                         <span>${strTime}</span>

                                    </div>
                                    <div class="PosterOnly" style="display:none;">
                                        <span data-i18n="messages.PosterOnly"></span>
                                <span class="Locker"></span></div>
                                </div>

                            </div>
                            
                            <div class="EndLine" style="background-color:#e2ddcf;">&nbsp;</div>
                            <div class="EndLine" style="background-color:#fcfbf9;">&nbsp;</div>
                        </div>
    </script>

    <script id="TemplateBox" type="text/x-jQuery-tmpl">
    
    
             <div id="Box${msgId}" box-id="${msgId}" class="Box ${ClassName}" style="display:none">
             
             <div class="BoxBody">
                
                <div id="BoxLine" class="Line" color="${catColor}" style="background-color:${catColor}">
                </div>
                <div class="TextArea">
                <div class="CommentDash"></div>
                    <div class="BoxHead">
                
                <div class="FullAddress">
                <div class="Arrow"></div>       
                <div class="TextAddress">${msgAddress}</div>        
                </div>
                        <div>
                            <div class="BoxCategory">${TranslateCategory(category)}</div>
                            <div class="BoxLocation">
                            
                            <div class="SmallLocationIcon"></div>
                            <a href="<%=siteUrl %>post/${msgId}/${titleSlugged}" onclick="return false;" id="ShowOnMap" class="Word">{{html ShowDistance(Distance, msgAddress)}}</a>
                            
                            </div>
                        </div>
                            <a href="<%=siteUrl %>post/${msgId}/${titleSlugged}" onclick="return false;" id="LinkToPost" class="BoxHeader" style="direction:${GetLanguageDirection(title)}; text-align:${GetLanguageDirection(title)};">${title}</a>



                        
                            


                    </div>

                    <div class="BoxImage">
                    
                        {{if image}}
                        <div class="Border">


                        
                <a class="ImageBox" style="font-size:0" href="<%=siteUrl %>post/${msgId}/${titleSlugged}" onclick="return false;">
                <img src='<%=siteUrl %>UploadedResized/${image}' style="height:${ImageHeight}px;"  />
                </a>
            

                            
                        </div>
                        {{/if}}
                    
                    </div>

                <div class="Text" style="direction:${GetLanguageDirection(description)}">{{html FormatText(description)}}</div>
                
                <div style="margin-top:10px; display:none"">
                    
                    <div id="CurrLat" style="display:none">${latitude}</div>
                    <div id="CurrLng" style="display:none">${longitude}</div>
                    <div id="FullAddress" style="display:none">${msgAddress}</div>
                    <div id="FacebookID" style="display:none">${facebookID}</div>
                    <div id="UserID" style="display:none">${userid}</div>
                
                    
                
                </div>

                <div class="MessageName" style="position:relative">
                    <a href="${link}" target="_blank"><img src="${userImage}" class="UserAvatar" /></a> 
                    <span style="width:201px; padding-top:3px;  float:left; color:#d2d2d2; font-weight:bold" data-i18n="messages.posted_by"></span>
                    <a href="${link}" style="width:201px;"  target="_blank">${Name}</a>
                    <br />
                    

                    
                    <div style="height:22px; width:100%; padding-top:7px;" class="SharingArea">
                            <div class="ShareButton">
                                <span class="ShareIcon"></span>
                                <span class="totalShares">${totalShares}</span>
                                <span class="totalSharesLabel" data-i18n="messages.shares"></span>
                                <span class="totalViews">· ${totalViews} Views ·</span>
                                <span class="relativeDate">${Translate(relativeDate)}</span>
                            

                                        </div>

                                            <div class="SharingDiv">
                                            <div class="addthis_toolbox addthis_default_style " addthis:url="http://postaround.me/post/${msgId}">
                                            <div style="float:left; margin-top:2px;">
                                            <a class="addthis_button_preferred_1"></a>
                                                <a class="addthis_button_preferred_2"></a>
                                                 <a class="addthis_button_preferred_3"></a>
                                                 <a class="addthis_button_preferred_4"></a>
                                                <a class="addthis_button_preferred_5"></a>
                                            <a class="addthis_button_email"></a>
                                                

                                                </div>
                                                <a class="addthis_button_google_plusone"  <%="g:plusone:size"%>="medium" <%="g:plusone:count"%>="false"></a>
                                            <a class="addthis_button_facebook_like" <%="fb:like:layout"%>="button_count"></a>


                                            </div>
                                            </div>
                </div>
                </div>
                

                

                {{if Mine}}
                <div class="TransparentGrey OnPostButtons">
                <div id="EditPost" class="MyButton MineButton RightButton" data-i18n="messages.edit"></div>
                <div id="HidePost" class="MyButton MineButton LeftButton"  data-i18n="messages.remove"></div>
                </div>
                    
                {{/if}}
                
                </div>
                




             
                <div class="Bottom" id="CommentsArea">
 
                   
                    
                    <div id="currCommentsView" class="CommentsArea">

                        {{each comments}}
                         <div id="SingleCommentView" comment-id="${ID}">
                            
                                {{if isPrivate}}
                                <div class="SingleComment PrivateComment" >
                                {{else}}
                                <div class="SingleComment" >
                                {{/if}}
                                
                                <div id="commentImage" class="CommentImage">
                                    <img src="${avatarImageUrl}" />
                                </div>
                                
                                <div class="CommentWrapper">
                                
                                    {{if Mine}}
                                    <div id="HideComment" class="SmallXButton"></div>
                                    {{/if}}

                                    <div id="commentUserName">
                                        <a href="${commentUserLink}" target="_blank">${name}</a>
                                        <span id="CommentText" class="CommentText" dir="${GetLanguageDirection(body)}" style="direction:${GetLanguageDirection(body)}" >{{html FormatText(body)}}</span>
                                    </div>
                                    
                                    <div class="CommentDate">
                                        <span>${strDate}</span>
                                        <span class="CommentDateAt" data-i18n="messages.at"></span>
                                        <span>${strTime}</span>

                                    </div>
                                    {{if isPrivate}}
                                    <div class="PosterOnly">
                                    <span data-i18n="messages.PosterOnly"></span>
                                        <span class="Locker"></span>

                                    </div>
                                    {{/if}}
                                    

                                </div>

                            </div>
                            
                            <div class="EndLine" style="background-color:#e2ddcf;">&nbsp;</div>
                            <div class="EndLine" style="background-color:#fcfbf9;">&nbsp;</div>
                        </div>
                        {{/each}}

                    </div>
                    
                    <div class="AddComment"  style="float:left;">
                        
                        
                        
                        <textarea maxlength="500" id="Comment" data-i18n="[placeholder]messages.post_comment"></textarea>
                        
                        <div class="Buttons">
                        <div style="position:absolute; left:0; float:left;">
                            
                            {{if !Mine}}
                            <div class="slider-frame">
                                <span data-i18n="[title]messages.public_whatis" class="slider-button"><span class="PublicIcon PublicIconOn"></span><span data-i18n="messages.public"></span></span>
                                <span data-i18n="[title]messages.private_whatis" class="slider-button-off"><span class="PrivateIcon"></span><span data-i18n="messages.private"></span></span>
                            </div>
                            {{/if}}

                        </div>

     
                        <div class="Orange">
                        <div id="BtnPostComment" class="MyButton" data-i18n="post.post;[title]messages.post_comment" style="float:right; padding:2px 12px 2px 12px;"></div>
                        </div>
                        </div>
                    </div>
                </div>
                
                </div>
                <div style="width:273px; height:10px; float:left;"></div><!-- background:url('images/boxShadow.png') no-repeat;  -->
            </div>
            
            
            
    </script>

 

<script type="text/javascript">




    function GetLengh(array) {
        if (array == null)
            return 0;
        return array.length;
    }

    function addCommas(nStr) {
        nStr += '';
        x = nStr.split('.');
        x1 = x[0];
        x2 = x.length > 1 ? '.' + x[1] : '';
        var rgx = /(\d+)(\d{3})/;
        while (rgx.test(x1)) {
            x1 = x1.replace(rgx, '$1' + ',' + '$2');
        }
        return x1 + x2;
    }


    function FormatText(text) {
        text = Linkify(text);
        text = text.ReplaceAll('\n', '<br/>');
        return text;

    }

    function FormatWord(meters) {
        var retVal = "meters";
        if (meters < 0) {
            if (meters == -2) {
                retVal = ""
            }

        }
        else if (meters >= 1000)
            retVal = "km"

        return retVal;


    }

    function ShowDistance(meters, address) {
        var retVal = "";
        var distance = "";
        if (meters == -2) {
            retVal = i18n.t("messages.posted_here");
        }
        else {
            if (meters == -1) {

            retVal = "<b>" + GetStatefromAddress(address, meters) + "</b>";
            } else
                if (meters > 1000) {
                    distance = Math.round(meters / 1000) + " " + i18n.t("header.KM");
                }
                else {
                    distance = meters + " " + i18n.t("messages.m");
                }
        }

        if (retVal == "") {
            retVal =  distance + " "  + i18n.t("messages.around");
        }

        return retVal;


    }

    function SetHeight(src) {
        
        var img = new Image();
        img.src = siteUrl + "/" + src;
        var result = "height:[Height]px"
        return result.replace("[Height]", img.height);
    }

    function GetStatefromAddress(str, meters) {

        var newstring = "";
        if ((str != null) && (str != "")) {

            var wordsArray = str.split(',');
            switch (wordsArray.length) {
                case 1:
                    newstring = TruncString(wordsArray[0], 10);
                    break;
                case 2: // tel aviv, israel
                    newstring = TruncString(wordsArray[wordsArray.length - 1], 15);
                    break;
                case 3: // truman, tel aviv, israel
                    newstring = TruncString(wordsArray[wordsArray.length - 2], 15);
                    break;
                case 4: // 565 Hyannis Dr, Sunnyvale, CA 94087, USA
                    newstring = TruncString(wordsArray[wordsArray.length - 3], 15);
                    break;
                default:
                    newstring = TruncString(wordsArray[wordsArray.length - 2], 15);
            }
                
 

        }
        return newstring;

    }

    function ReverseAddress(str) {
        
        var newstring = "";
        if ((str != null) && (str != "")) {
            
            var wordsArray = str.split(',');
            for (var i = wordsArray.length - 1; i >= 0; i--) {
                newstring += wordsArray[i];
                if (i > 0)
                    newstring += ", ";
            }

        }
        return newstring;
    }

    function TruncString(str, length) {
        if (str != null) {
            if (str.length > length)
                str = str.substring(0, length-3) + "..."
        }
        return str;
    }

    function checkRTL(s) {
        var ltrChars = 'A-Za-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02B8\u0300-\u0590\u0800-\u1FFF' + '\u2C00-\uFB1C\uFDFE-\uFE6F\uFEFD-\uFFFF',
            rtlChars = '\u0591-\u07FF\uFB1D-\uFDFD\uFE70-\uFEFC',
            rtlDirCheck = new RegExp('^[^' + ltrChars + ']*[' + rtlChars + ']');

        return rtlDirCheck.test(s);
    };

    function TranslateCategory(str) {
        str = str.ReplaceAll(" ", "").ReplaceAll("&", "").ReplaceAll("/", "").ReplaceAll("\\", "");
        var lookupValue = "categories." + str
        return i18n.t(lookupValue);
    }


    function Translate(date) {
        var retVal = null;
        var array = date.split('#');
        var lookupValue = "dates.";
        if (array.length > 1)
        {
            if (array[0] == 2 && array[1] == "YearsAgo") {
                lookupValue += "TwoYearsAgo"
                retVal = i18n.t(lookupValue);
            } else if (array[0] == 2 && array[1] == "DaysAgo") {
                lookupValue += "TwoDays"
                retVal = i18n.t(lookupValue);
            } else {
                lookupValue += array[1];
                retVal = array[0] + " " + i18n.t(lookupValue);
            }
            
        } else {
            lookupValue += array[0];
            retVal = i18n.t(lookupValue)
        }
        return retVal;
    }


    function GetLanguageDirection(selector) {
        var string = selector;
        for (var i = 0; i < string.length; i++) {
            var isRTL = checkRTL(string[i]);
            var dir = isRTL ? 'RTL' : 'LTR';
            if (dir === 'RTL') var finalDirection = 'RTL';
            if (finalDirection == 'RTL') dir = 'RTL';
        }
        
        if (dir == 'LTR') {
            return "ltr";
        } else {
            return "rtl";
        }
    }


    function GetLanguageAlign(str) {
        var direction = GetLanguageDirection(str);
        if (direction == "rtl")
            return "right";
        return "left"


    }



</script>

    
    <script type="text/javascript" src="https://apis.google.com/js/plusone.js">
    {"parsetags": "explicit"}
    
    
</script>
    
    <link rel="canonical" href="<%=siteUrl %>" />
    

    

    
    
    
    </form>
</body>
</html>

