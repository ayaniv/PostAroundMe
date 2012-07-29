using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

/// <summary>
/// Summary description for LoginResponseFailed
/// </summary>
/// 
[DataContract]
public class LoginResponseFailed
{

    [DataMember]
    public int Status;

    [DataMember]
    public string Message;


    public LoginResponseFailed() {}




}