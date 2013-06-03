<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SinglePost.ascx.cs" Inherits="Controls_SinglePost" %>

<%@ Register src="AddThis.ascx" tagname="AddThis" tagprefix="uc1" %>

<%@ Register src="FacebookLike.ascx" tagname="FacebookLike" tagprefix="uc1" %>
<%@ Register src="GooglePlus.ascx" tagname="GooglePlus" tagprefix="uc1" %>

<%@ Import Namespace="PostAround.Entities" %> 


    



<div id="MessagesContainer">
<div id="BigBoxContainer" box-lat="<%=BigBoxLat %>" box-lon="<%=BigBoxLon %>" box-fuid="">




<script type="text/javascript" src="https://apis.google.com/js/plusone.js">
{"parsetags": "explicit"}
</script>

<link rel="canonical" href="<%=pageUrl %>" />    
    <script type="text/javascript">

        //FB.XFBML.parse();
        //gapi.plusone.go('GplusContainer', { "size": "medium" });



    </script>

<div class="Line" style="background-color:<%=bigBoxLineColor %> ; width:100%; "></div>
<div id="BigBoxWrapper" class="Box" box-id="<%=msgId %>" style="width:610px; padding:15px; background-color:#FFF; float:left;">
    <div id="FacebookID" style="display:none"><%=facebookID %></div>         
    <div id="BigBoxLeft" style="width:100%; float:left;">

        <div style="margin-bottom:10px; float:left; width:100%">
        <div style="clear:both; font-size:14px; color:#3b3b3d; float:left;"><asp:Literal ID="ltrlCategory" runat="server"></asp:Literal></div>

         <div id="BigBoxAddress" style="font-size:12px; float:right">
        <div style="float:left;">
        
        <img src="<%=siteUrl %>images/markers/image.png" style="width:12px; height:15px; margin:0 6px 0 6px;" /></div>
        <div style="margin-left:24px">
            <a href="<%=siteUrl %>ll/<%=BigBoxLat %>,<%=BigBoxLon %>" style="font-weight:bold" title="See more posts around here"><asp:Literal runat="server" ID="ltrlAddress"></asp:Literal></a>

        </div>
        
        </div>
            </div>
          

        <div id="map_canvas1" style="width:610px; clear:both; background-color:#EAEDEE; height:200px;">
        
        
        </div>
          <a style="color:#808080; margin-top:4px; float:right; text-decoration:none; font-size:12px;" target="_blank" href="<%=mapUrl %>">Open in Google Maps</a>
        

        
                
       <div style="float:left; width:100%; direction:<%=directionTitle %>; text-transform:uppercase; color:#3b3b3d; font-size:24px; margin-top:10px;  "><asp:Literal ID="ltrlTitle" runat="server"></asp:Literal></div>
        
                <div id="BigBoxMedia" class="BigBoxMedia" style="clear:both; margin-bottom:10px; width:610px; text-align:center">
        <asp:Literal ID="ltrlMedia" runat="server"></asp:Literal>
        </div>

                <div id="BigBoxText" class="BigBoxText" style="float:<%=alignDescription %>; margin-bottom:10px; direction:<%=directionDescription%>;">
        <asp:Literal ID="ltrlText" runat="server"></asp:Literal>
        </div>     
        



                <div id="BigBoxHeader" style="width:100%; clear:both;height:50px; ">
            <div id="BigBoxUserImage" runat="server" style="background-color:#EAEDEE; width:50px; height:50px; float:left;">
            <asp:Literal runat="server" ID="ltrlUserImage"></asp:Literal>
            </div>
            <div id="BigBoxUserName" style="padding-top:3px; height:40px; float:left; padding-left:10px">
                <div style="clear:both; font-size:14px; color:#3b3b3d">Posted By&nbsp;<span style="font-weight:bold"><asp:Literal ID="ltrlName" runat="server"></asp:Literal></span></div>
                <div id="BigBoxDate" style="clear:both; font-size:12px; color:#888888"><asp:Literal ID="ltrlDate" runat="server"></asp:Literal></div>
                <div style="float:left; font-size:12px; color:#888888"><asp:Literal ID="ltrlAddressUser" runat="server"></asp:Literal>
                  

                </div>
            </div>
            
        
        </div>

        <div id="BigBoxSocial" style="float:left; margin-top:10px; margin-bottom:10px; width:100%; height:20px">

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
                                        
                                    </div>
                                    <div id="CommentText" class="CommentText" runat="server" >
                                    <asp:Literal ID="cmtBody" runat="server"></asp:Literal>
                                    </div>
                                    <div class="CommentDate">
                                    <asp:Literal ID="cmtDate" runat="server"></asp:Literal>
                                    </div>
                                    <%# ((Comment)Container.DataItem).isPrivate ? @"<div class=""CommentDate PosterOnly"">· Poster Only&nbsp;·&nbsp;<span class=""Locker""></span></div>" : ""  %>
                                    
                                    
                                    

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
                            <textarea style="width:100%"  maxlength="500" id="Comment" cols"1" rows="1">Post a comment...</textarea>

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
                                
                                <div class="CommentWrapper" style="width:558px">
                                
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
    

 
            

 
    