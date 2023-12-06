import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sharethought/core/network/database_constant.dart';
import 'package:sharethought/model/post_model.dart';

import '../../../view/profile/state.dart';
import '../../base_state/base_state.dart';
import '../auth/login_controller.dart';


// here passing a userId as string 
final profileStreamProvider =
    StreamProvider.family<List<PostModel>, String>((ref, userId) {
  return FirebaseFirestore.instance
      .collection('posts')
      .where(DatabaseConst.userId, isEqualTo: userId)
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((e) => PostModel.formSnap(e)).toList();
  });
});

final createPostProvider =
    StateNotifierProvider<CreatePostController, BaseState>((ref) {
  return CreatePostController(ref: ref);
});

class CreatePostController extends StateNotifier<BaseState> {
  final Ref? ref;
  CreatePostController({this.ref}) : super(const InitialState());
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  updateProfile(
    XFile? image,
    String userId,
    
  ) async {
    if(await isNetworkAvailable()){
      try {
      state= const LoadingState();
      String imageUrl = "";
      // final String hl = await ref!.read(getUserProvider.future);
      final userdata = await ref!.read(loginProvider.notifier).getUserData();
     
        if (image != null) {
            imageUrl = await uploadProfileToFirebaseStorage(image);
            if(imageUrl.isNotEmpty){
              await firestore.collection(DatabaseConst.users).doc(userId).update({
                DatabaseConst.photourl: imageUrl
              }).then((value) => state= ProfileSuccessState()).catchError((e){
                state =  ProfileErrorState("Profile not updated! Please try again.");
              });
            }else{
              toast("Profile not updated! Please try again.");
              state = ProfileErrorState("Profile not updated! Please try again.");
            }
        } //imgae not null
        else{
           print("Please select image!");
        }
        
    // user check
    } catch (e) {
      toast("Something Went Wrong! in create post");
      state = ProfileErrorState("Something Went Wrong!");
      print("something went wrong $e");
    }
    }// is network available
    else{
      toast("Please Check Your Internet Connection"); 
      state = ProfileErrorState("Please Check Your Internet Connection");
    }
    
  }

  resetState(){
    state = const InitialState();
  }

  uploadProfileToFirebaseStorage(XFile image) async {
    List<String> imageDownloadUrlList = [];
    imageDownloadUrlList.clear();
    
    try {
      File imageFile = File(image.path);
      String fileName = DateTime.now().microsecondsSinceEpoch.toString();

      Reference reference = storage.ref().child(DatabaseConst.profileFolder).child(fileName);
      await reference.putFile(imageFile);

      String downloadUrl = await reference.getDownloadURL();
      return downloadUrl ?? '';
    } catch (e) {
      print("upload image to firebase storage error on $e");
    }
  }

  
}
