import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharethought/core/network/database_constant.dart';

class PostModel{
    static List<Map<String, String>> postList = [
    {
      "text": "this is new post",
      "image":
          "https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w600/2023/10/free-images.jpg"
    },
    {
      "text": "",
      "image":
          "https://img.freepik.com/free-photo/wide-angle-shot-single-tree-growing-clouded-sky-during-sunset-surrounded-by-grass_181624-22807.jpg?size=626&ext=jpg&ga=GA1.1.1826414947.1700438400&semt=sph"
    },
    {
      "text":
          "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like",
      "image": ""
    },
    {
      "text": "this is new post",
      "image":
          "https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w600/2023/10/free-images.jpg"
    },
  ];
  
  String description; 
  String postId; 
  String userId; 
  String userName;
  List photoUrlList;  
  List? likes;  
  int commentCount;  
  DateTime publisDate; 
  PostModel(this.description, this.postId, this.userId, this.userName, this.photoUrlList,this.likes,this.commentCount,this.publisDate);



  factory PostModel.formSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String,dynamic>; 
    DateTime date = snapshot[DatabaseConst.date]?.toDate();
    return PostModel(
      snapshot[DatabaseConst.description] ?? '',
      snapshot[DatabaseConst.postId] ?? '',
      snapshot[DatabaseConst.userId] ?? '',
      snapshot[DatabaseConst.username] ?? '',
      snapshot[DatabaseConst.photoUrlList] ?? [],
      snapshot[DatabaseConst.likes] ?? [],
      snapshot[DatabaseConst.commentCount] ?? [],
      date
      );
  }

}