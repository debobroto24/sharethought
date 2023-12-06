import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sharethought/styles/kcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomSnackBar {
  
  // static final CustomSnackBar _instance = CustomSnackBar();

  // factory CustomSnackBar(){
  //   return _instance; 
  // }


  
  static showToast(String message,{Color bgColor = Kcolor.baseGrey, textColor=Kcolor.stickerColor}){
      Fluttertoast.showToast(msg: message, 
      gravity: ToastGravity.BOTTOM,
       backgroundColor: bgColor,
      textColor: textColor,
      fontSize: 16.0,
      toastLength: Toast.LENGTH_SHORT,
      );
  }
  // show anckbar method
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  showSnackBar(String message, {Color bgColor  = Kcolor.grey, Color textColor = Kcolor.stickerColor}){
    final snackBar = SnackBar(
        content: Center(child: Text(message)),
        backgroundColor: bgColor,
      );

    scaffoldMessengerKey.currentState!.showSnackBar(snackBar); 
  }
}