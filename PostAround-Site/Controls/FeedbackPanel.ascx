<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FeedbackPanel.ascx.cs" Inherits="Controls_FeedbackPanel" %>


<div class="feedback-panel">
    <a class="feedback-tab" href="Default.aspx">Feedback</a>
 <div id="FeedbackContent">
    <div style="width:100%; height:40px; background-image:url('images/addMessageBgTop.gif'); background-repeat:repeat-x; ">
        <div style="padding:9px; font-size:20px; font-weight:500; color:#57849d;">
            <div style="float:left;background:url('images/headings.png') no-repeat 0px 0px; width:231px; height:22px;">&nbsp;</div>
            
            
            <div id="xbuttonFeedback" style="width:14px; height:15px; float: right; cursor: pointer;">
         <div style="background: url('images/icons.png') repeat scroll -140px -143px; float: right;
             height: 14px; width: 11px;">
         </div>
     </div>

           
        </div>
    </div>
    <div style="width:100%; height:1px; background-color:#c9dfec;"></div>
    
<%--             <div style="padding:20px; height:264px; overflow:auto; display:none;">
 <div class="fb-comments" data-href="http://www.postaround.me" data-num-posts="10" data-width="470"></div>
 </div>--%>
 
 
    <div id="form-wrap" style="padding:9px;" >

    
 
    <div id="feedbackForm">
      <div style="width:250px; margin-bottom:10px; float:left; font-size:14px; color:#82898E;" span="2" ><b><i>PostAround.Me</i></b> is under development and always will be. Have something to comment? Just send us feedback!</div>
      <div style="width:70px; margin-top:10px; float:left; font-size:14px; font-weight:bold; color:#82898E" >Name</div>
      <div style="width:180px; margin-top:10px; float:left;"><input style="width:200px; border:solid 1px #c0c0c0; height:20px; padding:4px; font-family:Arial; font-size:13px;" id="txtFeedbackName" name="txtFeedbackName" type="text" /></div>
      <div style="width:70px; margin-top:10px; float:left; font-size:14px; font-weight:bold; color:#82898E" >Email</div>
      <div style="width:180px; margin-top:10px; float:left;"><input style="width:200px; border:solid 1px #c0c0c0; height:20px; padding:4px; font-family:Arial; font-size:13px;" id="txtFeedbackEmail" name="txtFeedbackEmail" type="text" /></div>
      <div style="width:70px; margin-top:10px; float:left; font-size:14px; font-weight:bold; color:#82898E" >Message</div>
      <div style="width:175px; margin-top:10px; float:left;"><textarea id="txtFeedbackMessage" name="txtFeedbackMessage" rows="10" col="30" style="width:200px; height:80px; border:solid 1px #c0c0c0; resize:none; overflow:auto; padding:4px; font-family:Arial; font-size:13px;"></textarea></div>
      
      <div class="SendFeedback" id="PostFeedback"></div>
    </div>


      
      
    </div>

    <div id="response-message" style="display:none">
        <p>Thanks.</p>
    </div>

    </div>
 
    </div>   