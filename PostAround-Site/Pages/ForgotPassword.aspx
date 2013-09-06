<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ForgotPassword.aspx.cs" Inherits="Pages_ForgotPassword" %>

<%@ Register src="../Controls/HeadNew.ascx" tagname="HeadNew" tagprefix="uc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Password Reset</title>
    <uc1:HeadNew ID="HeadNew1" runat="server" />
</head>
<body style="height:auto;">
    <form id="form1" runat="server">
    <div style="width:100%;">
        <div style="width:325px; height:57px; margin-top:80px; margin-left:auto; margin-right:auto; position:relative;">
                <a style="border:0" href="<%=siteUrl %>"><img src="<%=siteUrlSecured %>images/mobile_logo.png"  style="border:0" /></a>
            </div>
        <asp:Panel runat="server" id="panelSendMail" class="appContent">
           
            <div style="font-size:18px; padding-bottom:20px; font-weight:bold; color:#333;">Password Reset</div>
            <div style="font-size:14px; padding-bottom:40px; color:#333;">We'll email you instructions on how to reset your password.</div>
            

            <div class="uiStickyPlaceholderInput uiStickyPlaceholderEmptyInput">
                <asp:TextBox runat="server" id="txtSendResetEmail" class="input-text inputWithPlaceHolder" ></asp:TextBox>
                
                <div class="placeholderField">Email</div>
            </div>

            <div style="padding-bottom:10px; float:right;">
                <asp:Button runat="server" id="btnSendResetPassword" class="email-login-button gray-button right clear-errors-button" style="height:30px" TabIndex="2" Text="Reset Password" OnClick="btnSendResetPassword_Click" />
            
            </div>
            <div runat="server" id="errorEmailNoExist" class="ErrorText"></div>

        </asp:Panel>

        <asp:Panel runat="server" ID="panelEmailSent" Visible="false" CssClass="appContent">

            <div style="font-size:18px; padding-bottom:20px; font-weight:bold; color:#333;">Password Reset</div>
            <div style="font-size:14px; color:#333;">

                An email with instructions on how to reset your password 
<br />
                has been sent.
                <br /><br />
If you do not receive it within an hour or two, check your spam folder.
                <br /><br />
                <a href="<%=siteUrl %>">Go back to PostAround.Me ></a>

            </div>

                    </asp:Panel>

        <asp:Panel id="ResetPassword" runat="server" Visible="false" class="appContent">
            
              <div style="font-size:18px; padding-bottom:20px; font-weight:bold; color:#333;">Password Reset</div>
            <div style="font-size:14px; padding-bottom:40px; color:#333;">Please enter your email, and at least 6 characters with letters and numbers for password.</div>


                        <div class="uiStickyPlaceholderInput uiStickyPlaceholderEmptyInput">
                <asp:TextBox runat="server" id="txtResetEmail" class="input-text inputWithPlaceHolder" ></asp:TextBox>
                
                <div class="placeholderField">Email</div>
            </div>
            


                           <div class="uiStickyPlaceholderInput uiStickyPlaceholderEmptyInput">
                               
                               <asp:TextBox TextMode="Password"  runat="server" id="txtResetPass1" class="input-text inputWithPlaceHolder" ></asp:TextBox>

                                <div class="placeholderField">New Password</div>
                            </div>

                            <div class="uiStickyPlaceholderInput uiStickyPlaceholderEmptyInput">
                                <asp:TextBox TextMode="Password" runat="server" id="txtResetPass2" class="input-text inputWithPlaceHolder" ></asp:TextBox>
                                <div class="placeholderField">Confirm New Password</div>
                            </div>

            <div style="padding-bottom:10px; float:right;">
                <asp:Button runat="server" id="btnResetPassword" class="email-login-button gray-button right clear-errors-button" style="height:30px" TabIndex="2" Text="Reset Password" OnClick="btnResetPassword_Click" />
            
            </div>
            <div runat="server" id="errorMsg" class="ErrorText"></div>
        </asp:Panel>


        
        <asp:Panel runat="server" ID="ResetPasswordDone" Visible="false" CssClass="appContent">

            <div style="font-size:18px; padding-bottom:20px; font-weight:bold; color:#333;">Password Reset Completed</div>
            <div style="font-size:14px; color:#333;">

                <span style="color:green; font-weight:bold;">Your password has been changed successfully !</span>
<br />


                <br /><br />
                <a href="<%=siteUrl %>">Continue to PostAround.Me ></a>

            </div>

                    </asp:Panel>



        <asp:Panel runat="server" ID="ResetPasswordError" Visible="false" CssClass="appContent">

            <div style="font-size:18px; padding-bottom:20px; font-weight:bold; color:red;">Password Reset Error</div>
            <div style="font-size:14px; color:#333;">

                <span style="color:#333; font-weight:bold;">Go back to your email link and try again</span>
<br />


                <br /><br />
                <a href="<%=siteUrl %>">Continue to PostAround.Me ></a>

            </div>

         </asp:Panel>


         <div style="width:440px; padding:20px;  margin-top:50px; color:#666; margin-left:auto; margin-right:auto; position:relative;">
                Copyright © 2012-2013 PostAround.Me. All Rights Reserved.
            </div>

    </div>
        
    </form>
</body>
</html>
