using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using PostAround.ServiceContracts;
using PostAround.Logic;
using PostAround.Entities;
using PostAround.DAL.PostAroundMeDataSetTableAdapters;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Web.Caching;
using System.Text;
using System.Security.Cryptography;

/// <summary>
/// Summary description for ServiceImplementation
/// </summary>

public class PostAroundService : IPostAroundService
{
    enum EnumSortBy { Date, Distance, Popularity };
    private double ToRad(double value)
    {
        return value * Math.PI / 180;
   
    }




    private int CalcDistance(string currLat, string currLon, string toLat, string toLon)
    {
        if (string.IsNullOrEmpty(currLon) || string.IsNullOrEmpty(currLon) || string.IsNullOrEmpty(toLat) || string.IsNullOrEmpty(toLon))
        {
            return -1;
        }
        if (currLat.Equals(toLat) && currLon.Equals(toLon))
            return -2;

        double distance = -1;

        int earthRadius = 6371; // Radius of the earth in km
        
        double toRadCurrLat = 0;
        double toRadCurrLon = 0;

        double toRadToLat = 0;
        double toRadToLon = 0;

        double dLat = 0;
        double dLon = 0;

        if (Double.TryParse(toLat, out toRadToLat) && Double.TryParse(currLat, out toRadCurrLat))
        {
            dLat = ToRad(toRadToLat - toRadCurrLat);
        }

        if (Double.TryParse(toLon, out toRadToLon) && Double.TryParse(currLon, out toRadCurrLon))
        {
            dLon = ToRad(toRadToLon - toRadCurrLon);
        }

        if (dLat != 0 && dLon != 0)
        {
            double a = Math.Sin(dLat / 2) * Math.Sin(dLat / 2) +
                Math.Cos(ToRad(toRadCurrLat)) * Math.Cos(ToRad(toRadToLat)) *
                Math.Sin(dLon / 2) * Math.Sin(dLon / 2);

            double c = 2 * Math.Atan2(Math.Sqrt(a), Math.Sqrt(1 - a));

            double d = earthRadius * c * 1000; // Distance in m
            distance =  Math.Ceiling(d);
        }

        
        
        return Convert.ToInt32(distance);

    }

    private string TruncateAtWord(string input, int length)
    {
        if (input == null || input.Length < length)
            return input;
        int iNextSpace = input.LastIndexOf(" ", length);
        return string.Format("{0}...", input.Substring(0, (iNextSpace > 0) ? iNextSpace : length).Trim());
    }

    private Comment CommentTranslator(PostAroundMeDataSet.CommentsRow dr)
    {
        Comment comment = new Comment();
        
        comment.ID = dr.ID;
        comment.body = dr.Body;
        comment.date =  dr.Date;
        comment.strDate = comment.date.ToString("d MMM yyyy", new CultureInfo("en-us"));
        comment.strTime = comment.date.ToString("HH:mm", new CultureInfo("en-us"));
        comment.messageID = dr.MessageID;
        comment.userID = dr.UserID;
        comment.name = dr.Name;
        comment.commentUserLink = dr.link;
        comment.avatarImageUrl = dr.avatarImageUrl;
        comment.Mine = false;

        return comment;
    }

   
    private List<Comment> CommentsDtToList(PostAroundMeDataSet.CommentsDataTable dt, int userId, int timeZone)
    {
        //TimeZoneInfo pacificZone = TimeZoneInfo.Local; //.FindSystemTimeZoneById("Pacific Standard Time");
        //int UsTimeZone = pacificZone.BaseUtcOffset.Hours * -1;

        

        List<Comment> lstResults = new List<Comment>();
        Comment comment;
        foreach (PostAroundMeDataSet.CommentsRow dr in dt)
        {

            
            bool isPosterOrReplier = false;
            bool isPrivateComment = false;
            if (dr.isPrivate.Equals(true))
            {
                if (dr.UserID == userId)
                    isPosterOrReplier = true;
                else
                {
                    //Get PosterUserID
                    MyMessage mainMessage = GetMessageById(dr.MessageID, "", "", 0, 0, 0);
                    if (mainMessage.userid == userId)
                        isPosterOrReplier = true;
                }
            }
            if (dr.isPrivate.Equals(true) && !isPosterOrReplier)
            {
                // if it's a private message but the current user is not the poster or the replier - then skip this row.
                continue;
            }
            else if (dr.isPrivate.Equals(true) && isPosterOrReplier)
            {
                // if it's a private message AND the current user IS the poster or the replier - then Set this comment as private
                isPrivateComment = true;
            }

            comment = CommentTranslator(dr);

            DateTime commentDate;
            commentDate = dr.Date.AddHours(timeZone);
            comment.date = commentDate;
            comment.strDate = comment.date.ToString("d MMM yyyy", new CultureInfo("en-us"));
            comment.strTime = comment.date.ToString("HH:mm", new CultureInfo("en-us"));

            if (comment.userID == userId)
                comment.Mine = true;


            comment.isPrivate = isPrivateComment;


            lstResults.Add(comment);
        }

        return lstResults;
    }

