<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LoginMessage.ascx.cs" Inherits="Controls_LoginMessgae" %>
<%@ Register Src="FacebookLoginButton.ascx" TagName="FacebookLoginButton" TagPrefix="uc1" %>

<div id="PopupBox" class="PopupBox" style="position: relative;">

    <div style="float: left; width: 318px; border: 1px solid #C8C8C8;">






        <div id="xbuttonLoginMsg" class="SmallXButtonWrapper" >
            <div class="SmallXButton" style="display: block; margin-right:5px;">
            </div>
        </div>


        <div style="overflow: hidden; position: relative;">
            <ul class="LoginPanel LoginSignUp">
                <li class="log-in-box LoginSignUpBox DisplayBlock">
                    <div style="background: #EAEDEE; padding: 10px; height: 30px;">

                        <span style="font-weight: bold; font-family: Trebuchet MS, Arial, Sans-Serif; float: left; font-size: 20px" data-i18n="login.login-noun"></span>
                        <a href="#" id="createNewAccount" class="createNewAccount" data-i18n="login.create-new-account"></a>

                    </div>

                    <div style="background-color: #fff; /*5c74a9*/">
                        <div style="width: 16px; margin: auto; height: 8px; background: url('<%=siteUrl%>images/icons.png') -132px -76px"></div>
                        <uc1:FacebookLoginButton ID="FacebookLoginButton_Login" Text="Login with Facebook" runat="server" />
                        <%--<div class="LoginSeparator">or</div>--%>
                        <hr class="style-six" />
                        
                        <div style="margin-left: 10px; margin-top:18px;">

                        


                           <div class="uiStickyPlaceholderInput uiStickyPlaceholderEmptyInput">
                                <input type="text" class="login_email input-text inputWithPlaceHolder"  />
                                <div class="placeholderField" data-i18n="login.email"></div>
                            </div>


                            <div class="uiStickyPlaceholderInput uiStickyPlaceholderEmptyInput">
                                <input type="password" class="login_password input-text inputWithPlaceHolder"  />
                                <div class="placeholderField" data-i18n="login.password"></div>
                            </div>
                            

                        </div>



                        <div class="join-with-email" style="margin-left: 10px; margin-right: 10px; padding-bottom: 10px; width: 303px; float: left;">


                            <a href="<%=urlForgotPassword %>" target="_top" class="signup-with-email-expand-button blue-link-button" style="float: left;"  data-i18n="login.forgot-password"></a>
                            <input type="button" class="btnLoginForm email-login-button gray-button right clear-errors-button" style="float: right;" tabindex="103" data-i18n="[value]header.login">
                        </div>
                        

                    </div>

                    <div class="LoginErrorMessageArea ErrorMessageArea">
                    </div>





                </li>

                <li class="sign-up-box LoginSignUpBox">

                    <div style="background: #EAEDEE; padding: 10px; height: 30px;">

                        <span style="font-weight: bold; font-family: Trebuchet MS, Arial, Sans-Serif; float: left; font-size: 20px" data-i18n="login.signup"></span>
                        <a href="#" style="font-family: Trebuchet MS, Arial, Sans-Serif; color: #808080; padding-top: 4px; color: #6AA1BB; float: right; font-weight: lighter; font-size: 13px" id="alreadyMember" data-i18n="login.already-member"></a>

                    </div>


                    <div class="SignUpForm" style="background-color: #fff; /*5c74a9*/">
                        <div style="width: 16px; margin: auto; height: 8px; background: url('<%=siteUrl%>images/icons.png') -132px -76px"></div>
                        <uc1:FacebookLoginButton ID="FacebookLoginButton_Signup" Text="Sign Up with Facebook" runat="server" />
                        <hr class="style-six" />
                        <div style="margin-left: 10px; margin-top:18px;">

                             <div class="uiStickyPlaceholderInput uiStickyPlaceholderEmptyInput">
                                <input type="text" style="width: 139px"  class="signup_fname input-text inputWithPlaceHolder"  />
                                <div class="placeholderField" style="width: 139px" data-i18n="login.first-name"></div>
                            </div>

                            <div class="uiStickyPlaceholderInput uiStickyPlaceholderEmptyInput">
                                <input type="text" style="width: 139px"  class="signup_lname input-text inputWithPlaceHolder"  />
                                <div class="placeholderField" style="width: 139px"  data-i18n="login.last-name"></div>
                            </div>


                           <div class="uiStickyPlaceholderInput uiStickyPlaceholderEmptyInput">
                                <input type="text" class="signup_email input-text inputWithPlaceHolder"  />
                                <div class="placeholderField" data-i18n="login.email"></div>
                            </div>

                           <div class="uiStickyPlaceholderInput uiStickyPlaceholderEmptyInput">
                                <input type="password" class="signup_password input-text inputWithPlaceHolder"  />
                                <div class="placeholderField" data-i18n="login.new-password"></div>
                            </div>
                             
                            
                          

                        </div>



                        <div class="join-with-email" style="margin-left: 10px; margin-right: 10px; padding-bottom: 10px; width: 303px; float: left;">


                            <a href="#" class="signup-why-join-expand-button blue-link-button" style="float: left;" data-i18n="login.why-signup"></a>
                            <input type="button" class="btnSignUp email-login-button gray-button right clear-errors-button" style="float: right;" tabindex="103" data-i18n="[value]login.signup-verb" />
                        </div>




                    </div>




                    <div style="display: none; border-top: 1px solid #ccc;" class="login-panel-text signup-why-join-text info">
                        <ul style="margin-top: 10px;">
                            <li><b data-i18n="header.post-around-me"></b>
                                <span data-i18n="header.why-join-details-part1"></span>
                                </li>
                            <li data-i18n="header.why-join-details-part2"></li>

                            <li style="padding-top: 10px;"><b data-i18n="header.facebook-signups"></b></li>
                            <li data-i18n="header.facebook-signups-line1"></li>
                            <li data-i18n="header.facebook-signups-line2"></li>
                            <li data-i18n="header.facebook-signups-line3"></li>

                            <li style="padding-top: 10px;" data-i18n="header.why-join-details-cta"></li>


                        </ul>



                    </div>

                    <div class="SignUpErrorMessageArea ErrorMessageArea" style="display: none">
                    </div>

                </li>

                <li class="SignUpSucess LoginSignUpBox">

                <div style="background:#EAEDEE; padding: 10px; height:30px;">

                    <span style="font-weight: bold; font-family: Trebuchet MS, Arial, Sans-Serif; float:left; font-size: 20px" data-i18n="login.success"></span>
                  

                </div>

                    <div style="padding: 10px;">
                        
                        <ul style="clear: both; padding-top: 10px; font-size: 13px; color: #424e55">
                            <li data-i18n="login.success-line1"></li>
                            <li style="padding-top: 8px;"><span data-i18n="login.success-line2"></span>&nbsp;<b class="ActivationEmail"></b>.</li>
                            <li style="padding-top: 8px; font-size:20px;"><b data-i18n="login.success-line3"></b></li>
                            <li style="padding-top: 8px;"><span data-i18n="login.success-line4"></span>&nbsp;<b>info@postaround.me</b></li>
                           
                        </ul>


                    </div>

                </li>








                         








            </ul>

        </div>

    </div>

</div>
