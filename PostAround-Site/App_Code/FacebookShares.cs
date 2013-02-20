using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

/// <summary>
/// Summary description for FacebookShares
/// </summary>
[DataContract]
public class FacebookShares
{

    [DataMember]
    public int shares;

    [DataMember]
    public string id;

    public FacebookShares() { }




}