    private string GetRelativeDate(DateTime dt)
    {
        var ts = new TimeSpan(DateTime.UtcNow.Ticks - dt.Ticks);
        double delta = Math.Abs(ts.TotalSeconds);

        if (delta < 60)
        {
            return ts.Seconds == 1 ? "one second ago" : ts.Seconds
                    + " seconds ago";
        }
        if (delta < 120)
        {
            return "a minute ago";
        }
        if (delta < 2700) // 45 * 60
        {
            return ts.Minutes + " minutes ago";
        }
        if (delta < 5400) // 90 * 60
        {
            return "an hour ago";
        }
        if (delta < 86400)
        { // 24 * 60 * 60
            return ts.Hours + " hours ago";
        }
        if (delta < 172800)
        { // 48 * 60 * 60
            return "yesterday";
        }
        if (delta < 2592000)
        { // 30 * 24 * 60 * 60
            return ts.Days + " days ago";
        }
        if (delta < 31104000)
        { // 12 * 30 * 24 * 60 * 60
            int months = Convert.ToInt32(Math.Floor((double)ts.Days / 30));
            return months <= 1 ? "one month ago" : months + " months ago";
        }
        int years = Convert.ToInt32(Math.Floor((double)ts.Days / 365));
        return years <= 1 ? "one year ago" : years + " years ago";
    }


    private MyMessage MessageTranslator(PostAroundMeDataSet.GetAllMessagesRow dr, string currLat, string currLon, int regionId, int timeZone, int userId)
    {
        //TimeZoneInfo pacificZone = TimeZoneInfo.Local; //.FindSystemTimeZoneById("Pacific Standard Time");
        //int UsTimeZone = pacificZone.BaseUtcOffset.Hours * -1;

        MyMessage msg = new MyMessage();
        DateTime msgDate;

        msgDate = dr.PostDate.AddHours(timeZone);

        msg.relativeDate = GetRelativeDate(dr.PostDate);
        msg.msgId = Convert.ToInt32(dr.ID);
        msg.latitude = dr.Latitude;
        msg.longitude = dr.Longitude;
        msg.category = dr.CategoryName;
        msg.catID = dr.CategoryID;
        msg.userid = Convert.ToInt32(dr.UserID);
        msg.Name = dr.Name;
        msg.title = dr.title;
        msg.description = dr.description;
        msg.userImage = dr.avatarImageUrl;
        msg.Date = msgDate.ToString("d MMM yyyy", new CultureInfo("en-us"));
        msg.Time = msgDate.ToString("HH:mm", new CultureInfo("en-us"));
        msg.type = Convert.ToInt32(dr.type);
        msg.CommentsNumber = dr.CommentsCounter;
        msg.Distance = CalcDistance(currLat, currLon, msg.latitude, msg.longitude);
        msg.Email = ""; //dr.Email; //.Replace("@", " AT ");
        msg.Phone1 = dr.Phone1;
        msg.Phone2 = dr.Phone2;
        msg.shortDescription = TruncateAtWord(msg.description, 64);
        msg.catColor = dr.CategoryColor;
        msg.ClassName = "";
        msg.image = dr.ImageUrl;
        msg.msgAddress = dr.address;
        msg.facebookID = dr.facebookID; // need to pull this from db
        msg.FullDate = msgDate;
        msg.link = dr.link;
        msg.Mine = false;
        if (msg.userid == userId)
            msg.Mine = true;
        
            

        if (msg.type == 2)
        {
            //msg.ClassName = "CommercialBox";
        }

        
        msg.totalShares = dr.TotalShares;

        return msg;
    }

   


