using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Net.Mail;

namespace Mails
{
    public class Helper
    {

        public static void SendMailMessageAsync(string from, string to, string bcc, string cc, string subject, string body)
        {
            ThreadPool.QueueUserWorkItem(delegate { SendMailMessage(from, to, bcc, cc, subject, body); });
        }

        public static void SendMailMessage(string from, string to, string bcc, string cc, string subject, string body)
        {
            try
            {
                // Instantiate a new instance of MailMessage
                MailMessage mMailMessage = new MailMessage();

                //MailAddress fromMail = new MailAddress(from, "PostAround.Me");
                //mMailMessage.Sender = fromMail;

                if (!string.IsNullOrWhiteSpace(from))
                    mMailMessage.ReplyToList.Add(from);

                // Set the recepient address of the mail message
                mMailMessage.To.Add(new MailAddress(to));
                // Check if the bcc value is null or an empty string
                if ((bcc != null) && (bcc != string.Empty))
                {
                    // Set the Bcc address of the mail message
                    mMailMessage.Bcc.Add(new MailAddress(bcc));
                }
                // Check if the cc value is null or an empty value
                if ((cc != null) && (cc != string.Empty))
                {
                    // Set the CC address of the mail message
                    mMailMessage.CC.Add(new MailAddress(cc));
                }

                // Set the subject of the mail message
                mMailMessage.Subject = subject;
                // Set the body of the mail message
                mMailMessage.Body = body;
                // Set the format of the mail message body as HTML
                mMailMessage.IsBodyHtml = true;

                // Set the priority of the mail message to normal
                mMailMessage.Priority = MailPriority.Normal;
                // Instantiate a new instance of SmtpClient



                SmtpClient mSmtpClient = new SmtpClient();
                object userState = mMailMessage;
                //mSmtpClient.SendCompleted +=new SendCompletedEventHandler(mSmtpClient_SendCompleted);

                // Send the mail message
                mSmtpClient.SendAsync(mMailMessage, userState);
            }
            catch (Exception ex)
            {

            }
        }

        //static void mSmtpClient_SendCompleted(object sender, System.ComponentModel.AsyncCompletedEventArgs e)
        //{
        //    //Get the Original MailMessage object
        //    MailMessage mail = (MailMessage)e.UserState;

        //    //write out the subject
        //    string subject = mail.Subject;

        //    if (e.Cancelled)
        //    {
        //        Console.WriteLine("Send canceled for mail with subject [{0}].", subject);
        //    }
        //    if (e.Error != null)
        //    {
        //        Console.WriteLine("Error {1} occurred when sending mail [{0}] ", subject, e.Error.ToString());
        //    }
        //    else
        //    {
        //        Console.WriteLine("Message [{0}] sent.", subject);
        //    }
        //}
    }
}
