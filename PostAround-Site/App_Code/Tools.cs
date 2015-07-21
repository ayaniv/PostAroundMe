using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.IO;
using System.Text;
using System.Configuration;
using System.Security.Cryptography;
using System.Net.Mail;
using System.Threading;
using System.Globalization;
using PostAround.Entities;


/// <summary>
/// Summary description for Tools
/// </summary>
public static class Tools
{
    public static string GetFriendlyUrl(string siteUrl, string address, bool isSlugged) {
        if (address == null || address == "")
            return siteUrl;

        string format = "{0}in/{1}";
        string url = string.Format(format, siteUrl, isSlugged ? address : address.Slugify());
        return url;
    }

    public static string GetLocale(HttpContext context)
    {
        string lang = null;
        string lang_cookie = null;
        string lang_qs = context.Request.QueryString["lang"];
        HttpCookie cookie = context.Request.Cookies["i18next"];
        if (cookie != null)
        {
            lang_cookie = cookie.Value;
        }

        if (lang_qs != null && lang_qs != "")
        {
            lang = lang_qs;
        }
        else
        {
            if (lang_cookie != null && lang_cookie != "")
            {
                lang = lang_cookie;
            }
        }
        if (lang == null || lang == "")
        {
            var userLanguages = context.Request.UserLanguages;
            var ci = userLanguages.Count() > 0
                ? new CultureInfo(userLanguages[0])
                : CultureInfo.InvariantCulture;

            lang = ci.ToString();
        }
        return lang;

    }

    public static string GetQueryStringByKey(Uri uri, string key)
    {
        // this gets all the query string key value pairs as a collection
        var newQueryString = HttpUtility.ParseQueryString(uri.Query);

        // this returns the value if key exists
        return newQueryString.Get(key);

    }

    public static string RemoveQueryStringByKey(Uri uri, string key)
    {
        // this gets all the query string key value pairs as a collection
        var newQueryString = HttpUtility.ParseQueryString(uri.Query);

        // this removes the key if exists
        newQueryString.Remove(key);

        // this gets the page path from root without QueryString
        string pagePathWithoutQueryString = uri.GetLeftPart(UriPartial.Path);

        return newQueryString.Count > 0
            ? String.Format("{0}?{1}", pagePathWithoutQueryString, newQueryString)
            : pagePathWithoutQueryString;
    }

    public static string CallUrl(string url)
    {
        //Uri myUri = new Uri(url, UriKind.Absolute);
        string result = null;
        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(HttpUtility.UrlDecode(url));
        HttpWebResponse response = (HttpWebResponse)request.GetResponse();
        if (response.StatusCode.Equals(HttpStatusCode.OK))
        {
            Stream receiveStream = response.GetResponseStream();
            StreamReader readStream = new StreamReader(receiveStream, Encoding.UTF8);
            result = readStream.ReadToEnd();
        }

        return result;
    }

    public static void Logger(string errMsg, string where)
    {
        string path = ConfigurationManager.AppSettings["PhysicalPath"] + "Pages\\log.txt";


        string strLogText = errMsg;
        //string path =  @"C:\eWaveProjects\BezeqStore\Zibaba\Logs\log.txt"; // "C:\data\sites\XBezeqZibaba\Logs\log.txt";
        // Create a writer and open the file:
        StreamWriter log;

        if (!File.Exists(path))
        {
            log = new StreamWriter(path);
        }
        else
        {
            log = File.AppendText(path);
        }

        // Write to the file:
        log.WriteLine(DateTime.Now);
        log.WriteLine("error in fuction: '" + where + "' :");
        log.WriteLine(strLogText);
        log.WriteLine();

        // Close the stream:
        log.Close();
    }

    public static string HashIt(string toBeHashed)
    {
        string hashedValue = "";
        //string key = ConfigurationManager.AppSettings["EncryptKey"];
        //toBeHashed = key + toBeHashed;

        SHA256 alg = SHA256.Create();
        alg.ComputeHash(Encoding.UTF8.GetBytes(toBeHashed));
        hashedValue = BitConverter.ToString(alg.Hash);

        return hashedValue;
    }


    public static string Encrypt(string toEncrypt, bool useHashing)
    {
        byte[] keyArray;
        byte[] toEncryptArray = UTF8Encoding.UTF8.GetBytes(toEncrypt);

        string key = ConfigurationManager.AppSettings["EncryptKey"];
        //System.Windows.Forms.MessageBox.Show(key);
        //If hashing use get hashcode regards to your key
        if (useHashing)
        {
            MD5CryptoServiceProvider hashmd5 = new MD5CryptoServiceProvider();
            keyArray = hashmd5.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));
            //Always release the resources and flush data
            // of the Cryptographic service provide. Best Practice

