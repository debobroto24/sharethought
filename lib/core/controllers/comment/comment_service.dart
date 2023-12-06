import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sharethought/core/network/database_constant.dart';
import 'package:sharethought/model/commnet_model.dart';
import 'package:sharethought/model/post_model.dart';
import 'package:uuid/uuid.dart';

final commentProvider =
    StreamProvider.family<List<CommentModel>, String>((ref, postId) {
  return FirebaseFirestore.instance
      .collection(DatabaseConst.postCollection)
      .doc(postId)
      .collection(DatabaseConst.commentCollection)
      .orderBy(DatabaseConst.date, descending: true)
      .snapshots()
      .map((snapshot) {
    print(
        "Inside StreamProvider - Number of documents: ${snapshot.docs.length}");
    return snapshot.docs.map((e) {
      print(CommentModel.fromSnap(e).text);
      return CommentModel.fromSnap(e);
    }).toList();
  });
});

class CommentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StreamProvider<List<CommentModel>> getComments(String postId) {
    return StreamProvider<List<CommentModel>>((ref) {
      return FirebaseFirestore.instance
          .collection(DatabaseConst.postCollection)
          .doc(postId)
          .collection(DatabaseConst.commentCollection)
          .snapshots()
          .map((snapshot) {
        print(
            "Inside StreamProvider - Number of documents: ${snapshot.docs.length}");
        return snapshot.docs.map((e) {
          print(CommentModel.fromSnap(e).text);
          return CommentModel.fromSnap(e);
        }).toList();
      });
    });
  }

  Future<void> addComment(CommentModel comment) async {
    try {
      Uuid uuid = const Uuid();
      final commentId = uuid.v1();
      await _firestore
          .collection(DatabaseConst.postCollection)
          .doc(comment.postId)
          .collection(DatabaseConst.commentCollection)
          .doc(commentId)
          .set({
        DatabaseConst.postId: comment.postId,
        DatabaseConst.commentId: commentId,
        DatabaseConst.userId: comment.userId,
        DatabaseConst.likes: [],
        DatabaseConst.photoUrl: comment.profilePic,
        DatabaseConst.username: comment.username,
        DatabaseConst.commentText: comment.text,
        DatabaseConst.date: comment.date
      }).then((value) async {
        await _firestore
            .collection(DatabaseConst.postCollection)
            .doc(comment.postId)
            .update({DatabaseConst.commentCount: FieldValue.increment(1)});
      });
    } catch (e) {
      print(e);
      toast("Try Again!");
    }
  }

  Future<void> likeComment(
      CommentModel comment, String authUserId) async {
    try {


      if (comment.likes.contains(authUserId)) {
        await _firestore
            .collection(DatabaseConst.postCollection)
            .doc(comment.postId)
            .collection(DatabaseConst.commentCollection)
            .doc(comment.commentId)
            .update({
          DatabaseConst.likes: FieldValue.arrayRemove([authUserId])
        });
        print("like on comment done");
      } else {
        await _firestore
            .collection(DatabaseConst.postCollection)
            .doc(comment.postId)
            .collection(DatabaseConst.commentCollection)
            .doc(comment.commentId)
            .update({
          DatabaseConst.likes: FieldValue.arrayUnion([authUserId])
        });
        print("like on comment remove");
      }
    } catch (e) {
        print(e);
      toast("Try Again!");
    }
  }

  Future<void> likePost(PostModel postModel, String authUserId) async {
    try {
      Uuid uuid = const Uuid();
      final commentId = uuid.v1();

      if (postModel.likes!.contains(authUserId)) {
        await _firestore
            .collection(DatabaseConst.postCollection)
            .doc(postModel.postId)
            .update({
          DatabaseConst.likes: FieldValue.arrayRemove([authUserId])
        });

        print("like on post remove");
      } else {
        await _firestore
            .collection(DatabaseConst.postCollection)
            .doc(postModel.postId)
            .update({
          DatabaseConst.likes: FieldValue.arrayUnion([authUserId])
        });
        print("new like on post remove");
      }
    } catch (e) {
      toast("Try Again!");
    }
  }

  // ProviderFamily<void,CommentModel> addComment(){
  //   Uuid uuid = Uuid();
  //   return Provider.family<void, CommentModel>((ref,comment)async{
  //      print("inside add comment providecomment model printed");
  //     try{
  //        ref.state = AsyncValue.loading();
  //      final commentId = uuid.v1();
  //     final data =  await FirebaseFirestore.instance.collection(DatabaseConst.postCollection)
  //      .doc(comment.postId)
  //      .collection(DatabaseConst.commentCollection).doc(commentId)
  //      .set({
  //       DatabaseConst.postId : comment.postId,
  //       DatabaseConst.commentId: commentId,
  //       DatabaseConst.userId:comment.userId,
  //       DatabaseConst.photoUrl: comment.profilePic,
  //       DatabaseConst.username:comment.username,
  //       DatabaseConst.commentText: comment.text,
  //       DatabaseConst.date : comment.date
  //      });
  //      // ignore: void_checks
  //      ref.state =  AsyncValue.data(data);
  //     }catch(e){
  //       // ref.state = AsyncValue.error(e, stackTrace);
  //       print("commentNot working $e");
  //       toast("Comment not sent!");
  //     }
  //   });
  // }
}
