using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

/// <summary>
/// Summary description for TweeterShares
/// </summary>
[DataContract]
public class TweeterShares
{

    [DataMember]
    public int shares;

    [DataMember]
    public string url;

    public TweeterShares() { }




}