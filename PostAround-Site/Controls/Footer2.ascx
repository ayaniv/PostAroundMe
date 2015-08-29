<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Footer2.ascx.cs" Inherits="Controls_Footer2" %>




<div class="BottomDiv" >
            
    <div class="FacebookLikeBox">
    <div class="fb-page" data-href="https://www.facebook.com/postaround" 
  data-width="340" data-hide-cover="false" data-show-facepile="true"></div>
        </div>
          <div class="Text FooterLinks">
              <div class="Heading">
                  <asp:Literal ID="siteUse" runat="server"></asp:Literal>
              </div>
            <div>
                <asp:HyperLink runat="server" ID="lnkSiteLinks"></asp:HyperLink>
            </div>
            
            <div>
                <asp:HyperLink runat="server" ID="lnkBlog"></asp:HyperLink>
            </div>
            
            <div>
                <asp:HyperLink runat="server" ID="lnkContact"></asp:HyperLink>
            </div>
            
            <div>
                <asp:HyperLink runat="server" ID="lnkTerms"></asp:HyperLink>
            </div>
            
            <div>
                <asp:HyperLink runat="server" ID="lnkPrivacy"></asp:HyperLink>                
            </div>
        </div>


    <div class="Text FooterLinks">
              <div class="Heading">
                  <asp:Literal ID="featuredLocations" runat="server"></asp:Literal>
               </div>
            <div>
                <a href="http://postaround.me/in/מנור_ראש_העין_ישראל">לוח מודעות פסגות אפק ראש העין</a>
            </div>
           <div>
                <a href="http://postaround.me/in/שכונת_ביצרון_תל_אביב">לוח מודעות שכונת ביצרון תל אביב</a>
            </div>

        <div>
                <a href="http://postaround.me/in/washington_dc">Post around Washington DC</a>
            </div>

        <div>
                <a href="http://postaround.me/in/daan_park_taipei_taiwan">Post around Daan Park, Taipei, Taiwan</a>
            </div>

        <div>
                <a href="http://postaround.me/in/אוניברסיטת_תל_אביב">לוח מודעות אוניברסיטת תל אביב</a>
            </div>
            

        </div>

                <div class="Text Description" >
    
                    <div>
                    <asp:ImageButton PostBackUrl="http://postaround.me" ImageUrl="~/images/newlogo_black2.png" runat="server"></asp:ImageButton>            
                        </div>
                    <asp:HyperLink runat="server" CssClass="linkLightGrey" ID="lnkPostAroundMe"></asp:HyperLink>            
                    <asp:Literal runat="server" ID="FooterText"></asp:Literal>

    
                    

            </div>



            </div>
<div class="BottomDivAfter">
    <asp:Literal ID="ltrlCopyright" runat="server"></asp:Literal>
</div>
            


   