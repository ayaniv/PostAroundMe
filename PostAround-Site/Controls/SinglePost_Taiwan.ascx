<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SinglePost_Taiwan.ascx.cs" Inherits="Controls_SinglePost_Taiwan" %>

<%@ Register src="AddThis.ascx" tagname="AddThis" tagprefix="uc1" %>
<%@ Register src="FacebookLike.ascx" tagname="FacebookLike" tagprefix="uc1" %>

<%@ Import Namespace="PostAround.Entities" %> 

 <style type="text/css">
        h3 {
            margin-bottom: 0;
        }

         table td {
             width:199px;
         }

         h1 {
             font-family:Georgia, Arial, sans-serif;
             font-weight:bold;
             color:#FFF;
             font-size:56px;
             line-height:51px;
             padding-top:190px;
             padding-left:10px;
             text-shadow:2px 2px #000;
         }

         h1 span {
             font-family:Trebuchet MS, Arial, sans-serif;
             font-style:italic;
             color:#FFF;
             font-size:36px;
             text-transform:capitalize;
         }
    </style>
<div id="fb-root"></div>
<script>    (function (d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));</script>

<div id="MessagesContainer" class="BigBoxContainer" style="position: relative;">
    <!-- AddThis Button BEGIN -->
    <div class="addthis_toolbox_page addthis_toolbox addthis_floating_style addthis_32x32_style">
        <a class="addthis_button_facebook"></a>
        <a class="addthis_button_twitter"></a>
        <a class="addthis_button_google_plusone_share"></a>
        <a class="addthis_button_pinterest_share"></a>
        <a class="addthis_button_gmail"></a>
        <a class="addthis_button_email"></a>
    </div>



    <!-- AddThis Button END -->

    <div id="BigBoxContainer" style="font-family:Georgia, Arial, Sans-Serif; color:#424e55">

        
        <div id="BigBoxWrapper" class="Box" style="width: 610px; min-height: 800px; padding: 15px; background-color: #FFF; float: left;">



            <div style="width:100%; height:300px; background:#000 url('../images/taiwan_receipt_lottery.jpg')">
                <div style="background:url('../images/textShadow.png'); height:300px; width:610px;">
                <h1>Taiwan Lottery<span>Receipt Lottery Checker</span></h1>
                </div>
            </div>
            <!-- Content START -->
            
            <div>
                <div>
                    <h4>Taiwan Receipt Lottery // Taiwan Lottery // Uniform Invoice Taiwan Online Checker // 台灣彩券</h4>
                    <br />

                     
                    <span>Welcome to <b>Taiwan Lottery Online Checker !</b></span>
                    <br />
                    The place to check automatically if you won Taiwan Receipt Lottery,
       
                    
                    with <b>Taiwan Receipt Lottery Winning Numbers</b> Online Web Checker.
        

               
                </div>
                <br /><br />
                <div>
                    Here are the Winning numbers for months
                    <asp:DropDownList ID="ddMonth" OnSelectedIndexChanged="Index_Changed" AutoPostBack="true" runat="server"></asp:DropDownList>

                   :
<br /><br />
       <table>
           <tr>
               <td>Special Prize Number:</td>
               <td>First Prize #1:</td>
               <td>Addition #1:</td>
           </tr>

                      <tr>
               <td><asp:TextBox ID="txtSpecial" runat="server"></asp:TextBox></td>
               <td> <asp:TextBox ID="txtFirst1" runat="server"></asp:TextBox></td>
               <td><asp:TextBox ID="txtAdd1" runat="server"></asp:TextBox></td>
           </tr>


                      <tr>
               <td>Grand Prize Number:</td>
               <td>First Prize #2:</td>
               <td>Addition #2:</td>
           </tr>

                                 <tr>
               <td><asp:TextBox ID="txtGrand" runat="server"></asp:TextBox> </td>
               <td> <asp:TextBox ID="txtFirst2" runat="server"></asp:TextBox></td>
               <td> <asp:TextBox ID="txtAdd2" runat="server"></asp:TextBox></td>
           </tr>

           
                                 <tr>
               <td></td>
               <td> First Prize #3: </td>
               <td> </td>
           </tr>

           
                                 <tr>
               <td></td>
               <td><asp:TextBox ID="txtFirst3" runat="server"></asp:TextBox>  </td>
               <td> </td>
           </tr>

       </table>

              

                </div>


                <h3>how to check taiwan receipt lottery?</h3>
                <div>
                    Don't need to know anything! Just the last 3 digits of your receipts' numbers into this box below,
        and check how much money you won!<br /><br />
                    Enter the last <b>3 digits</b> (or more) of your receipts <b>seperated by a comma (,)</b> and click "Check":<br />
                    <br />
                    <asp:TextBox TextMode="MultiLine" ID="txtNumbers" runat="server" Style="height: 100px; font-family:Arial, sans-serif; font-size:18px;"  placeholder="Enter 3 last digits 774, 479, 456 ..."></asp:TextBox>

                    <br />
                    <asp:Button ID="btnCheck" runat="server" Text="Check" Style="width:120px; height:30px; font-size:20px; margin-top:10px;" OnClick="btnCheck_Click" />
                    <br />
                    <br />
                    Checking Results:
   
                    <br />
                    <asp:TextBox ID="txtResults" Enabled="false" runat="server" TextMode="MultiLine" Style="font-family:Arial, sans-serif; font-size:13px;"></asp:TextBox>
                    <br />
                   

                 


                                    <h3>When the numbers are published?</h3>
                <div>
                    The Lottery takes place every two month. The results for two month are published on the 25th of the next month.<br />
                    (i.e. the results for 3-4/2013 will be published on 25/5/2013)<br />
                    We will do our best to serve you the results within the same date.<br />
                    So you will be able to check them easily with our online checker.<br />
                    <b>In case you are faster than us - just write them down in textboxes above</b>
                </div>
                    <br />
                     For more inofrmation regarding the lottery, please refer to <a href="http://service.etax.nat.gov.tw/etwmain/front/ETW183W6" target="_blank">Ministry of Finance</a>
                    <br />
                                       
                     
                    <br />
                    <h3>Got feedback?</h3>
                    <div>Add a comment. We are listening.</div>
                    <div class="fb-comments" data-href="http://postaround.me/taiwan" data-num-posts="2" data-width="610"></div>
                    <br />
                    <br />
                    <h3>Like us?</h3>
                    Please Like us on facebook
                    
                    <uc1:FacebookLike ID="FacebookLike1" runat="server" />

                </div>
            </div>

            <!-- Content End -->




        </div>





    </div>



</div>



    <script type="text/javascript">

        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-28432512-1']);
        _gaq.push(['_trackPageview']);

        (function () {
            var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();

</script>


  
    

 
 