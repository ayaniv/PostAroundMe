<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SinglePost.ascx.cs" Inherits="Controls_SinglePost" %>

<%@ Register src="AddThis.ascx" tagname="AddThis" tagprefix="uc1" %>

<%@ Register src="FacebookLike.ascx" tagname="FacebookLike" tagprefix="uc1" %>
<%@ Register src="GooglePlus.ascx" tagname="GooglePlus" tagprefix="uc1" %>

<%@ Import Namespace="PostAround.Entities" %> 


    



<div id="MessagesContainer">
<div id="BigBoxContainer" box-lat="<%=BigBoxLat %>" box-lon="<%=BigBoxLon %>">


<script type="text/javascript" src="https://apis.google.com/js/plusone.js">
{"parsetags": "explicit"}
</script>

<link rel="canonical" href="<%=pageUrl %>" />    
    <script type="text/javascript">
        FB.XFBML.parse();
        gapi.plusone.go('GplusContainer', { "size": "medium" });

        

    </script>

<div class="Line" style="background-color:<%=bigBoxLineColor %> ; width:895px; "></div>
<div id="BigBoxWrapper" class="Box" box-id="<%=msgId %>" style="width:865px; padding:15px; background-color:#FFF; float:left;">
                     
    <div id="BigBoxLeft" style="width:319px; float:left;">

        <div id="map_canvas1" style="width:319px; background-color:#EAEDEE; height:256px;">
        
        
        </div>
        <div id="BigBoxAddress" style="background-color:#f4f2ee; margin-top:10px; width:307px; color:#333; font-size:14px; padding: 3px 6px 6px 6px;">
        <div style="float:left;">
        
        <img src="<%=homePage %>images/markers/image.png" style="width:12px; height:15px; margin:0 6px 0 6px;" /></div>
        <div style="margin-left:24px"><a href="<%=mapUrl %>" target="_blank" title="Open Google Map"><asp:Literal runat="server" ID="ltrlAddress"></asp:Literal></a></div>
        
        </div>
        <div class="GeneralLink" style="background-color:#f4f2ee; margin-top:3px; width:307px; color:#6AA1BB; font-size:14px; padding: 3px 6px 6px 6px;"><img src="<%=homePage %>images/pin3.png" style="width:13px; height:14px; margin:0 6px 0 6px;" /><a href="<%=homePage %>?lat=<%=BigBoxLat %>&lon=<%=BigBoxLon %>">See more posts around this location</a></div>
        <div id="BigBoxSocial" style="margin-top:10px; width:100%; height:20px">
        <%--<div style="float:left; width:155px; margin-top:2px;">
        <uc1:AddThis ID="AddThis1" runat="server" />
        </div>--%>
        <div id="socialLinksPopUp" style="float:left;  width:160px;">
        



     


           <div id="GplusPopUp" style="float:right; width:60px;  height:20px;">
           <div id="GplusContainer">
                <uc1:GooglePlus ID="GooglePlus" runat="server" /> 
                </div>
            </div>


                       <div id="FBPopUp" style="float:right; width:100px; height:20px;">
                <uc1:FacebookLike ID="FacebookLike" runat="server" />
            </div>



        </div>
        </div>
        


    </div>

    <div id="BigBoxRight" style="width:533px;  margin-left:10px; float:right;">
        <div id="BigBoxHeader" style="width:100%; height:50px; ">
            <div id="BigBoxUserImage" runat="server" style="background-color:#EAEDEE; width:50px; height:50px; float:left;">
            <asp:Literal runat="server" ID="ltrlUserImage"></asp:Literal>
            </div>
            <div id="BigBoxUserName" style="padding-top:10px; height:40px; float:left; padding-left:10px">
                <div style="clear:both; font-size:14px; font-weight:bold; color:#3b3b3d"><asp:Literal ID="ltrlName" runat="server"></asp:Literal></div>
                <div id="BigBoxDate" style="clear:both; font-size:12px; color:#888888"><asp:Literal ID="ltrlDate" runat="server"></asp:Literal></div>
            </div>
            <div style="float:right;">
                <div style="clear:both; font-size:14px; color:#3b3b3d; float:right;"><asp:Literal ID="ltrlCategory" runat="server"></asp:Literal></div>
                <div style="clear:both; direction:<%=directionTitle %>; text-transform:uppercase; color:#3b3b3d; font-size:24px;  float:right;"><asp:Literal ID="ltrlTitle" runat="server"></asp:Literal></div>
            </div>
        
        </div>
        <div id="BigBoxMedia" style="width:100%; background-color:#EAEDEE; margin-top:10px;">
        <asp:Literal ID="ltrlMedia" runat="server"></asp:Literal>
        </div>
        <div id="BigBoxText" style="width:100%; margin-top:10px; direction:<%=directionDescription%>; color:#3b3b3d; font-size:22px;">
        <asp:Literal ID="ltrlText" runat="server"></asp:Literal>
        </div>

        <div id="BigBoxComments" style="margin-top:10px; width:100%;">
        
         <div class="Bottom" id="CommentsArea">
 
                    <div class="BottomLine"></div>
                    

                        <asp:Repeater ID="rptComments" runat="server">

                        <HeaderTemplate>
                    <div id="currCommentsView" class="CommentsArea">

                        </HeaderTemplate>
                        <ItemTemplate>
                        

                         <div id="SingleCommentView" comment-id="<%#  ((Comment)Container.DataItem).ID %>">
                            <div class="SingleComment" style="width:503px" >
                                <div id="commentImage" class="CommentImage">
                                <asp:Literal ID="cmtUserImage" runat="server"></asp:Literal>
                                    
                                </div>
                                
                                <div class="CommentWrapper" style="width:476px">
                                
                                    
                                    <div id="HideComment" style="display:<%#  (((Comment)Container.DataItem).Mine == true)? "block" : "none" %>"></div>
                                    

                                    <div id="commentUserName">
                                        <asp:Literal ID="cmtUserName" runat="server"></asp:Literal>
                                        
                                    </div>
                                    <div id="CommentText" class="CommentText" runat="server" >
                                    <asp:Literal ID="cmtBody" runat="server"></asp:Literal>
                                    </div>
                                    <div class="CommentDate">
                                    <asp:Literal ID="cmtDate" runat="server"></asp:Literal>
                                    </div>

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

                    
                    
                    <div class="AddComment" style="margin-top:0"><textarea style="width:495px"  maxlength="500" id="Comment" cols"1" rows="1">Write a comment...</textarea></div>
                </div>

        </div>

    </div>

</div>





</div>
</div>






    <script id="TemplateComment" type="text/x-jQuery-tmpl">
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
                                    <div id="CommentText" class="CommentText" style="direction:${GetLanguageDirection(body)}" >${body}</div>
                                    <div class="CommentDate">${strDate} at ${strTime}</div>

                                </div>

                            </div>
                            
                            <div class="EndLine" style="background-color:#e2ddcf;">&nbsp;</div>
                            <div class="EndLine" style="background-color:#fcfbf9;">&nbsp;</div>
                        </div>
    </script>
    

 
            

 
    