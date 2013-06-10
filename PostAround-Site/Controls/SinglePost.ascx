<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SinglePost.ascx.cs" Inherits="Controls_SinglePost" %>

<%@ Register src="AddThis.ascx" tagname="AddThis" tagprefix="uc1" %>


<%@ Import Namespace="PostAround.Entities" %> 



<div id="MessagesContainer" class="BigBoxContainer" style="position:relative; float:left;">
                <!-- AddThis Button BEGIN -->
<div class="addthis_toolbox_page addthis_toolbox addthis_floating_style addthis_32x32_style">
<a class="addthis_button_facebook"></a>
<a class="addthis_button_twitter"></a>
<a class="addthis_button_google_plusone_share"></a>
<a class="addthis_button_pinterest_share"></a>
<a class="addthis_button_gmail"></a>
<a class="addthis_button_email"></a>
</div>



<!-- AddThis Button END -->

<div id="BigBoxContainer" box-lat="<%=BigBoxLat %>" box-lon="<%=BigBoxLon %>" box-fuid="">






    



<div class="Line" style="background-color:<%=bigBoxLineColor %> ; width:640px; "></div>
<div id="BigBoxWrapper" class="Box" box-id="<%=msgId %>" style="width:610px; min-height:800px; padding:15px; background-color:#FFF; float:left;">
    <div id="FacebookID" style="display:none"><%=facebookID %></div>         
    <div id="BigBoxLeft" style="width:100%; float:left;">

        <div style="margin-bottom:10px; float:left; width:100%">
      


         <a style="color:#808080; float:right; font-size:14px;" target="_blank" href="<%=mapUrl %>">Get Directions</a>
           
         <div id="BigBoxAddress" style="font-size:12px; float:left; width:500px;">
        <div style="float:left;">
        
        <img src="<%=siteUrl %>images/markers/image.png" style="width:12px; height:15px;" /></div>
        <div style="margin-left:18px; font-size:14px;">
             <span style="font-family:Tahoma; color:#6AA1BB">Posted around</span> 
            <a href="<%=siteUrl %>ll/<%=BigBoxLat %>,<%=BigBoxLon %>" style="font-weight:bold" title="See more posts around here"><asp:Literal runat="server" ID="ltrlAddress"></asp:Literal></a>

        </div>
        
        </div>
            </div>
          

        <div id="map_canvas1" style="width:610px; clear:both; background-color:#EAEDEE; height:200px;">
        
        
        </div>
         
        

        
                <div style="clear:both; margin-top:10px;font-size:14px; color:#3b3b3d; float:left;"><asp:Literal ID="ltrlCategory" runat="server"></asp:Literal></div>  
       <div style="float:right; text-transform:uppercase; word-break:break-word; color:#3b3b3d; font-size:24px; margin-top:10px;  "><asp:Literal ID="ltrlTitle" runat="server"></asp:Literal></div>
        
                <div id="BigBoxMedia" class="BigBoxMedia" style="clear:both; margin-bottom:10px; width:610px; text-align:center">
        <asp:Literal ID="ltrlMedia" runat="server"></asp:Literal>
        </div>

                <div id="BigBoxText" class="BigBoxText" style="float:<%=alignDescription %>; margin-bottom:10px; direction:<%=directionDescription%>;">
        <asp:Literal ID="ltrlText" runat="server"></asp:Literal>
        </div>     
        



                <div id="BigBoxHeader" style="width:100%; clear:both;height:50px; ">
            <div id="BigBoxUserImage" runat="server" style="width:50px; height:50px; float:left;">
            <asp:Literal runat="server" ID="ltrlUserImage"></asp:Literal>
            </div>
            <div id="BigBoxUserName" style="padding-top:15px; float:left; padding-left:10px">
                <div style="clear:both; font-size:14px; color:#3b3b3d">Posted By&nbsp;<span style="font-weight:bold"><asp:Literal ID="ltrlName" runat="server"></asp:Literal></span></div>
                <div id="BigBoxDate" style="clear:both; font-size:12px; color:#888888"><asp:Literal ID="ltrlDate" runat="server"></asp:Literal></div>
                <div style="float:left; display:none; font-size:12px; color:#888888"><asp:Literal ID="ltrlAddressUser" runat="server"></asp:Literal>
                  

                </div>
            </div>
            
        
        </div>

      



                <div id="BigBoxComments" style="margin-top:10px;">
        
         <div class="Bottom" id="CommentsArea" style="width:100%">
 
                    <div class="BottomLine"></div>
                    

                        <asp:Repeater ID="rptComments" runat="server">

                        <HeaderTemplate>
                    <div id="currCommentsView" class="CommentsArea">

                        </HeaderTemplate>
                        <ItemTemplate>
                        

                         <div id="SingleCommentView" comment-id="<%#  ((Comment)Container.DataItem).ID %>">
                            <div class="SingleComment <%# ((Comment)Container.DataItem).isPrivate ? "PrivateComment" : ""  %>" >
                                <div id="commentImage" class="CommentImage">
                                <asp:Literal ID="cmtUserImage" runat="server"></asp:Literal>
                                    
                                </div>
                                
                                <div class="CommentWrapper">
                                

                                    
                                    <asp:Literal runat="server" ID="ltrlCommentXButton"></asp:Literal>
                                    

                                    <div id="commentUserName">
                                        <asp:Literal ID="cmtUserName" runat="server"></asp:Literal>
                                                                    <span id="CommentText" class="CommentText" runat="server" >
                                    <asp:Literal ID="cmtBody" runat="server"></asp:Literal>
                                    </span>
                                    </div>
        
                                    <div class="CommentDate">
                                    <asp:Literal ID="cmtDate" runat="server"></asp:Literal>
                                    </div>
                                    <%# ((Comment)Container.DataItem).isPrivate ? @"<div class=""PosterOnly"">· Poster Only&nbsp;·&nbsp;<span class=""Locker""></span></div>" : ""  %>
                                    
                                    
                                    

                                </div>

                            </div>
                            
                            <div class="EndLine" style="background-color:#e2ddcf;">&nbsp;</div>
                            <div class="EndLine" style="background-color:#fcfbf9;">&nbsp;</div>
                        </div>
                        </ItemTemplate>

                        <FooterTemplate>
                        </div>
                        </FooterTemplate>
                        
                        </asp:Repeater>

                    
                    <asp:Panel runat="server" ID="AddCommentPanel">
                        <div class="AddComment" style="margin-top:0">
                            <textarea style="width:572px; height:50px;" placeholder="Post a comment..."  maxlength="500" id="Comment" cols"1" rows="1">Post a comment...</textarea>

                            <div class="Buttons">
                            <div style="position:absolute; left:0; float:left;">
                            
                                <asp:Literal runat="server" ID="ltrlButtons"></asp:Literal>
 


                            </div>

     
                            <div class="Orange">
                            <div id="BtnPostComment" class="MyButton" title="Post Comment" style="float:right; padding:2px 12px 2px 12px;">Post</div>
                            </div>
                            </div>

                        </div>
                    </asp:Panel>

                </div>

        </div>

    </div>

    <div id="BigBoxRight" style="width:533px;  margin-left:10px; float:right;">





    </div>

</div>





</div>



</div>






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
                                        <span id="CommentText" class="CommentText" dir="${GetLanguageDirection(body)}" style="direction:${GetLanguageDirection(body)}" >${body}</span>
                                    </div>
                                    
                                    <div class="CommentDate">${strDate} at ${strTime}</div>

                                </div>

                            </div>
                            
                            <div class="EndLine" style="background-color:#e2ddcf;">&nbsp;</div>
                            <div class="EndLine" style="background-color:#fcfbf9;">&nbsp;</div>
                        </div>
    </script>
    

 
            
<script type="text/javascript">
 
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


</script>  