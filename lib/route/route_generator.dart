

import 'package:flutter/material.dart';
import 'package:sharethought/view/auth/login.dart';
import 'package:sharethought/view/auth/signup.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments; 
    switch(settings.name){
      
      case "/login" : 
        return MaterialPageRoute(builder: (_)=> Login());

      // sign up 
      case "/signup" : 
        return MaterialPageRoute(builder: (_)=> SignUp());
      
       default: 
        return  MaterialPageRoute(builder: (_)=> Login());
    }
  }


}