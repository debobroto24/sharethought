import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharethought/constants/shared_pref_data.dart';
import 'package:sharethought/core/controllers/auth/model/usermodel.dart';

import '../../../core/controllers/auth/login_controller.dart';
import '../../../core/network/database_constant.dart';
import '../../../core/network/network_util.dart';


Future<UserModel> getAuthUserData() async {
  try {
    if (await isNetworkAvabilable()) {
      //  ref.read(loginProvider.notifier).getUserData();
      final userId = await SharedPrefData().getUserId();
      print("user id is $userId");
      
      if (userId.isNotEmpty) {
        print(userId);
      }

      final firestore = FirebaseFirestore.instance;
      final querySnapshot = await firestore
          .collection(DatabaseConst.users)
          .where(DatabaseConst.userId, isEqualTo: userId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return UserModel.formSnap(querySnapshot.docs[0]);
      } else {
        throw "error"; 
      }
    } else {
      print("No internet connection!");
      throw "error";
    }
  } catch (e) {
    print("Error fetching user data: $e");
    throw e ; 
  }
}





// final commentIdProvider = Provider<String>((ref) {
//   // Replace with your logic to get the comment ID
//   return 'your_dynamic_post_id';
// });

// final commentsProvider = FutureProvider<List<Comment>, String>((ref, id) async {
//   final firestore = ref.read(firebaseProvider);
//   final querySnapshot = await firestore.collection('comments').where('postId', isEqualTo: id).get();

//   // Convert QuerySnapshot to a List<Comment>
//   return querySnapshot.docs.map((doc) => Comment.fromMap(doc.data())).toList();
// });

// void fetchData() {
//   final container = ProviderContainer();
  
//   // Retrieve the comment ID
//   final commentId = container.read(commentIdProvider);

//   // Retrieve the data using the comment ID
//   final comments = container.read(commentsProvider(commentId));

//   // Now, you can work with the comments data
//   comments.when(
//     data: (commentsData) {
//       // Handle the list of comments
//       print(commentsData);
//     },
//     loading: () {
//       // Handle loading state
//       print('Loading...');
//     },
//     error: (error, stackTrace) {
//       // Handle error state
//       print('Error: $error');
//     },
//   );
// }