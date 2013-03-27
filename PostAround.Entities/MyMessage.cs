using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace PostAround.Entities
{
    [DataContract]
    public class MyMessage
    {
        [DataMember]
        public int msgId { get; set; }
        [DataMember]
        public string latitude { get; set; }
        [DataMember]
        public string longitude { get; set; }
        [DataMember]
        public string category { get; set; }
        [DataMember]
        public int catID { get; set; }
        [DataMember]
        public string catColor { get; set; }
        [DataMember]
        public int userid { get; set; }
        [DataMember]
        public string Name { get; set; }
        [DataMember]
        public string title { get; set; }
        [DataMember]
        public string shortDescription { get; set; }
        [DataMember]
        public string description { get; set; }
        [DataMember]
        public string image { get; set; }
        [DataMember]
        public DateTime FullDate { get; set; }
        [DataMember]
        public string Date { get; set; }
        [DataMember]
        public string Time { get; set; }
        [DataMember]
        public int type { get; set; }
        [DataMember]
        public int Distance { get; set; }
        [DataMember]
        public int CommentsNumber { get; set; }
        [DataMember]
        public int regionID { get; set; }
        [DataMember]
        public string Email { get; set; }
        [DataMember]
        public string Phone1 { get; set; }
        [DataMember]
        public string Phone2 { get; set; }
        [DataMember]
        public string ClassName { get; set; }
        [DataMember]
        public string userImage { get; set; }
        [DataMember]
        public Comment[] comments { get; set; }
        [DataMember]
        public int ImageHeight { get; set; }
        [DataMember]
        public string msgAddress { get; set; }
        [DataMember]
        public bool Mine { get; set; }
        [DataMember]
        public string link { get; set; }
        [DataMember]
        public int totalShares { get; set; }
        [DataMember]
        public string facebookID { get; set; }
         
        
        

        public MyMessage() { }


        //public MyMessage(string lat, string lon, int catID, int userID, string title, string description, string imageUrl, DateTime date, int type, int regionID)
        //{
        //    this.lat = lat;
        //    this.lon = lon;
        //    this.catID = catID;
        //    this.userID = userID;
        //    this.title = title;
        //    this.description = description;
        //    this.imageUrl = imageUrl;
        //    this.date = date;
        //    this.type = type;
        //    this.regionID = regionID;
        //}
    }


}

