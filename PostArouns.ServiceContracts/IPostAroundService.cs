using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ServiceModel;
using PostAround.Logic;
using PostAround.Entities;



namespace PostAround.ServiceContracts
{
    [ServiceContract]
    public interface IPostAroundService
    {
        [OperationContract]
        int CheckLoginData(LoginDetail data);

        [OperationContract]
        int InsertLoginDetails(LoginDetail data);

        [OperationContract]
        bool GetUserPermission(int userId, int permissionId);

        [OperationContract]
        int SetUserPermission(UserPermission up);

        [OperationContract]
        List<MyMessage> GetMessages(string currLat, string currLon, int userId, int skipNum, int takeNum, int isMine, List<int> lstCatID, int sotyBy, int timeZone, int uptoMeters, int regionID);

        [OperationContract]
        DateTime GetDateOfLastPost(string lat = "", string lon = "", int uptoMeters = -1);

        [OperationContract]
        int CreateXmlSiteMap();

        [OperationContract]
        void CreateJsonPostsDigest();

        [OperationContract]
        MyMessage GetMessageById(int msgId, string currLat, string currLon, int regionId, int timeZone, int userId);
        

        [OperationContract]
        List<MyMessage> GetMessagesByUserId(int userId, string currLon, string currLat, int regionId, int timeZone);

        [OperationContract]
        //int InsertMessage(string lat, string lon, int catID, int userID, string title, string description, string imageUrl, int type, int regionID, DateTime date);
        int InsertMessage(MyMessage msg);

        [OperationContract]
        User GetCurrentUser(int ID);

        [OperationContract]
        User GetUserByID(int ID);

        [OperationContract]
        User GetUserByEmail(string email);

        [OperationContract]
        int GetUserIdByFacebookId(string fid);

        [OperationContract]
        int InsertUpdateUser(User user);

        [OperationContract]
        int SetFeedback(Feedback feedback);

        [OperationContract]
        Dictionary<int,string> GetAllCategories();

        [OperationContract]
        List<Category> GetListCategories();

        [OperationContract]
        int UpdateMessageSharesByID(int msgId, int totalShares);

        [OperationContract]
        CommentResult InsertComment(Comment comment);

        [OperationContract]
        List<Comment> GetCommentsByMessageID(int id, int userId, int timeZone, int top);

        [OperationContract]
        Comment GetCommentByID(int id);

        [OperationContract]
        List<Comment> GetAllComments(int userId, int timeZone);

        [OperationContract]
        int DeletePost(int msgId, int userid);

        [OperationContract]
        int DeleteComment(int commentId, int userid);

        [OperationContract]
        int ActivateUserLoginByLoginID(int loginID, int userID);

    }
 

    
 
}
