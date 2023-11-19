import 'package:flutter/material.dart';

class Ksize{
  static double getWidth(BuildContext context, width){
    return (((100/375) * width)/100) * MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context, height){
    return (((100/375) * height)/100) * MediaQuery.of(context).size.height;
  }
}