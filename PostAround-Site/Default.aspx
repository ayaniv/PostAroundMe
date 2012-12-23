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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://ogp.me/ns#" xmlns:fb="http://ogp.me/ns/fb#" xml:lang="en">
<head runat="server">
    <title>Post Around Me | Local Pinboard</title>
    <uc1:Head runat="server" />
    
    

</head>
<body>
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

        


 
    
    



    <uc1:Footer ID="Footer" runat="server" /> 

    
    
    
    <script id="TemplateCommentBig" type="text/x-jQuery-tmpl">
                            <div id="SingleCommentView" comment-id="${ID}">
                            <div class="SingleComment" style="width:503px" >
                                <div id="commentImage" class="CommentImage">
                                    <img src="${avatarImageUrl}" />
                                </div>
                                
                                <div class="CommentWrapper" style="width:476px">
                                
                                    {{if Mine}}
                                    <div id="HideComment"></div>
                                    {{/if}}

                                    <div id="commentUserName">
                                        <a href="${commentUserLink}" target="_blank">${name}</a>
                                    </div>
                                    <div id="CommentText" class="CommentText" style="direction:${GetLanguageDirection(body)}" >{{html FormatText(body)}}</div>
                                    <div class="CommentDate">${strDate} at ${strTime}</div>

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
                                    <div id="HideComment"></div>
                                    {{/if}}

                                    <div id="commentUserName">
                                        <a href="${commentUserLink}" target="_blank">${name}</a>
                                    </div>
                                    <div id="CommentText" class="CommentText" style="direction:${GetLanguageDirection(body)}" >{{html FormatText(body)}}</div>
                                    <div class="CommentDate">${strDate} at ${strTime}</div>

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
                            <div class="BoxCategory" style="color:#a3a3a3">${category}</div>
                            <div style="float:right" id="locationWrapper">
                            
                            <div id="Marker"></div>
                            <a href="<%=siteUrl %>post/${msgId}" onclick="return false;" id="ShowOnMap" class="Word">{{html ShowDistance(Distance, msgAddress)}}</a>
                            
                            </div>
                        </div>
                            <div class="BoxHeader" style="direction:${GetLanguageDirection(title)}; text-align:left">${title}</div>



                        
                            


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
                
                    
                
                </div>

                <div class="MessageName">
                    <a href="${link}" target="_blank"><img src="${userImage}" style="border:0; float:left; width:45px; height:45px; margin-right:6px" /></a> 
                    <a href="${link}" target="_blank">${Name}</a>
                    <br />
                    <span style="clear:both">Posted on ${Date} at ${Time}</span>
                    <br />
                    <a href="<%=siteUrl %>post/${msgId}" onclick="return false;" class="zoomIn">Link</a> · <span>${GetLengh(comments)}</span> comments

                </div>
                

                

                {{if Mine}}
                <div id="EditPost" class="MineButton">Edit</div>
                <div id="HidePost" class="MineButton">Hide</div>
                    
                {{/if}}
                
                </div>
                




             
                <div class="Bottom" id="CommentsArea">
 
                    <div class="BottomLine"></div>
                    
                    <div id="currCommentsView" class="CommentsArea">

                        {{each comments}}
                         <div id="SingleCommentView" comment-id="${ID}">
                            <div class="SingleComment" >
                                <div id="commentImage" class="CommentImage">
                                    <img src="${avatarImageUrl}" />
                                </div>
                                
                                <div class="CommentWrapper">
                                
                                    {{if Mine}}
                                    <div id="HideComment"></div>
                                    {{/if}}

                                    <div id="commentUserName">
                                        <a href="${commentUserLink}" target="_blank">${name}</a>
                                    </div>
                                    <div id="CommentText" class="CommentText" style="direction:${GetLanguageDirection(body)}" >{{html FormatText(body)}}</div>
                                    <div class="CommentDate">${strDate} at ${strTime}</div>

                                </div>

                            </div>
                            
                            <div class="EndLine" style="background-color:#e2ddcf;">&nbsp;</div>
                            <div class="EndLine" style="background-color:#fcfbf9;">&nbsp;</div>
                        </div>
                        {{/each}}

                    </div>
                    
                    <div class="AddComment"><textarea  maxlength="500" id="Comment" cols"1" rows="1" placeholder="Write a comment...">Write a comment...</textarea></div>
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
        if ((str.charCodeAt(0) > 0x590) && (str.charCodeAt(0) < 0x5FF))
            direction = "rtl";

        //arabic
        else if ((str.charCodeAt(0) > 0x600) && (str.charCodeAt(0) < 0x6FF))
            direction = "rtl";

        return direction;

    }



</script>

    
    <script type="text/javascript" src="https://apis.google.com/js/plusone.js">
    {"parsetags": "explicit"}
    
    
</script>
    
    <link rel="canonical" href="<%=siteUrl %>" />
    
    

    
    
    
    </form>
</body>
</html>

