<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LoginMessage.ascx.cs" Inherits="Controls_LoginMessgae" %>
<%@ Register Src="FacebookLoginButton.ascx" TagName="FacebookLoginButton" TagPrefix="uc1" %>

<div id="PopupBox" class="PopupBox" style="position: relative;">

    <div style="float: left; width: 318px; border: 1px solid #C8C8C8;">






        <div id="xbuttonLoginMsg" class="SmallXButtonWrapper" >
            <div class="SmallXButton" style="display: block; margin-right:5px;"">
            </div>
        </div>


        <div style="overflow: hidden; position: relative;">
            <ul class="LoginPanel LoginSignUp">
                <li class="log-in-box LoginSignUpBox DisplayBlock">
                    <div style="background: #EAEDEE; padding: 10px; height: 30px;">

                        <span style="font-weight: bold; font-family: Trebuchet MS, Arial, Sans-Serif; float: left; font-size: 20px">Login</span>
                        <a href="#" id="createNewAccount" class="createNewAccount">Create New Account</a>

                    </div>

                    <div style="background-color: #fff; /*5c74a9*/">
                        <div style="width: 16px; margin: auto; height: 8px; background: url('<%=siteUrl%>images/icons.png') -132px -76px"></div>
                        <uc1:FacebookLoginButton ID="FacebookLoginButton_Login" Text="Login with Facebook" runat="server" />
                        <%--<div class="LoginSeparator">or</div>--%>
                        <hr class="style-six" />
                        
                        <div style="margin-left: 10px; margin-top:18px;">

                        


                           <div class="uiStickyPlaceholderInput uiStickyPlaceholderEmptyInput">
                                <input type="text" class="login_email input-text inputWithPlaceHolder"  />
                                <div class="placeholderField">Email</div>
                            </div>


                            <div class="uiStickyPlaceholderInput uiStickyPlaceholderEmptyInput">
                                <input type="password" class="login_password input-text inputWithPlaceHolder"  />
                                <div class="placeholderField">Password</div>
                            </div>
                            

                        </div>



                        <div class="join-with-email" style="margin-left: 10px; margin-right: 10px; padding-bottom: 10px; width: 303px; float: left;">


                            <a href="<%=urlForgotPassword %>" target="_top" class="signup-with-email-expand-button blue-link-button" style="float: left;">Forgot password?</a>
                            <input type="button" class="btnLoginForm email-login-button gray-button right clear-errors-button" style="float: right;" tabindex="103" value="Log in">
                        </div>
                        

                    </div>

                    <div class="LoginErrorMessageArea ErrorMessageArea">
                    </div>





                </li>

                <li class="sign-up-box LoginSignUpBox">

                    <div style="background: #EAEDEE; padding: 10px; height: 30px;">

                        <span style="font-weight: bold; font-family: Trebuchet MS, Arial, Sans-Serif; float: left; font-size: 20px">Sign Up</span>
                        <a href="#" style="font-family: Trebuchet MS, Arial, Sans-Serif; color: #808080; padding-top: 4px; color: #6AA1BB; float: right; font-weight: lighter; font-size: 13px" id="alreadyMember">Already a member? Log In</a>

                    </div>


                    <div class="SignUpForm" style="background-color: #fff; /*5c74a9*/">
                        <div style="width: 16px; margin: auto; height: 8px; background: url('<%=siteUrl%>images/icons.png') -132px -76px"></div>
                        <uc1:FacebookLoginButton ID="FacebookLoginButton_Signup" Text="Sign Up with Facebook" runat="server" />
                        <hr class="style-six" />
                        <div style="margin-left: 10px; margin-top:18px;">

                             <div class="uiStickyPlaceholderInput uiStickyPlaceholderEmptyInput">
                                <input type="text" style="width: 139px"  class="signup_fname input-text inputWithPlaceHolder"  />
                                <div class="placeholderField" style="width: 139px" >First Name</div>
                            </div>

                            <div class="uiStickyPlaceholderInput uiStickyPlaceholderEmptyInput">
                                <input type="text" style="width: 139px"  class="signup_lname input-text inputWithPlaceHolder"  />
                                <div class="placeholderField" style="width: 139px" >Last Name</div>
                            </div>


                           <div class="uiStickyPlaceholderInput uiStickyPlaceholderEmptyInput">
                                <input type="text" class="signup_email input-text inputWithPlaceHolder"  />
                                <div class="placeholderField">Email</div>
                            </div>

                           <div class="uiStickyPlaceholderInput uiStickyPlaceholderEmptyInput">
                                <input type="password" class="signup_password input-text inputWithPlaceHolder"  />
                                <div class="placeholderField">New Password</div>
                            </div>
                             
                            
                          

                        </div>



                        <div class="join-with-email" style="margin-left: 10px; margin-right: 10px; padding-bottom: 10px; width: 303px; float: left;">


                            <a href="#" class="signup-why-join-expand-button blue-link-button" style="float: left;">Why Sign Up?</a>
                            <input type="button" class="btnSignUp email-login-button gray-button right clear-errors-button" style="float: right;" tabindex="103" value="Sign Up" />
                        </div>




                    </div>




                    <div style="display: none; border-top: 1px solid #ccc;" class="login-panel-text signup-why-join-text info">
                        <ul style="margin-top: 10px;">
                            <li><b>Post Around Me</b> connects you with the people around you, 
              and lets you share anything you want with them!</li>
                            <li>It’s your local pinboard, tailored to your location.
             Who knew that your neighbors were so useful ;)</li>

                            <li style="padding-top: 10px;"><b>Facebook Sign Ups:</b></li>
                            <li>We just ask for your basic details.</li>
                            <li>We don't store your password.</li>
                            <li>We will never post ANYTHING on your behalf, unless you ask for it.</li>

                            <li style="padding-top: 10px;">Join NOW, spread your posts around, and create a happier environment!</li>


                        </ul>



                    </div>

                    <div class="SignUpErrorMessageArea ErrorMessageArea" style="display: none">
                    </div>

                </li>

                <li class="SignUpSucess LoginSignUpBox">

                <div style="background:#EAEDEE; padding: 10px; height:30px;">

                    <span style="font-weight: bold; font-family: Trebuchet MS, Arial, Sans-Serif; float:left; font-size: 20px">Success !</span>
                  

                </div>

                    <div style="padding: 10px;">
                        
                        <ul style="clear: both; padding-top: 10px; font-size: 13px; color: #424e55">
                            <li>Only one step seperates you from creating a<br />happier environment !</li>
                            <li style="padding-top: 8px;">We would like to verify your email: <b class="ActivationEmail"></b>.</li>
                            <li style="padding-top: 8px; font-size:20px;"><b>Please check your mailbox and click on the activation link we've sent you.</b></li>
                            <li style="padding-top: 8px;">If you do not receive an email from us within 30 minutes, please check your email's spam and junk filters, or contact us at <b>info@postaround.me</b></li>
                           
                        </ul>


                    </div>

                </li>








                         








            </ul>

        </div>

    </div>

</div>
