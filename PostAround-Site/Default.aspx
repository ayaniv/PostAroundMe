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
    <title>Post Around Me | Local Pinboard</title>
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
                    <img src="images/mobile_logo.png" />
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
        <img id="TextLinkAddPost" style="cursor:pointer" src="images/yet.png">
        
        </div>

 
        <div id="MessagesContainer" class="Content">
        
        
        
        </div>
 
         <uc1:Loader ID="Loader1" runat="server" />
        


 
 <div id="fuzz" class="fuzz" style="filter:alpha(opacity=20); display:none">
</div>


<div id="PleaseLogin" style="display:none; float:left; border:6px solid #fff; border-right:8px solid #FFF; z-index:10001; background-color:#FFF; width:320px; top:25%; left:50%; margin-left:-160px; position:fixed;
box-shadow: 0px 6px 6px #666; -moz-box-shadow: 0px 6px 6px #666; -webkit-box-shadow: 0px 6px 6px #666; 

 ">
	
</div>







        


 
    
    



    <uc1:Footer ID="Footer" runat="server" /> 

    
    
    
    <script id="TemplateCommentBig" type="text/x-jQuery-tmpl">
                            <div id="SingleCommentView" comment-id="${ID}">
                            <div class="SingleComment" style="width:503px" >
                                <div id="commentImage" class="CommentImage">
                                    <img src="${avatarImageUrl}" />
                                </div>
                                
                                <div class="CommentWrapper" style="width:476px">
                                
                                    {{if Mine}}
                                    <div id="HideComment" class="SmallXButton"></div>
                                    {{/if}}

                                    <div id="commentUserName">
                                        <a href="${commentUserLink}" target="_blank">${name}</a>
                                    </div>
                                    <div id="CommentText" class="CommentText" style="direction:${GetLanguageDirection(body)}" >{{html FormatText(body)}}</div>
                                    <div class="CommentDate">${strDate} at ${strTime}</div>
                                    <div class="CommentDate PosterOnly" style="display:none;">· Poster Only&nbsp;·&nbsp;<span class="Locker"></span></div>
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
                                    </div>
                                    <div id="CommentText" class="CommentText" style="direction:${GetLanguageDirection(body)}" >{{html FormatText(body)}}</div>
                                    <div class="CommentDate">${strDate} at ${strTime}</div>
                                    <div class="CommentDate PosterOnly" style="display:none;">· Poster Only&nbsp;·&nbsp;<span class="Locker"></span></div>
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
                
                    <div class="BoxHead">
                
                <div class="FullAddress">
                <div class="Arrow"></div>       
                <div class="TextAddress">${msgAddress}</div>        
                </div>
                        <div>
                            <div class="BoxCategory">${category}</div>
                            <div class="BoxLocation">
                            
                            <div id="Marker"></div>
                            <a href="<%=siteUrl %>post/${msgId}" onclick="return false;" id="ShowOnMap" class="Word">{{html ShowDistance(Distance, msgAddress)}}</a>
                            
                            </div>
                        </div>
                            <div class="BoxHeader" style="direction:${GetLanguageDirection(title)}; text-align:${GetLanguageDirection(title)};">${title}</div>



                        
                            


                    </div>

                    <div class="BoxImage">
                    
                        {{if image}}
                        <div class="Border">


                        
                <a class="ImageBox" style="font-size:0" href="<%=siteUrl %>post/${msgId}" onclick="return false;">
                <img src='<%=siteUrl %>UploadedResized/${image}' style="height:${ImageHeight}px;"  />
                </a>
            

                            
                        </div>
                        {{/if}}
                    
                    </div>

                <div class="Text" style="direction:${GetLanguageDirection(description)}">{{html FormatText(description)}}</div>
                
                <div class="MessageName" style="margin-top:10px;">
                    
                    <div id="CurrLat" style="display:none">${latitude}</div>
                    <div id="CurrLng" style="display:none">${longitude}</div>
                    <div id="FullAddress" style="display:none">${msgAddress}</div>
                    <div id="FacebookID" style="display:none">${facebookID}</div>
                    <div id="UserID" style="display:none">${userid}</div>
                
                    
                
                </div>

                <div class="MessageName">
                    <a href="${link}" target="_blank"><img src="${userImage}" style="border:0; float:left; width:45px; height:45px; margin-right:6px" /></a> 
                    <a href="${link}" target="_blank" style="float:left; margin-top:-2px">${Name}</a>
                    <br />
                    <span style="float:left; margin-top:-2px;">Posted on ${Date}</span>
                    <br />
                    

                    
                    <div style="height:22px" class="SharingArea">
                            <div class="ShareButton" style="width:192px; background-color:#FFF; height:22px; font-size:13px; font-family:Tahoma, Verdana, Arial;  color:#666; float:left;">
                                <span class="ShareIcon"></span>
                                <span style="margin-left:4px; font-weight:bold; float:left;">${totalShares}</span>
                                <span style="margin-left:4px; float:left; text-transform:uppercase">Shares</span>
                            

                                        </div>

                                            <div class="SharingDiv">
                                            <div class="addthis_toolbox addthis_default_style " addthis:url="http://postaround.me/post/${msgId}">
                                            <div style="float:left; margin-top:2px;">
                                            <a class="addthis_button_preferred_1"></a>
                                                <a class="addthis_button_preferred_2"></a>
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
                <div id="EditPost" class="MyButton MineButton RightButton">Edit</div>
                <div id="HidePost" class="MyButton MineButton LeftButton">Remove</div>
                </div>
                    
                {{/if}}
                
                </div>
                




             
                <div class="Bottom" id="CommentsArea">
 
                    <div class="BottomLine"></div>
                    
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
                                    </div>
                                    <div id="CommentText" class="CommentText" style="direction:${GetLanguageDirection(body)}" ><span>{{html FormatText(body)}}</span></div>
                                    <div class="CommentDate">${strDate} at ${strTime}</div>
                                    {{if isPrivate}}
                                    <div class="CommentDate PosterOnly">· Poster Only&nbsp;·&nbsp;<span class="Locker"></span></div>
                                    {{/if}}
                                    

                                </div>

                            </div>
                            
                            <div class="EndLine" style="background-color:#e2ddcf;">&nbsp;</div>
                            <div class="EndLine" style="background-color:#fcfbf9;">&nbsp;</div>
                        </div>
                        {{/each}}

                    </div>
                    
                    <div class="AddComment"  style="float:left;">
                        
                        
                        
                        <textarea maxlength="500" id="Comment" placeholder="Post a comment...">Post a comment...</textarea>
                        
                        <div class="Buttons">
                        <div style="position:absolute; left:0; float:left;">
                            
                            {{if !Mine}}
                            <div class="slider-frame">
                                <span class="slider-button"><span class="PublicIcon PublicIconOn"></span>Public</span>
                                <span class="slider-button-off"><span class="PrivateIcon"></span>Private</span>
                            </div>
                            {{/if}}

                        </div>

     
                        <div class="Orange">
                        <div id="BtnPostComment" class="MyButton" title="Post Comment" style="float:right; padding:2px 12px 2px 12px;">Post</div>
                        </div>
                        </div>
                    </div>
                </div>
                
                </div>
                <div style="background:url('images/boxShadow.png') no-repeat; width:273px; height:10px; float:left;"></div>
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

    function FormatNumber(meters) {
        var retVal = "";
        if (meters < 0) {
            if (meters == -2) {
                retVal = "Here"
            }
            if (meters == -1)
                retVal = "N/A";
        }
        else if (meters < 1000)
            retVal = meters;
        else
            retVal = addCommas(Math.round(meters / 1000));

        return retVal;


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
            retVal = "posted <b>Here</b>"
        }
        else {
            if (meters == -1) {

            retVal = "around <b>" + GetStatefromAddress(address, meters) + "</b>";
            } else
                if (meters > 1000) {
                    distance = Math.round(meters / 1000) + "KM";
                }
                else {
                    distance = meters + "m";
                }
        }

        if (retVal == "") {
            retVal = "<b>" + distance +  "</b> around";
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

    function GetLanguageDirection(str) {
        
        //english
        var direction = "ltr"

        str = str.replace(/[0-9]/g, '');
        str = str.trim();

        //hebrew
        if ((str != "") &&  (str.charCodeAt(0) > 0x590) && (str.charCodeAt(0) < 0x5FF))
            direction = "rtl";

        //arabic
        else if ((str != "") && (str.charCodeAt(0) > 0x600) && (str.charCodeAt(0) < 0x6FF))
            direction = "rtl";

        return direction;

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

