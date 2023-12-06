import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharethought/core/network/database_constant.dart';

class CommentModel{
  String commentId; 
  String userId; 
  String postId; 
  String profilePic; 
  String text; 
  String username; 
  List likes; 
  DateTime? date;

  CommentModel(this.commentId, this.userId,this.postId,this.profilePic,this.text,
  this.username,this.likes,this.date
  );


  factory CommentModel.fromSnap(DocumentSnapshot snap){
    final snapshot = snap.data() as Map<String,dynamic> ; 
    DateTime? date = snapshot[DatabaseConst.date]?.toDate();
    return CommentModel(
      snapshot[DatabaseConst.commentId]?? '', 
      snapshot[DatabaseConst.userId]?? '', 
      snapshot[DatabaseConst.postId]?? '', 
      snapshot[DatabaseConst.photoUrl]?? '', 
      snapshot[DatabaseConst.commentText]?? '', 
      snapshot[DatabaseConst.username]?? '', 
      snapshot[DatabaseConst.likes]?? [], 
      date
    );
  }

  static fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> doc) {}

}