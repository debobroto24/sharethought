import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sharethought/constants/shared_pref_data.dart';
import 'package:sharethought/core/base_state/base_state.dart';
import 'package:sharethought/core/controllers/auth/login_controller.dart';
import 'package:sharethought/core/network/database_constant.dart';
import 'package:uuid/uuid.dart';

import '../../../view/auth/userdata/user_data_provider.dart';
import '../../../view/createPost/state.dart';

final createPostProvider =
    StateNotifierProvider<CreatePostController, BaseState>((ref) {
  return CreatePostController(ref: ref);
});

class CreatePostController extends StateNotifier<BaseState> {
  final Ref? ref;
  CreatePostController({this.ref}) : super(const InitialState());

  createNewPost(
    foldername,
    List<XFile>? images,
    String text,
  ) async {
    if(await isNetworkAvailable()){
      try {
      state= const LoadingState();
      List<String> imageListUrl = [];
      // final String hl = await ref!.read(getUserProvider.future);
      final userdata = await ref!.read(loginProvider.notifier).getUserData();
      
      if (userdata != null) {
        if (images != null) {
          if (images.isNotEmpty) {
            imageListUrl = await uploadImage("post", images);
          }
        } //imgae not null
        if (text.isNotEmpty || imageListUrl.isNotEmpty) {
          Uuid uuid = Uuid();
          final postId = uuid.v1();
          await FirebaseFirestore.instance
              .collection(DatabaseConst.postCollection)
              .doc(postId)
              .set({
            DatabaseConst.postId: postId,
            DatabaseConst.username: userdata.username,
            DatabaseConst.likes: [],
            DatabaseConst.commentCount: 0,
            DatabaseConst.date: DateTime.now(), 
            DatabaseConst.description: text,
            DatabaseConst.userId: userdata.uid,
            DatabaseConst.photoUrlList: imageListUrl,
          });
          toast("Post Created Successfully.");
          state = CreatePostSuccessState("Post Created");
        } else {
          toast("Nothing to post!");
          state = CreatePostErrorState("Empty Content");
        }

        

        // print(" imagelist---end");
        // print(imageListUrl);
        // print(" imagelist---end");
      } // user check
    } catch (e) {
      toast("Something Went Wrong! in create post");
      state = CreatePostErrorState("Something Went Wrong!");
      print("something went wrong $e");
    }
    }// is network available
    else{
      toast("Please Check Your Internet Connection"); 
      state = CreatePostErrorState("Please Check Your Internet Connection");
    }
    
  }

  resetState(){
    state = const InitialState();
  }

  uploadImage(String folderName, List<XFile> images) async {
    List<String> imageDownloadUrlList = [];
    imageDownloadUrlList.clear();
    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      for (int i = 0; i < images.length; i++) {
        // i got here xfile so i have to convert it to file because firebas wants file
        File image = File(images[i].path);
        // create a unique filename
        String fileName = DateTime.now().microsecondsSinceEpoch.toString();

        // reference
        Reference reference = storage.ref().child(folderName).child(fileName);
        //upload images
        await reference.putFile(image);

        // get downlaod url
        String downloadUrl = await reference.getDownloadURL();
        imageDownloadUrlList.add(downloadUrl);
        print("upload images on firebase successfull");
      }
      return imageDownloadUrlList;
    } catch (e) {
      print("upload image to firebase storage error on $e");
    }
  }

  
}
