using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace PostAround.Entities
{
    [DataContract]
    public class UserPermission
    {
        [DataMember]
        public int userId { get; set; }

        [DataMember]
        public int permissionId { get; set; }

        [DataMember]
        public DateTime date { get; set; }

        [DataMember]
        public bool status { get; set; }

    }



}