    public bool IsReusable
    {
        get
        {
            return false;
        }
    }



    private List<MyMessage> MessagesTranslator(PostAroundMeDataSet.GetAllMessagesDataTable dt, string currLat, string currLon, int regionId, int timeZone, int userId)
    {
        List<MyMessage> lstResult = new List<MyMessage>();
        MyMessage msg;
        
        foreach (PostAroundMeDataSet.GetAllMessagesRow dr in dt)
        {
            msg = MessageTranslator(dr, currLat, currLon, regionId, timeZone, userId);
            lstResult.Add(msg);
        }
        return lstResult;
    }


    private List<BriefMessage> BriefMessagesTranslator(PostAroundMeDataSet.GetAllBriefMessagesDataTable dt)
    {
        List<BriefMessage> lstResult = new List<BriefMessage>();
        BriefMessage msg;

        foreach (PostAroundMeDataSet.GetAllBriefMessagesRow dr in dt)
        {
            msg = BriefMessageTranslator(dr);
            lstResult.Add(msg);
        }
        return lstResult;
    }



    private BriefMessage BriefMessageTranslator(PostAroundMeDataSet.GetAllBriefMessagesRow dr)
    {
        BriefMessage msg = new BriefMessage();

        msg.msgId = Convert.ToInt32(dr.ID);
        msg.latitude = dr.Latitude;
        msg.longitude = dr.Longitude;
        msg.catID =  Convert.ToInt32(dr.CategoryId);
        msg.FullDate = dr.PostDate;
        msg.Title = dr.Title;

        return msg;
    }




    private List<User> UserTranslator(PostAroundMeDataSet.UsersDataTable dt)
    {
        List<User> lstUsers = new List<User>();
        User user;
        foreach (PostAroundMeDataSet.UsersRow dr in dt)
        {
            user = new User();

            user.address = ""; // dr.address;
            user.avatarImageUrl = dr.avatarImageUrl;
            user.email = dr.email;
            user.firstName = dr.FirstName;
            user.lastName = dr.LastName;
            user.latidute = dr.Latidute;
            user.longtitude = dr.Longtitude;
            user.phone1 = dr.phone1;
            user.phone2 = dr.phone2;
            user.userID = dr.ID;
            user.link = dr.link;
            user.facebookID = dr.facebookID;
            
            lstUsers.Add(user);
        }
        return lstUsers;
    }



    public MyMessage GetMessageById(int msgId, string currLat, string currLon, int regionId, int timeZone, int userId)
    {

        GetAllMessagesTableAdapter messagesAdapter = new GetAllMessagesTableAdapter();
        PostAroundMeDataSet.GetAllMessagesDataTable dtResult = messagesAdapter.GetMessageByID(msgId);


        MyMessage msg = null;
        PostAroundMeDataSet.GetAllMessagesRow dr = dtResult.FirstOrDefault();
        if (dr != null)
        {
            msg = new MyMessage();
            msg = MessageTranslator(dr, currLat, currLon, regionId, timeZone, userId);
        }
        return msg;
    }


    public int UpdateMessageSharesByID(int msgId, int totalShares)
    {
        int res = 0;
        MessagesTableAdapter messagesAdapter = new MessagesTableAdapter();
        object obj = messagesAdapter.UpdateMessageSharesByID(msgId, totalShares);
        if (obj != null)
        {
            res = Convert.ToInt32(obj);
        }

        return res;
    }


