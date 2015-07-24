<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Footer2.ascx.cs" Inherits="Controls_Footer2" %>




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
            


   