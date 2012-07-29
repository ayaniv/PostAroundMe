using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace PostAround.Entities
{
    [DataContract]
    public class User
    {
        [DataMember]
        public int userID;
        [DataMember]
        public string firstName;
        [DataMember]
        public string lastName;
        [DataMember]
        public string email;
        [DataMember]
        public string phone1;
        [DataMember]
        public string phone2;
        [DataMember]
        public string address;
        [DataMember]
        public string longtitude;
        [DataMember]
        public string latidute;
        [DataMember]
        public string avatarImageUrl;
        [DataMember]
        public string gender;
        [DataMember]
        public string facebookID;
        [DataMember]
        public string link;
        [DataMember]
        public int timezone;
        [DataMember]
        public string facebookToken;
        [DataMember]
        public DateTime birthday;
        [DataMember]
        public DateTime regDate;


        public User() { }

    }
}
