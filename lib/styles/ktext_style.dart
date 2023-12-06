import 'package:flutter/material.dart';
import 'package:sharethought/styles/kcolor.dart';

class ktextStyle {
  static TextStyle headline(Color color) {
    return TextStyle(
        color: color,
        fontSize: 35,
        fontWeight: FontWeight.w400,
        // fontFamily: 'ComicNeue');
        fontFamily: 'assets/fonts/ComicNeue-Regular.ttf');
  }

    static TextStyle buttonText20(Color color) {
    return TextStyle(
        color: color,
        fontSize:20 ,
        fontWeight: FontWeight.w700,
        letterSpacing: 1,
        // fontFamily: 'ComicNeue');
        fontFamily: 'assets/fonts/Roboto-bold.ttf');
  }

  static TextStyle buttonText24(Color color) {
    return TextStyle(
        color: color,
        fontSize:24 ,
        fontWeight: FontWeight.w700,
        letterSpacing: 2,
        // fontFamily: 'ComicNeue');
        fontFamily: 'assets/fonts/Roboto-bold.ttf');
  }




  static TextStyle subtitle(Color color) {
    return TextStyle(
        color: color,
        fontSize: 25,
        fontWeight: FontWeight.w400,
        fontFamily: 'ComicNeue');
  }

  static TextStyle font18(Color color) {
    return TextStyle(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.w400,
        fontFamily: 'ComicNeue');
  }
   static TextStyle font24(Color color) {
    return TextStyle(
        color: color,
        fontSize: 24,
        fontWeight: FontWeight.w400,
      fontFamily: 'ComicNeue');
  }
  static TextStyle font20(Color color) {
    return TextStyle(
        color: color,
        fontSize: 20,
        fontWeight: FontWeight.w400,
       fontFamily: 'ComicNeue');
  }

  static TextStyle title(Color color) {
    return TextStyle(
        color: color,
        fontSize: 25,
        fontWeight: FontWeight.w700,
        fontFamily: 'ComicNeue');
  }

  static TextStyle smallText(Color color) {
    return TextStyle(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.w500,
       fontFamily: 'ComicNeue');
  }

  static TextStyle mediumText(Color color) {
    return TextStyle(
        color: color,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'ComicNeue');
  }
}
