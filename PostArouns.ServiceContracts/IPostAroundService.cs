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
        bool GetUserPermission(int userId, int permissionId);

        [OperationContract]
        int SetUserPermission(UserPermission up);

        [OperationContract]
        List<MyMessage> GetMessages(string currLat, string currLon, int userId, int skipNum, int takeNum, int isMine, int catID, int sotyBy, int timeZone, int uptoMeters, int regionID);

        [OperationContract]
        List<BriefMessage> GetAllBriefMessages();

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
        int InsertUpdateUser(User user);

        [OperationContract]
        int SetFeedback(Feedback feedback);

        [OperationContract]
        Dictionary<int,string> GetAllCategories();

        [OperationContract]
        List<Category> GetListCategories();

        [OperationContract]
        int InsertComment(Comment comment);

        [OperationContract]
        List<Comment> GetCommentsByMessageID(int id, int userId, int timeZone);

        [OperationContract]
        List<Comment> GetAllComments(int userId, int timeZone);

        [OperationContract]
        int DeletePost(int msgId, int userid);

        [OperationContract]
        int DeleteComment(int commentId, int userid);

    }
 

    
 
}
