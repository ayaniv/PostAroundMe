<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PostNotify.aspx.cs" Inherits="Pages_PostNotify" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="background:#fcfbf9 url('../images/bgg.png')">
    <form id="form1" runat="server">
    <div>
    

        <table cellspacing="0" cellpadding="0" border="0" width="100%"><tbody><tr><td style="padding:30px 15px 0">
    <table cellspacing="0" cellpadding="0" border="0" align="center" width="710" style="font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;font-size:16px;color:#333">
      <tbody><tr><td>
        
        <!-- Header -->
        
        <table  cellspacing="0" cellpadding="0" border="0" style="width:710px; height:115px; ">
        <tr><td style="width:595px; height:115px; background:#FFF">
        <table cellpadding="0" cellspacing="0">
        <tr><td style="padding:10px; padding-left:55px"><a title="PostAround.Me" target="_top" href="<%=siteUrl %>"><img  title="PostAround.Me" alt="Post Around Me" src="<%=siteUrl %>images/mail/logo.gif" style="width:300px; height:51px; border:0" /></a></td></tr>
        <tr><td style="padding-left:55px; padding-top:0px; font-family:Arial; color:#333;font-size:22px">You’ve got a <b>new comment</b> to your post around !</td></tr>
        
        </table>
        
        
        </td>
        <td style="width:115px; height:115px; text-align:right; vertical-align:top;"><img alt="reply message" src="<%=siteUrl %>images/mail/corner_reply.gif" style="width:111px; height:111px" /></td>
        </tr>
        </table>
        
      </td></tr>

      <tr><td style="padding-left:55px; padding-top:10px; font-family:Arial; background-color:#FFF; color:#333; font-size:16px">In reply to <a href="<%=siteUrl %>Pages/ref.aspx?postId=<%=postId%>" target="_top" style="font-weight:bold; text-decoration:none; color:#6d90a9"><%=postHeader%></a>...</td></tr>

      <tr><td style="background-color:#fff;padding:25px 40px 22px">
        <!-- Body -->

<table style="width:100%; background:#f2f2f2">
<tr>
<td style="width:50px; padding:15px"><img alt="Sender" style="height:50px; width:50px" src="<%=senderImage %>" /></td>
<td style="padding:15px; padding-left:0">
<table cellpadding="0" cellspacing="0">
<tr style="width:100%">
<td style="color:#888; font-size:12px; font-family:Arial;"><span style="font-size:14px; font-family:Arial; font-weight:bold"><%=senderFullName %></span> · replied on <%=date %></td>
</tr>
<tr style="width:100%">
<td style="font-family:Georgia, Arial; font-size:24px; font-style:italic"><%=message %></td>
</tr>
</table>
</td>
</tr>

</table>


      </td></tr>

          <tr><td style="background-color:#fff;">
              <table  cellspacing="0" cellpadding="0" border="0" style="width:610px; ">
                  <tr>
              <td style="padding-left:55px; background-color:#fff; padding-top:0px; font-family:Arial; color:#aaa; font-size:60px">*</td>
              <td style="padding-left:20px; vertical-align:top; background-color:#fff; padding-top:0px; font-family:Arial; color:#aaa; font-size:13px">For your information, some of the comments may be visible to posters only, as we let users to send Private Comments. Make sure you are logged in to PostAround.Me, and you won't miss a thing.</td>
                      </tr>
                  </table>
              </td>
          </tr>
          
      
      <tr><td style="background-color:#fff;padding:0 0 10px 0"></td></tr>
      <tr><td style="background-color:#fff;padding:32px 40px 22px;border-top:1px solid #f2f2f2">
        
        <!-- Bottom -->

<table style="margin-left:15px; background:#f46710 url('<%=siteUrl %>images/mail/button_bg.png') repeat-x;" cellpadding="0" cellspacing="0">
<tr>
<td style="height:48px; float:left; padding-left:15px; padding-right:15px; background:#f46710 url('<%=siteUrl %>images/mail/button_bg.png') repeat-x;">
<a href="<%=siteUrl %>Pages/ref.aspx?postId=<%=postId%>" target="_top" style="float:left; text-decoration:none; font-family:Arial; font-size:24px; color:#FFF; padding:10px 40px 10px 40px;" >
Reply to <%=senderFName %>
</a>
</td>
</tr>
</table>



      </td></tr>
      

      




    </tbody></table>
  </td></tr></tbody></table>


    </div>
    </form>
</body>
</html>
