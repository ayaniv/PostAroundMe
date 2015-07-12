<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Footer2.ascx.cs" Inherits="Controls_Footer2" %>



<div id="BottomDiv" style="margin-top:210px; position:relative; bottom:0; width:100%">
<div style="width:100%; height:4px;"></div>
<div class="BottomDiv" >
            <div style="margin-top:8px;">
            
            <div class="Text" style="float:left;">
                <asp:Literal ID="ltrlCopyright" runat="server"></asp:Literal>
            
            </div>
                  <div class="Text" style="float:right; margin-right:47px;">
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

                <div class="Text" style="clear:both; float:left; padding-top:20px; color:#dfdfdf; width:400px;">
    
                    <asp:HyperLink runat="server" CssClass="linkLightGrey" ID="lnkPostAroundMe"></asp:HyperLink>            
                    <asp:Literal runat="server" ID="FooterText"></asp:Literal>

    
                    

            </div>



            </div>
            </div>
            </div>


   