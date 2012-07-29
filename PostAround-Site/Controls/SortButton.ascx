<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SortButton.ascx.cs" Inherits="Controls_SortButton" %>

           <div id="btnSort" class="ChooseCategory" >
                
                    <ul>
                        <li style="float:left; margin:0px; font-weight:bold; padding:0px; width:84px" id="btnSortText">Newest on top</li>
                    </ul>
                
            </div>




              <div id="SortBox" class="DropDown SortDropDown">
                
                

                

                
                    <ul>
                

                
                    <li onselectstart='return false;  padding:0px; width:84px'>
                        Newest on top
                        <input style="display:none" value="0">
                    </li>

                    <li onselectstart='return false;  padding:0px; width:84px'>
                        Nearest First
                        <input style="display:none" value="1">
                    </li>
                


                
                    </ul>
                


                
       
       
    </div>