using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;

namespace PostAround.Entities
{
    [DataContract]
    public class CommentResult
    {
        [DataMember]
        public int Id;

        [DataMember]
        public string Key;


        public CommentResult() { Id = 0; Key = ""; }

    }
}
