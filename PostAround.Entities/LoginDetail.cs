using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;

namespace PostAround.Entities
{
    [DataContract]
    public class LoginDetail
    {
        [DataMember]
        public int UserID;

        [DataMember]
        public string email;

        [DataMember]
        public string password;

        public LoginDetail() { }

    }
}
