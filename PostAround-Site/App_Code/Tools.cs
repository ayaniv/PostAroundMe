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

/// <summary>
/// Summary description for Tools
/// </summary>
public static class Tools
{
    public static string CallUrl(string url)
    {
        string result = null;
        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
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


    public static bool IsDirectLink(HttpContext context)
    {
        return (context.Request.QueryString["id"] != null);
    }

    public static string SetUserIdInCookie(int userId, HttpContext context)
    {
        string encUserId = Tools.Encrypt(userId.ToString(), true).Replace('+', '$');
        // save encrypted userid in cookie
        HttpCookie userCookie = new HttpCookie("UserLogin");
        userCookie["userId"] = encUserId;
        userCookie.Expires = DateTime.Now.AddDays(7);
        context.Response.Cookies.Add(userCookie);
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

        byte[] encodedDataAsBytes

            = System.Convert.FromBase64String(encodedData);

        string returnValue =

           System.Text.Encoding.UTF8.GetString(encodedDataAsBytes);

        return returnValue;

    }



    

}