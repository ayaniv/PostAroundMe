<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MorePosts.ascx.cs" Inherits="Controls_MorePosts" %>

<div class="MorePosts">
    <div class="MorePostsTitle">
        <span class="Line1">Most Recent Posts Around Here</span>
        <div class="Line2"><span class="SmallLocationIcon"></span><asp:HyperLink runat="server" ID="linkAddress"></asp:HyperLink></div>

    </div>
    <div class="MorePostsWrapper">
        <asp:Repeater ID="rptPosts" runat="server">
            <ItemTemplate>
        <div class="PostItem" runat="server" id="PostItem">
            <div runat="server" id="divLine" class="PostItemLine"></div>
            <div class="PostItemContent">
                <asp:Image runat="server" ID="imgUserAvatar" />
                <div class="NameLine">
                    <span class="UserName"><asp:Literal ID="ltrlUserName" runat="server"></asp:Literal></span>
                    <div style="float: right;">
                        <span class="SmallLocationIcon"></span>
                        <span class="DistanceAround"><asp:Literal runat="server" ID="ltrlDistance"></asp:Literal></span>
                    </div>
                </div>
                <asp:HyperLink CssClass="BoxHeader" Style="width: auto; text-decoration:none; font-size:16px; overflow:hidden" runat="server" ID="linkTitle"></asp:HyperLink>
            </div>
        </div>
                </ItemTemplate>
            </asp:Repeater>
    </div>

     <div class="MorePostsFooter">
         <asp:HyperLink runat="server" Text="Read & Share More Posts Around Here..." ID="linkMorePosts"></asp:HyperLink>
       
        

    </div>

</div>

<script type="text/javascript">
    $(function () {
        $('.PostItem').click(function () {
            
            var postId = $(this).attr("postId");
            url = siteUrl + "post/" + postId + "?ref=mp";
            window.location.href = url;
        });
    });

</script>

