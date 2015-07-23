<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Footer2.ascx.cs" Inherits="Controls_Footer2" %>



<div id="BottomDiv" style="margin-top:210px; position:relative; bottom:0; width:100%">
<div class="Press">
    <a href="https://www.youtube.com/watch?v=OecN2qkXxVs" target="_blank"><img src="../images/b-10.png" /></a>
    <a href="http://www.newsgeek.co.il/postaround-me-startup/" target="_blank"><img src="../images/b-g.png" /></a>
    <a href="http://www.feeder.co.il/article-postaround-me-is-a-new-israeli-local-pinboard-for-buyers-and-sellers-1000773656" target="_blank"><img src="../images/b-f.png" /></a>
    <a href="http://net.nana10.co.il/Article/?ArticleID=918602" target="_blank"><img src="../images/b-n.png" /></a>
</div>
<div class="BottomDiv" >
            <div style="margin-top:8px;">
            
            <div class="Text Copyright">
                <asp:Literal ID="ltrlCopyright" runat="server"></asp:Literal>
            
            </div>
                  <div class="Text FooterLinks">
            <span>
                <asp:HyperLink runat="server" ID="lnkSiteLinks"></asp:HyperLink>
            </span>
            <span style=" margin-right:4px; margin-left:4px;">/</span>
            <span>
                <asp:HyperLink runat="server" ID="lnkBlog"></asp:HyperLink>
            </span>
            <span style=" margin-right:4px; margin-left:4px;">/</span>
            <span>
                <asp:HyperLink runat="server" ID="lnkContact"></asp:HyperLink>
            </span>
            <span style=" margin-right:4px; margin-left:4px;">/</span>
            <span>
                <asp:HyperLink runat="server" ID="lnkTerms"></asp:HyperLink>
            </span>
            <span style=" margin-right:4px; margin-left:4px;">/</span>
            <span>
                <asp:HyperLink runat="server" ID="lnkPrivacy"></asp:HyperLink>                
            </span>
        </div>

                <div class="Text Description">
    
                    <asp:HyperLink runat="server" CssClass="linkLightGrey" ID="lnkPostAroundMe"></asp:HyperLink>            
                    <asp:Literal runat="server" ID="FooterText"></asp:Literal>

    
                    

            </div>



            </div>
            </div>
            </div>


   