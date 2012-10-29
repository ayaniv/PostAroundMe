using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Mails
{
    public interface MailComposer
    {
        string Compose();
        string Title();
        string MailTo();

    }
}
