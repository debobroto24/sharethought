import 'package:flutter/material.dart';

class NavigatorService{
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<dynamic> navigateTo(Route route){
    return navigatorKey.currentState!.push(route); 
  }

  static Future<dynamic> navigateToReplacement(Route route){
    return navigatorKey.currentState!.pushReplacement(route); 
  }

  static Future<dynamic> navigateToRouteName(String routeName){
    return navigatorKey.currentState!.pushNamed(routeName); 
  }
  static Future<dynamic> navigateAndRemoveUntil(Route route){
    return navigatorKey.currentState!.pushAndRemoveUntil(route, (Route<dynamic> route) => false); 
  }

  static popNavigate({value}){
    return navigatorKey.currentState!.pop(value); 
  }
}