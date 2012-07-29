using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using PostAround.Entities;




namespace Mails
{
    public class ReplyMailComposer : MailComposer
    {
        MailData m_credentials;
        string m_templateSource;
        string m_title;

        public string Compose()
        {
            string body = System.IO.File.ReadAllText(m_templateSource);
            body = body.Replace("[SenderFullName]", m_credentials.SenderFullName);
            body = body.Replace("[Date]", m_credentials.Date);
            body = body.Replace("[Message]", m_credentials.Message);
            body = body.Replace("[SenderFName]", m_credentials.SenderFname);
            body = body.Replace("[PostID]", m_credentials.MsgID.ToString());
            body = body.Replace("[UnSubscribeCode]", m_credentials.UnsubscribeCode);
            body = body.Replace("[SenderImage]", m_credentials.SenderImage);

            return body;
        }

        public ReplyMailComposer(MailData credentials, string templateSource, string title)
        {
            m_templateSource = templateSource;
            m_credentials = credentials;
            m_title = title;
        }

        public string Title()
        {
            return m_title;
        }



        
    }
}
