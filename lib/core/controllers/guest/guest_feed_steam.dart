import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/post_model.dart';
import '../../network/database_constant.dart';

final guestFeedStream =
    StreamProvider.family<List<PostModel>, String>((ref, guestUserId) {
  return FirebaseFirestore.instance
      .collection('posts')
      .where(DatabaseConst.userId, isEqualTo: guestUserId)
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((e) => PostModel.formSnap(e)).toList();
  });
});
