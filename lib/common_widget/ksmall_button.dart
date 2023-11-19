import 'package:flutter/material.dart';
import 'package:sharethought/styles/ktext_style.dart';

import '../styles/kcolor.dart';

class KSmallButton extends StatelessWidget {
  final String text; 
  final VoidCallback onTap; 
  const KSmallButton({
    super.key, required this.text, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding:const EdgeInsets.symmetric(horizontal: 16,vertical:8),
       decoration: BoxDecoration(
          gradient:  LinearGradient(
            colors: [Kcolor.deleteColor, Color.fromARGB(255, 123, 33, 47)], 
            begin: Alignment.bottomCenter, 
            end: Alignment.topCenter
          ), 
          borderRadius: BorderRadius.circular(4.0)
        ),
      
       child:  Text(text,style:ktextStyle.smallText(Kcolor.white))),
    );
  }
}