            hashmd5.Clear();
        }
        else
            keyArray = UTF8Encoding.UTF8.GetBytes(key);

        TripleDESCryptoServiceProvider tdes = new TripleDESCryptoServiceProvider();
        //set the secret key for the tripleDES algorithm
        tdes.Key = keyArray;
        //mode of operation. there are other 4 modes.
        //We choose ECB(Electronic code Book)
        tdes.Mode = CipherMode.ECB;
        //padding mode(if any extra byte added)

        tdes.Padding = PaddingMode.PKCS7;

        ICryptoTransform cTransform = tdes.CreateEncryptor();
        //transform the specified region of bytes array to resultArray
        byte[] resultArray =
            cTransform.TransformFinalBlock(toEncryptArray, 0,
            toEncryptArray.Length);
        //Release resources held by TripleDes Encryptor
        tdes.Clear();
        //Return the encrypted data into unreadable string format
        return Convert.ToBase64String(resultArray, 0, resultArray.Length);
    }

    public static string Decrypt(string cipherString, bool useHashing)
    {
        byte[] keyArray;
        //get the byte code of the string

        byte[] toEncryptArray = Convert.FromBase64String(cipherString);


        string key = ConfigurationManager.AppSettings["EncryptKey"];

        if (useHashing)
        {
            //if hashing was used get the hash code with regards to your key
            MD5CryptoServiceProvider hashmd5 = new MD5CryptoServiceProvider();
            keyArray = hashmd5.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));
            //release any resource held by the MD5CryptoServiceProvider

            hashmd5.Clear();
        }
        else
        {
            //if hashing was not implemented get the byte code of the key
            keyArray = UTF8Encoding.UTF8.GetBytes(key);
        }

        TripleDESCryptoServiceProvider tdes = new TripleDESCryptoServiceProvider();
        //set the secret key for the tripleDES algorithm
        tdes.Key = keyArray;
        //mode of operation. there are other 4 modes. 
        //We choose ECB(Electronic code Book)

        tdes.Mode = CipherMode.ECB;
        //padding mode(if any extra byte added)
        tdes.Padding = PaddingMode.PKCS7;

        ICryptoTransform cTransform = tdes.CreateDecryptor();
        byte[] resultArray = cTransform.TransformFinalBlock(
                             toEncryptArray, 0, toEncryptArray.Length);
        //Release resources held by TripleDes Encryptor                
        tdes.Clear();
        //return the Clear decrypted TEXT
        return UTF8Encoding.UTF8.GetString(resultArray);
    }

    public static int GetUserIdFromCookie(HttpContext context)
    {
        int userId = 0;
        HttpCookie cookie = context.Request.Cookies["UserLogin"];

        if (cookie != null)
        {
            if (!string.IsNullOrEmpty(cookie["userId"]))
            {
                string encUserId = cookie["userId"];
                encUserId = encUserId.Replace('$', '+');
                string strUserId = Tools.Decrypt(encUserId, true);
                Int32.TryParse(strUserId, out userId);
            }
        }

        return userId;
 
    }

    public static string Capitalize(string s)
    {
        return char.ToUpper(s[0]) + s.Substring(1).ToLower();
    }

    public static bool InputCheck(string whatToCheck, string regexValidate)
    {
        return true;
    }


    public static bool IsDirectLink(HttpContext context)
    {
        bool hasQueryStringID = (context.Request.QueryString["id"] != null);
        bool isTaiwan = (HttpContext.Current.Request.Url.AbsoluteUri.ToLower().Contains("taiwan-receipt-lottery-checker.aspx"));
        return (hasQueryStringID || isTaiwan);
    }

    public static string GetProtocol(HttpContext context)
    {
        Uri uri  = new Uri(context.Request.Url.AbsoluteUri);
        string protocol = uri.Scheme;
        return protocol;
    }

    public static string SetUserIdInCookie(int userId, HttpContext context)
    {
        string encUserId = null;
        try
        {
            encUserId = Tools.Encrypt(userId.ToString(), true).Replace('+', '$');
            // save encrypted userid in cookie
            HttpCookie userCookie = new HttpCookie("UserLogin");
            userCookie["userId"] = encUserId;
            userCookie.Expires = DateTime.Now.AddDays(7);
            context.Response.Cookies.Add(userCookie);
        }
        catch (Exception ex) { }

        return encUserId;

    }

    public static string EncodeTo64(string toEncode)
    {

        byte[] toEncodeAsBytes

              = System.Text.Encoding.UTF8.GetBytes(toEncode);

        string returnValue

              = System.Convert.ToBase64String(toEncodeAsBytes);

        return returnValue;

    }

    public static string DecodeFrom64(string encodedData)
    {
        try
        {
            byte[] encodedDataAsBytes

                = System.Convert.FromBase64String(encodedData);

            string returnValue =

               System.Text.Encoding.UTF8.GetString(encodedDataAsBytes);

            return returnValue;
        }
        catch (Exception ex)
        {
            return "";
        }
    }


  

    

}