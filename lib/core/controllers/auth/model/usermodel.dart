import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../network/database_constant.dart';

class UserModel {
  String username;
  String photourl;
  String bio;
  bool isActive;
  String uid;
  List followers;
  List following;
  DateTime createdAt;
  UserModel(this.uid,this.username,this.isActive ,this.photourl,this.bio,this.followers,this.following,this.createdAt);

  Map<String, dynamic> toJson() {
    return {
      DatabaseConst.userId: uid,
      DatabaseConst.username: username,
      DatabaseConst.isActive: isActive,
      DatabaseConst.photourl: photourl,
      DatabaseConst.bio: bio,
      DatabaseConst.followers: followers,
      DatabaseConst.following: following,
      DatabaseConst.date: createdAt,
    };
  }

  factory UserModel.formSnap(DocumentSnapshot snap) {
    List emptyList = [];
    // print("insie model data");
    var snapshot = snap.data()! as Map<String, dynamic>;
    DateTime toDateTime = snapshot[DatabaseConst.date]?.toDate();
    // print( "userid : ${snapshot[DatabaseConst.userId]}");
    // print( "usename:  ${snapshot[DatabaseConst.username]}");
    // print( "isActive: ${snapshot[DatabaseConst.isActive]}");
    // print( "photourl: ${snapshot[DatabaseConst.photourl]}");
    // print( "bio: ${snapshot[DatabaseConst.bio]}");
    // print( "followers: ${snapshot[DatabaseConst.followers]}");
    // print( "following: ${snapshot[DatabaseConst.following]}");
    // print( "date : ${snapshot[DatabaseConst.date]}");
    // print("insie model data");
    try{
      return UserModel(
        snapshot[DatabaseConst.userId] ?? '',
        snapshot[DatabaseConst.username] ?? '',
        snapshot[DatabaseConst.isActive] ?? false,
        snapshot[DatabaseConst.photourl] ?? '',
        snapshot[DatabaseConst.bio] ?? '',
        snapshot[DatabaseConst.followers] ?? emptyList,
        snapshot[DatabaseConst.following] ?? emptyList,
        toDateTime
      );
    }catch(e){
      print("this model not working on return $e");
      rethrow;
    }
    
  }


  // static UserModel formSnap(DocumentSnapshot snap) {
  //   var snapshot = snap.data()! as Map<String, dynamic>;
  //   return UserModel(
  //     uid: snapshot[DatabaseConst.uid] ?? '',
  //     username: snapshot[DatabaseConst.username] ?? '',
  //     isActive: snapshot[DatabaseConst.isActive] ?? false,
  //     photourl: snapshot[DatabaseConst.photourl] ?? '',
  //     bio: snapshot[DatabaseConst.bio] ?? '',
  //     followers: snapshot[DatabaseConst.followers] ?? '',
  //     following: snapshot[DatabaseConst.following] ?? '',
  //     createdAt: snapshot[DatabaseConst.date],
  //   );
  // }
}
