using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

/// <summary>
/// Summary description for BezeqRequest
/// </summary>
[DataContract]
public class FacebookResponse
{
    [DataMember]
    public string id;

    [DataMember]
    public string name;

    [DataMember]
    public string first_name;

    [DataMember]
    public string middle_name;

    [DataMember]
    public string last_name;

    [DataMember]
    public string link;

    [DataMember]
    public string birthday;

    [DataMember]
    public string gender;

    [DataMember]
    public string email;

    [DataMember]
    public string timezone;
    
    [DataMember]
    public string locale;

    [DataMember]
    public string updated_time;
}