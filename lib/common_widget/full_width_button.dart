import 'package:flutter/material.dart';
import 'package:sharethought/styles/ksize.dart';
import 'package:sharethought/styles/ktext_style.dart';

import '../styles/kcolor.dart';

class FullWidthButton extends StatelessWidget {
  final String text; 
  final VoidCallback onTap; 
  const FullWidthButton({
    super.key, required this.text, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Ksize.getWidth(context, MediaQuery.of(context).size.width * .8),
        padding:const EdgeInsets.symmetric(vertical:15),
        alignment: Alignment.center,
       decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Kcolor.secondary, Color.fromARGB(255, 123, 33, 47)], 
            begin: Alignment.bottomCenter, 
            end: Alignment.topCenter
          ), 
          borderRadius: BorderRadius.circular(20.0)
        ),
      
       child:  Text(text,style:ktextStyle.mediumText(Kcolor.white))),
    );
  }
}

