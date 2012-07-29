using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace PostAround.Entities
{
    [DataContract]
    public class BriefMessage
    {
        [DataMember]
        public int msgId { get; set; }
        [DataMember]
        public string latitude { get; set; }
        [DataMember]
        public string longitude { get; set; }
        [DataMember]
        public int catID { get; set; }
        [DataMember]
        public DateTime FullDate { get; set; }
        [DataMember]
        public string Title { get; set; }

        public BriefMessage() { }
    }
}





