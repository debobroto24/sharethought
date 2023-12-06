import 'package:nb_utils/nb_utils.dart';
import 'package:sharethought/core/network/database_constant.dart';

class SharedPrefData {

  static const PROFILEiMGAE = "profileimage"; 
  static const USERID = "userid"; 
  static const USERNAME = "username"; 

  email(String email) {
    SharedPreferences.getInstance().then((pref) {
      pref.getString(email);
    });
  }

  username(String username) {
    SharedPreferences.getInstance().then((pref) {
      pref.getString(username);
    });
  }

  contact(String contact) {
    SharedPreferences.getInstance().then((pref) {
      pref.getString(contact);
    });
  }

  //  toekn(String token){
  //   SharedPreferences.getInstance().then((pref){
  //     pref.getString(token);
  //   } );
  // }
  Future<void> removeDataFromSharedPreferences(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}

  Future<bool> setString(String value, String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }
   setBool(String key, bool booleanValue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, booleanValue);
  }

  Future<String> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  Future<bool> setUserId(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return  await prefs.setString(SharedPrefData.USERID, token);
  }

  Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return   prefs.getString(SharedPrefData.USERID) ?? '';
  }
}
