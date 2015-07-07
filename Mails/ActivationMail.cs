using PostAround.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Mails
{
    public class ActivationMail : MailComposer
    {
        string m_activationLink;
        string m_name;
        string m_templateSource;
        string m_sendTo;
        string m_title;

         public string Compose()
        {
            string body = System.IO.File.ReadAllText(m_templateSource);
            body = body.Replace("[ActivationLink]", m_activationLink);
            body = body.Replace("[Name]", m_name);
            return body;
        }

         public ActivationMail(string activationLink, string name, string sendTo, string templateSource, string title)
        {
            m_templateSource = templateSource;
            m_activationLink = activationLink;
            m_sendTo = sendTo;
            m_name = name;
            m_title = title;
        }

        public string Title()
        {
            return m_title;
        }

        public string MailTo()
        {
            return m_sendTo;
        }


    }


}
