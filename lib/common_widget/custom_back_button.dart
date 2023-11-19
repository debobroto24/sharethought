import 'package:flutter/material.dart';

import '../styles/kcolor.dart';

class customBackButton extends StatelessWidget {
  const customBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container( 
      padding: EdgeInsets.only(left:10), 
      alignment: Alignment.centerLeft,
      child: InkWell( 
        onTap: (){
          Navigator.pop(context);
        },
        child: Image.asset("assets/images/left-arrow-two.png", width: 30,color: Kcolor.secondary,)));
  }
}
