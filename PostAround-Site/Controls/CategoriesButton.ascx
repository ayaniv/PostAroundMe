<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CategoriesButton.ascx.cs" Inherits="Controls_CategoriesButton" %>

            <div id="btnCategory" class="ChooseCategory" onselectstart='return false;' data-i18n="header.everything">
                
                
            </div>

                <div id="CategoriesBox" class="DropDown" style="display:none">
                
                

                <asp:Repeater runat="server" ID="rptCategoriesColumn1">

                <HeaderTemplate>
                    <ul>
                </HeaderTemplate>

                <ItemTemplate>
                    <li onselectstart='return false;'>
                    <asp:TextBox runat="server" ID="txtDropDownCategoryId" type="text" style="display:none"></asp:TextBox>
                    <asp:Label runat="server" id="ltrlDropDownColor" CssClass="Color"></asp:Label>
                    <asp:Label runat="server" ID="ltrlDropDownOption" CssClass="Option" ></asp:Label>
                    </li>
                </ItemTemplate>


                <FooterTemplate>
                    </ul>
                </FooterTemplate>


                </asp:Repeater>

 
       
       
    </div>