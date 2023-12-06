import 'package:flutter/material.dart';

class KcircularLoading extends StatelessWidget {
  const KcircularLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(  
        width: 10, 
        height: 10,
        child:const  CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }
}