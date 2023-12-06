import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sharethought/constants/shared_pref_data.dart';
import 'package:sharethought/constants/value_constant.dart';
import 'package:sharethought/core/base_state/base_state.dart';
import 'package:sharethought/core/controllers/auth/model/usermodel.dart';
import 'package:sharethought/core/network/database_constant.dart';
import 'package:sharethought/core/network/network_util.dart';
import 'package:sharethought/route/route_generator.dart';
import 'package:sharethought/services/navigator_service.dart';
import 'package:sharethought/view/auth/login/state.dart';

final loginProvider = StateNotifierProvider<LoginController, BaseState>(
    (ref) => LoginController(ref: ref));

class LoginController extends StateNotifier<BaseState> {
  final Ref? ref;
  LoginController({this.ref}) : super(const InitialState());
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> login(
      {required String username, required String password}) async {
    state = LoadingState();
    if (await isNetworkAvabilable()) {
      try {
        QuerySnapshot querySnapshot = await firestore
            .collection('users')
            .where(DatabaseConst.username, isEqualTo: username)
            .limit(1)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot documentSnapshot = querySnapshot.docs[0];
          Map<String, dynamic> userData =
              documentSnapshot.data() as Map<String, dynamic>;
          String storedUsername = userData[DatabaseConst.username];
          String storedPassword = userData[DatabaseConst.password];
          String uid = userData[DatabaseConst.userId];
          print(storedPassword);
          print("========");
          if (userData[DatabaseConst.password] == password) {
            print("usermodel text");
            // print(UserModel.formSnap(userData[0]));
            toast("Login Successfull!");
            await SharedPrefData().setUserId(uid);
            await SharedPrefData().setBool(DatabaseConst.isLoggedIn, true);
            
            state =
                LoginSuccessState(UserModel.formSnap(querySnapshot.docs[0]));
            NavigatorService.navigateToRouteName(RouteGenerator.home);
          } else {
            toast("Plesase Enter Correct Password");
          }
        } else {
          toast("Plesase Enter Correct Username");
        }
      } catch (e) {
        state = ErrorState();
        toast("Something went wrong!");
      }
    } else {
      state = ErrorState();
      toast("No Internet Connection!");
    }
  }
  // not using now
   Future<UserModel?> getUserData() async {
    state = LoadingState();
    try {
      if (await isNetworkAvabilable()) {
        final userid = await SharedPrefData().getUserId();
        print("user id is $userid");
        if (userid.isNotEmpty) {
          print(userid);
        }
        
        QuerySnapshot querySnapshot = await firestore
            .collection(DatabaseConst.users)
            .where(DatabaseConst.userId, isEqualTo: userid)
            .limit(1)
            .get();
        if(querySnapshot.docs.isNotEmpty){
         
            UserModel usermodel = UserModel.formSnap(querySnapshot.docs[0]);
             state = LoginSuccessState(usermodel);
        return usermodel;
        }else{
          state = LoginErrorState("no User Found"); 
          NavigatorService.navigateToRouteName(RouteGenerator.login); 
           throw UserNotFoundException("User not found");
        }
      
      } else {
       
        toast("Something Went Wrong");
        //  return null; 
         throw NetworkErrorException("Network error");
      }
    } catch (e) {
      toast("Something Went Wrong");
      //  throw "error";
      throw AppErrorException("An error occurred");
    }
  }

  logout()async{
    await SharedPrefData().removeDataFromSharedPreferences(SharedPrefData.USERID);
    await SharedPrefData().removeDataFromSharedPreferences(DatabaseConst.isLoggedIn);
    await NavigatorService.navigateToRouteName(RouteGenerator.login);
  }


}


class UserNotFoundException implements Exception {
  final String message;
  UserNotFoundException(this.message);
}

class NetworkErrorException implements Exception {
  final String message;
  NetworkErrorException(this.message);
}

class AppErrorException implements Exception {
  final String message;
  AppErrorException(this.message);
}
