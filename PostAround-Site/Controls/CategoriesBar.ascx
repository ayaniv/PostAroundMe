<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CategoriesBar.ascx.cs" Inherits="Controls_CategoriesBar" %>



<asp:Repeater runat="server" ID="rptCategoriesBar">

                <HeaderTemplate>
        <ul id="catsBar" style="margin-left:auto; margin-right:auto; margin-bottom:6px;">
                </HeaderTemplate>

                <ItemTemplate>
                    <li onselectstart='return false;'>
                        <span class="SelectedCategoryInBar"></span>
                        <asp:TextBox runat="server" ID="txtDropDownCategoryId" type="text" style="display:none"></asp:TextBox>
                        <asp:Label runat="server" ID="ltrlDropDownColor" CssClass="Color" style="margin:0"></asp:Label>
                        <asp:Label runat="server" ID="ltrlDropDownOption" CssClass="Option" style="margin-left:9px; margin-top:-3px"></asp:Label>
                    </li>
                </ItemTemplate>


                <FooterTemplate>
                    </ul>
                </FooterTemplate>


                </asp:Repeater>



        
         
         