    public List<MyMessage> GetMessagesByUserId(int userId, string currLat, string currLon, int regionId, int timeZone)
    {

        GetAllMessagesTableAdapter messagesAdapter = new GetAllMessagesTableAdapter();
        PostAroundMeDataSet.GetAllMessagesDataTable dtResult = messagesAdapter.GetMessageByUserID(userId);

        List<MyMessage> lstResult = new List<MyMessage>();

        lstResult = MessagesTranslator(dtResult, currLat, currLon, regionId, timeZone, userId);
 
        return lstResult;
    }




    public List<MyMessage> GetMessages(string currLat, string currLon, int userId, int skipNum, int takeNum, int isMine, List<int> lstCatID, int sotyBy, int timeZone = 0, int uptoMeters = -1, int regionId = 0)
    {
        
        PostAroundMeDataSet.GetAllMessagesDataTable dtResult = new PostAroundMeDataSet.GetAllMessagesDataTable();
        if (System.Web.HttpRuntime.Cache["Messages"] == null)
        {
            GetAllMessagesTableAdapter messagesAdapter = new GetAllMessagesTableAdapter();
            dtResult = messagesAdapter.GetAllMessage();
            System.Web.HttpRuntime.Cache.Insert("Messages", dtResult, null, System.Web.Caching.Cache.NoAbsoluteExpiration, TimeSpan.FromMinutes(10));
        }
        else
        {
            dtResult = System.Web.HttpRuntime.Cache["Messages"] as PostAroundMeDataSet.GetAllMessagesDataTable;
        }


        List<MyMessage> lstResult = new List<MyMessage>();

        lstResult = MessagesTranslator(dtResult, currLat, currLon, regionId, timeZone, userId);
        List<MyMessage> filteredResults = lstResult;


        if (uptoMeters >= 0)
        {
            filteredResults = (from a in filteredResults
                               where a.Distance < uptoMeters
                               select a).ToList();
        }

        if (isMine == 1)
        {
            // if isMine is flagged - show only my messages and ignore all other parameters.
            filteredResults = filteredResults.Where(m => m.Mine == true).ToList();
        }
        else
        {
            // filter by category
            if (lstCatID != null && lstCatID.Count > 0)
            {
                filteredResults = filteredResults.Where(m => lstCatID.Contains(m.catID)).ToList();
            }

            //sort by distance
            if (sotyBy == (int)EnumSortBy.Distance)
                filteredResults = filteredResults.OrderBy(m => m.Distance).ToList();
            else if (sotyBy == (int)EnumSortBy.Popularity)
                filteredResults = filteredResults.OrderByDescending(m => m.totalShares).ToList();
            

        }






        filteredResults = filteredResults.Skip(skipNum).Take(takeNum).ToList();
        return filteredResults;

 
    }

    public int DeleteComment(int commentId, int userid)
    {
        Object obj;
        int res = 0;
        CommentsTableAdapter commentsAdapter = new CommentsTableAdapter();
        obj = commentsAdapter.DeleteCommentByID(commentId, userid);
        if (obj != null)
        {
            res = Convert.ToInt32(obj);
            System.Web.HttpRuntime.Cache.Remove("Comments");
        }

        return res;
    }

    public int DeletePost(int msgId, int userid)
    {
        Object obj;
        int res = 0;
        MessagesTableAdapter messagesAdapter = new MessagesTableAdapter();
        obj = messagesAdapter.DeletePost(msgId, userid);
        if (obj != null)
        {
            res = Convert.ToInt32(obj);
            System.Web.HttpRuntime.Cache.Remove("Messages");
        }
        
        return res;

    }

    
    public int ActivateUserLoginByLoginID(int loginID, int userID)
    {
        LoginTableAdapter loginAdapter = new LoginTableAdapter();
        return loginAdapter.ActivateUserLoginByLoginID(loginID, userID);
    }



