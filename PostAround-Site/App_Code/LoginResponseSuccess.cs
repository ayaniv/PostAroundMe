using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

/// <summary>
/// Summary description for LoginResponseSuccess
/// </summary>
/// 


[DataContract]
public class LoginResponseSuccess
{

    [DataMember]
    public int Status;

    [DataMember]
    public string FirstName;

    [DataMember]
    public string LastName;

    [DataMember]
    public string Image;

    [DataMember]
    public string userID;

    [DataMember]
    public string link;

    public LoginResponseSuccess()
    {

    }


 
    

}