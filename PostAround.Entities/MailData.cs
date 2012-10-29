using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace PostAround.Entities
{
    [DataContract]
    public class MailData
    {
        [DataMember]
        public string SenderFullName;
        [DataMember]
        public string Date;
        [DataMember]
        public string Message;
        [DataMember]
        public string SenderFname;
        [DataMember]
        public int MsgID;
        [DataMember]
        public string UnsubscribeCode;
        [DataMember]
        public string SenderImage;
        [DataMember]
        public string recipientEmail;

    }
}
