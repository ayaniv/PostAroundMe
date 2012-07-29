<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GeoHead.ascx.cs" Inherits="Controls_GeoHead" %>
<%@ Register src="AddPostButton.ascx" tagname="AddPost" tagprefix="uc1" %>

<div id="GeoHead" class="GeoHead GeoHeadDisable">
    <div id="GeoHeadContent" >
    <uc1:AddPost ID="AddPost1" runat="server" />
             
            <div id="btnCategory" class="ChooseCategory" onselectstart='return false;' >
                
                    <ul>


                        <li style="float:left; margin:0px; font-weight:bold;" id="btnCategoryText">
                        
                        <span style="background-color:#e3e3e3;" class="Color"></span>

                        <span class="Option">All Categories</span>
                        
                        </li>
                    </ul>
                
                <div class="MoreIcon"></div>
            </div>

                <div id="CategoriesBox" class="DropDown">
                <div style="height:1px; background-color:#ccdae1; width:184px; margin-left:201px;"></div>
                

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

               <asp:Repeater runat="server" ID="rptCategoriesColumn2">

                <HeaderTemplate>
                    <ul>
                </HeaderTemplate>

                <ItemTemplate>
                    <li onselectstart='return false;'>
                    <asp:TextBox runat="server" ID="txtDropDownCategoryId" type="text" style="display:none"></asp:TextBox>
                    <asp:Label runat="server" ID="ltrlDropDownColor" CssClass="Color"></asp:Label>
                    <asp:Label runat="server" ID="ltrlDropDownOption" CssClass="Option" ></asp:Label>
                    </li>
                </ItemTemplate>


                <FooterTemplate>
                    </ul>
                </FooterTemplate>


                </asp:Repeater>
       
       
    </div>


            
            
 

           <div id="btnSort" class="ChooseCategory" style="width:124px">
                
                    <ul>
                        <li style="float:left; margin:0px; font-weight:bold;" id="btnSortText">Sort By Newest</li>
                    </ul>
                
                <div class="MoreIcon"></div>
            </div>




              <div id="SortBox" class="DropDown SortDropDown">
                
                

                

                
                    <ul>
                

                
                    <li onselectstart='return false;'>
                        Sort By Newest
                        <input style="display:none" value="0">
                    </li>

                    <li onselectstart='return false;'>
                        Sort By Distance
                        <input style="display:none" value="1">
                    </li>
                


                
                    </ul>
                


                
       
       
    </div>




 
            <div id="SliderBar" class="Slider">
                <div style="width:246px;">
                    
                    <label for="amount" style="float:left">Up to Distance:</label>
	                <input readonly="readonly" value="ALL" type="text" id="amount" style="float:right; background:transparent; border:0; color:#6AA1BB; font-weight:bold; font-size:16px; font-style:italic; width:50px; font-family:Calibri,Arial; text-align:right; padding:0px; margin:0px;  " />
	            </div>
	            <div style="width:244px; float:left; margin-top:2px;">
                    <div id="slider"></div>
                </div>
            </div>
             
            
            </div>
        </div>