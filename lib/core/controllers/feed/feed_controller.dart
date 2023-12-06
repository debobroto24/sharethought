
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharethought/core/network/database_constant.dart';
import 'package:sharethought/model/post_model.dart';

// final postDataGet = FutureProvider<QuerySnapshot>((ref) async {
//   return await FirebaseFirestore.instance.collection("posts").get();
// });

final feedDataProvider = StreamProvider<List<PostModel>>((ref) {
  return FirebaseFirestore.instance.collection('posts').snapshots().map((snapshot) {
      return snapshot.docs.map((e) => PostModel.formSnap(e)).toList();
  });
  // if(data != null){
  //   print("stram data"); 
  //   for(int i = 0 ; )
  //   print(data.docs.length);
  //   return Stream.empty();
  // }else{
  //   print("empty stream");
  //   return Stream.empty();
  // }

});