    public int CheckLoginData(LoginDetail data)
    {
        int res = -1;
        Object obj;
        try
        {
            LoginTableAdapter loginAdapter = new LoginTableAdapter();
            obj = loginAdapter.CheckLoginData(data.email, data.password);
            if (obj != null)
            {
                res = Convert.ToInt32(obj);
            }
        }
        catch (Exception ex)
        {
            EventLog.WriteEntry("Yaniv program", ex.Message, EventLogEntryType.SuccessAudit, 1);
        }
        return res;
    }

    public int InsertLoginDetails(LoginDetail data)
    {
        int res = -1;
        Object obj;
        try
        {
            LoginTableAdapter loginAdapter = new LoginTableAdapter();
            obj = loginAdapter.InsertLoginDetails(data.UserID, data.email, data.password);
            if (obj != null)
            {
                res = Convert.ToInt32(obj);
            }
        }
        catch (Exception ex)
        {
            EventLog.WriteEntry("Yaniv program", ex.Message, EventLogEntryType.SuccessAudit, 1);
        }
        return res;
    }


    public int InsertMessage(MyMessage msg)
    {
        int res = -1;
        Object obj;
        try
        {
            msg.FullDate = DateTime.UtcNow;
            MessagesTableAdapter messagesAdapter = new MessagesTableAdapter();
            obj = messagesAdapter.InsertMessage(msg.latitude, msg.longitude, msg.catID, msg.userid, msg.title, msg.description, msg.image, msg.FullDate, msg.type, msg.regionID, msg.msgAddress, msg.msgId);
            if (obj != null)
            {
                res = Convert.ToInt32(obj);
                System.Web.HttpRuntime.Cache.Remove("Messages");
            }
           
        }
        catch (Exception ex)
        {
            EventLog.WriteEntry("Yaniv program", ex.Message, EventLogEntryType.SuccessAudit, 1);
        }
        return res;
    }

    public int GetUserIdByFacebookId(string fid)
    {
        int retVal = 0;
        UsersTableAdapter usersAdapter = new UsersTableAdapter();
        Object obj = usersAdapter.GetUserIdByFacebookId(fid);
        if (obj != null)
            retVal = Convert.ToInt32(obj);
        return retVal;
    }

    public User GetUserByEmail(string email)
    {
        List<User> lstUsers = new List<User>();

        UsersTableAdapter usersAdapter = new UsersTableAdapter();
        PostAroundMeDataSet.UsersDataTable dtResult = usersAdapter.GetUserByEmail(email);

        lstUsers = UserTranslator(dtResult);

        return lstUsers.FirstOrDefault();
    }

    public User GetUserByID(int ID)
    {
        List<User> lstUsers = new List<User>();

        UsersTableAdapter usersAdapter = new UsersTableAdapter();
        PostAroundMeDataSet.UsersDataTable dtResult = usersAdapter.GetUserByID(ID);

        lstUsers = UserTranslator(dtResult);

        return lstUsers.FirstOrDefault();
    }

    public User GetCurrentUser(int ID)
    {
        List<User> lstUsers = new List<User>();

        UsersTableAdapter usersAdapter = new UsersTableAdapter();
        PostAroundMeDataSet.UsersDataTable dtResult = usersAdapter.GetUserByID(ID);

        lstUsers = UserTranslator(dtResult);
        lstUsers.FirstOrDefault().email = "";

        return lstUsers.FirstOrDefault();
    }

 

    public int InsertUpdateUser(User user)
    {
        int result = 0;
        
        UsersTableAdapter usersAdapter = new UsersTableAdapter();

        Object obj = usersAdapter.InsertUpdateUser(user.firstName, user.lastName, user.email, user.phone1, user.phone2, user.address, user.longtitude, user.latidute, user.avatarImageUrl, user.gender, user.facebookID, user.birthday, user.regDate, user.link, user.timezone, user.facebookToken);
        if (obj != null)
            result = Convert.ToInt32(obj);
        
        return result;
    }


