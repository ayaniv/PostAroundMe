<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SortButton.ascx.cs" Inherits="Controls_SortButton" %>

           <div id="btnSort" class="ChooseCategory HeaderMenu" >
                
                    <ul>
                        <li style="float:left; margin:0px; font-weight:bold; padding:0px; width:84px" id="btnSortText">Newest on top</li>
                    </ul>
                
            </div>




              <div id="SortBox" class="DropDown SortDropDown">
                
                

                

                
                    <ul>
                

                
                    <li onselectstart='return false;'>
                        Newest on top
                        <input style="display:none" value="0">
                    </li>

                    <li onselectstart='return false;'>
                        Nearest First
                        <input style="display:none" value="1">
                    </li>

                    <li onselectstart='return false;'>
                        Most Popular
                        <input style="display:none" value="2">
                    </li>
                


                
                    </ul>
                


                
       
       
    </div>