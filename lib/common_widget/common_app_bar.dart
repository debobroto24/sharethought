import 'package:flutter/material.dart';
import 'package:sharethought/styles/kcolor.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title; 
  const CommonAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        foregroundColor: Kcolor.baseBlack,
        title: Text(title),
        backgroundColor: Kcolor.white,
      );

  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}