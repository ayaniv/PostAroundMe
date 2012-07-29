using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace PostAround.Entities
{
    [DataContract]
    public class Feedback
    {
        [DataMember]
        public DateTime date;

        [DataMember]
        public string name;

        [DataMember]
        public string email;

        [DataMember]
        public string message;

        public Feedback() { }

    }
}
