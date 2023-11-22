import 'package:flutter/material.dart';
import 'package:sharethought/styles/kcolor.dart';

class ktextStyle {
  static TextStyle headline(Color color) {
    return TextStyle(
        color: color,
        fontSize: 35,
        fontWeight: FontWeight.w400,
        fontFamily: 'Arimo');
  }



  static TextStyle subtitle(Color color) {
    return TextStyle(
        color: color,
        fontSize: 25,
        fontWeight: FontWeight.w400,
        fontFamily: 'Arimo');
  }

  static TextStyle font18(Color color) {
    return TextStyle(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto');
  }
  static TextStyle font20(Color color) {
    return TextStyle(
        color: color,
        fontSize: 20,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto');
  }

  static TextStyle title(Color color) {
    return TextStyle(
        color: color,
        fontSize: 25,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto');
  }

  static TextStyle smallText(Color color) {
    return TextStyle(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Arimo');
  }

  static TextStyle mediumText(Color color) {
    return TextStyle(
        color: color,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Arimo');
  }
}