    public int SetFeedback(Feedback feedback)
    {
        
        int result = 0;

        FeedbackTableAdapter adapter = new FeedbackTableAdapter();

        Object obj = adapter.SetFeedback(feedback.date, feedback.name, feedback.email, feedback.message);
        if (obj != null)
            result = Convert.ToInt32(obj);

        return result;

    }

    public Dictionary<int, string> GetAllCategories()
    {
        Dictionary<int, string> categories = new Dictionary<int, string>();
        CategoriesTableAdapter adapter = new CategoriesTableAdapter();

        PostAroundMeDataSet.CategoriesDataTable dt = new PostAroundMeDataSet.CategoriesDataTable();
        if (System.Web.HttpRuntime.Cache["Categories"] == null)
        {
            dt = adapter.GetAllCategories();
            System.Web.HttpRuntime.Cache.Insert("Categories", dt, null, System.Web.Caching.Cache.NoAbsoluteExpiration, TimeSpan.FromMinutes(10));
        }
        else
        {
            dt = System.Web.HttpRuntime.Cache["Categories"] as PostAroundMeDataSet.CategoriesDataTable;
        }

        categories = CategoryDtToDictionaryTranslator(dt);

        return categories;

    }

    public List<Category> GetListCategories()
    {
        List<Category> categories = new List<Category>();
        //Dictionary<int, string> categories = new Dictionary<int, string>();
        CategoriesTableAdapter adapter = new CategoriesTableAdapter();

        PostAroundMeDataSet.CategoriesDataTable dt = new PostAroundMeDataSet.CategoriesDataTable();
        if (System.Web.HttpRuntime.Cache["Categories"] == null)
        {
            dt = adapter.GetAllCategories();
            System.Web.HttpRuntime.Cache.Insert("Categories", dt, null, System.Web.Caching.Cache.NoAbsoluteExpiration, TimeSpan.FromMinutes(10));
        }
        else
        {
            dt = System.Web.HttpRuntime.Cache["Categories"] as PostAroundMeDataSet.CategoriesDataTable;
        }

        categories = CategoryTranslator(dt); // CategoryDtToDictionaryTranslator(dt);

        return categories;

    }

    private List<Category> CategoryTranslator(PostAroundMeDataSet.CategoriesDataTable dt)
    {

        List<Category> list = new List<Category>();
        Category item;
        foreach (PostAroundMeDataSet.CategoriesRow dr in dt)
        {
            item = new Category();

            item.ID = dr.ID;
            item.Name = dr.Name;
            item.Color = dr.Color;

            list.Add(item);
        }

        return list;
    }

