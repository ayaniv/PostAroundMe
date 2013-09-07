using PostAround.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Mails
{
    public class SimpleMail : MailComposer
    {
        string m_sendTo;
        string m_mailFrom;
        string m_templateSource;
        string m_title;
        string m_fromName;
        string m_body;


        public string Compose()
        {
            string body = @"Feedback from: {0},  email: {1},<br/> {2}";
            body = string.Format(body, m_fromName, m_mailFrom, m_body);
            return body;
        }

        public SimpleMail(string sendTo, string mailFrom, string subject, string body, string fromName)
        {
            m_title = subject;
            m_sendTo = sendTo;

            m_fromName = fromName;
            m_mailFrom = mailFrom;
            m_body = body;
            
        }

        public string Title()
        {
            return m_title;
        }

        public string MailTo()
        {
            return m_sendTo;
        }

        public string SentFrom()
        {
            return m_mailFrom;
        }



    }
}
