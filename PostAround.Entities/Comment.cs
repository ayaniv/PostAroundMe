using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;


namespace PostAround.Entities
{
    [DataContract]
    public class Comment
    {
        [DataMember]
        public int ID;

        [DataMember]
        public int messageID;

        [DataMember]
        public int userID;

        [DataMember]
        public string body;

        [DataMember]
        public DateTime date;

        [DataMember]
        public string strDate { get; set; }

        [DataMember]
        public string strTime { get; set; }

        [DataMember]
        public string name;

        [DataMember]
        public string commentUserLink;

        [DataMember]
        public string avatarImageUrl;

        [DataMember]
        public bool Mine;

        public Comment() { }

    }
}