    private Dictionary<int, string> CategoryDtToDictionaryTranslator(PostAroundMeDataSet.CategoriesDataTable dt)
    {
        Dictionary<int, string> retVal = new Dictionary<int, string>();

        foreach (PostAroundMeDataSet.CategoriesRow dr in dt)
        {
            retVal.Add(dr.ID, dr.Name);
        }
        return retVal;
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


    public CommentResult InsertComment(Comment comment)
    {
        CommentResult cr = new CommentResult();
        
        CommentsTableAdapter adapter = new CommentsTableAdapter();
        comment.date = DateTime.UtcNow;
        Object obj = adapter.InsertComment(comment.messageID, comment.userID, comment.body, comment.date, comment.isPrivate);
        if (obj != null)
        {
          
            System.Web.HttpRuntime.Cache.Remove("Comments");
            System.Web.HttpRuntime.Cache.Remove("Messages");
            cr.Id =  Convert.ToInt32(obj);
            cr.Key = Encrypt(cr.Id.ToString() + ".fgG43$#", true).Replace('+', '$'); ;
           
        }

        return cr;
    }

    public Comment GetCommentByID(int id)
    {
        Comment  comment = new  Comment();
        CommentsTableAdapter adapter = new CommentsTableAdapter();

        PostAroundMeDataSet.CommentsDataTable dt = new PostAroundMeDataSet.CommentsDataTable();
        dt = adapter.GetCommentByID(id);

        PostAroundMeDataSet.CommentsRow dr = dt.FirstOrDefault();

        comment = CommentTranslator(dr);

        return comment;
    }


    public List<Comment> GetCommentsByMessageID(int msgId, int userId, int timeZone = 0)
    {
        List<Comment> comments = new List<Comment>();
        CommentsTableAdapter adapter = new CommentsTableAdapter();

        PostAroundMeDataSet.CommentsDataTable dt = new PostAroundMeDataSet.CommentsDataTable();
        dt = adapter.GetCommentsByMessageID(msgId);

        comments = CommentsDtToList(dt, userId, timeZone);

        return comments;

    }


    public List<Comment> GetAllComments(int userId, int timeZone = 0)
    {
        List<Comment> comments = new List<Comment>();
        CommentsTableAdapter adapter = new CommentsTableAdapter();

        PostAroundMeDataSet.CommentsDataTable dt = new PostAroundMeDataSet.CommentsDataTable();


        if (System.Web.HttpRuntime.Cache["Comments"] == null)
        {
            dt = adapter.GetData();
            System.Web.HttpRuntime.Cache.Insert("Comments", dt, null, System.Web.Caching.Cache.NoAbsoluteExpiration, TimeSpan.FromMinutes(10));
        }
        else
        {
            dt = System.Web.HttpRuntime.Cache["Comments"] as PostAroundMeDataSet.CommentsDataTable;
        }

        comments = CommentsDtToList(dt, userId, timeZone);

        return comments;

    }

    public int CreateXmlSiteMap()
    {
        List<BriefMessage> bMessages = GetAllBriefMessages();

        CreateXmlFileFromStaticPages();
        int retVal = CreateXmlFile(bMessages);
        return retVal;

    }

    public void CreateJsonPostsDigest()
    {
        List<BriefMessage> bMessages = GetAllBriefMessages();
        string path = ConfigurationManager.AppSettings["PhysicalPath"];

        System.Web.Script.Serialization.JavaScriptSerializer oSerializer =
        new System.Web.Script.Serialization.JavaScriptSerializer();
        string sJSON = oSerializer.Serialize(bMessages);
        

        System.IO.File.WriteAllText(path + @"\Pages\json.txt", sJSON);
    }

    private List<BriefMessage> GetAllBriefMessages()
    {
        List<BriefMessage> bMessages = new List<BriefMessage>();
        GetAllBriefMessagesTableAdapter adapter = new GetAllBriefMessagesTableAdapter();

        PostAroundMeDataSet.GetAllBriefMessagesDataTable dt = new PostAroundMeDataSet.GetAllBriefMessagesDataTable();


        if (System.Web.HttpRuntime.Cache["BriefMessages"] == null)
        {
            dt = adapter.GetData();
            System.Web.HttpRuntime.Cache.Insert("BriefMessages", dt, null, System.Web.Caching.Cache.NoAbsoluteExpiration, TimeSpan.FromMinutes(10));
        }
        else
        {
            dt = System.Web.HttpRuntime.Cache["BriefMessages"] as PostAroundMeDataSet.GetAllBriefMessagesDataTable;
        }

        bMessages = BriefMessagesTranslator(dt);
        return bMessages;


    }

    public DateTime GetDateOfLastPost(string lat = "", string lon = "", int uptoMeters = -1)
    {

        List<MyMessage> msgs = GetMessages(lat, lon, 0, 0, 1, 0, null, 0, 0, uptoMeters, 0);
        return msgs.FirstOrDefault().FullDate;
       
    }

    private void CreateXmlFileFromStaticPages()
    {

        string path = ConfigurationManager.AppSettings["PhysicalPath"];

        string SiteUrl = ConfigurationManager.AppSettings["SiteUrl"];
        string xmlns = "http://www.sitemaps.org/schemas/sitemap/0.9";


        XNamespace ns = XNamespace.Get(xmlns);
        XElement xml = new XElement(ns + "urlset",

                            new XElement(ns + "url",
                                      new XElement(ns + "loc", SiteUrl),
                                      new XElement(ns + "lastmod", GetDateOfLastPost().ToString("yyyy-MM-ddThh:mm:sszzz")),
                                      new XElement(ns + "changefreq", "daily"),
                                      new XElement(ns + "priority", "1.0")),
                            new XElement(ns + "url",
                                      new XElement(ns + "loc", SiteUrl + "in/אוניברסיטת_תל_אביב"),
                                      new XElement(ns + "lastmod", GetDateOfLastPost("32.1112857", "34.8015036", 4000).ToString("yyyy-MM-ddThh:mm:sszzz")),
                                      new XElement(ns + "changefreq", "daily"),
                                      new XElement(ns + "priority", "0.8")),
                            new XElement(ns + "url",
                                      new XElement(ns + "loc", SiteUrl + "in/ביצרון"),
                                      new XElement(ns + "lastmod", GetDateOfLastPost("32.069798", "34.795407", 4000).ToString("yyyy-MM-ddThh:mm:sszzz")),
                                      new XElement(ns + "changefreq", "daily"),
                                      new XElement(ns + "priority", "0.8")),
                            new XElement(ns + "url",
                                      new XElement(ns + "loc", SiteUrl + "Taiwan/Taiwan-Receipt-Lottery-Checker.aspx"),
                                      new XElement(ns + "lastmod", GetDateOfLastPost().ToString("yyyy-MM-ddThh:mm:sszzz")),
                                      new XElement(ns + "changefreq", "daily"),
                                      new XElement(ns + "priority", "0.2")),
                            new XElement(ns + "url",
                                      new XElement(ns + "loc", SiteUrl + "Sitelinks.aspx"),
                                      new XElement(ns + "lastmod", GetDateOfLastPost().ToString("yyyy-MM-ddThh:mm:sszzz")),
                                      new XElement(ns + "changefreq", "daily"),
                                      new XElement(ns + "priority", "0.1"))
                                      );


        xml.Save(path + @"\XML\sitemap0.xml");
    }

    private int CreateXmlFile(List<BriefMessage> list)
    {
        int siteMapSize = 50000;
        int listCount = list.Count();
        int iterationsNum = Convert.ToInt32(Math.Ceiling((decimal)listCount / (decimal)siteMapSize));
        string SiteUrl = ConfigurationManager.AppSettings["SiteUrl"];
        string xmlns = "http://www.sitemaps.org/schemas/sitemap/0.9";
        int retVal = 1;
        string path = ConfigurationManager.AppSettings["PhysicalPath"];

        for (int i = 1; i <= iterationsNum; i++)
        {
            retVal = i;
            list.Take(siteMapSize * i);


            XNamespace ns = XNamespace.Get(xmlns);


            XElement xml = new XElement(ns + "urlset",
                                from p in list
                                select new XElement(ns + "url",
                                          new XElement(ns + "loc", SiteUrl + "post/" + p.msgId + "/" + p.Title.Replace(' ', '-')),
                                          new XElement(ns + "lastmod", p.FullDate.ToString("yyyy-MM-ddThh:mm:sszzz")),
                                          new XElement(ns + "changefreq", "weekly"),
                                          new XElement(ns + "priority", "0.8")

                                )

                        );

            xml.Save(string.Format(path + @"\XML\sitemap{0}.xml", i.ToString()));
        }
        return retVal;
    }


    public bool GetUserPermission(int userId, int permissionId)
    {
        bool retVal = false;

        UserPermissionsTableAdapter adapter = new UserPermissionsTableAdapter();
        Object obj = adapter.GetUserPermission(userId, permissionId);


        if (obj != null)
        {
            retVal = Convert.ToBoolean(obj);
        }

        return retVal;
    }


    public int SetUserPermission(UserPermission up)
    {
        int retVal = 0;

        UserPermissionsTableAdapter adapter = new UserPermissionsTableAdapter();
        Object obj = adapter.SetUserPermission(up.userId, up.permissionId, up.status);


        if (obj != null)
        {
            retVal = Convert.ToInt32(obj);
        }

        return retVal;
    }





        
        

 


}

 
