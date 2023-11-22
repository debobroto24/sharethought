import 'package:flutter/material.dart';
import 'package:sharethought/styles/kcolor.dart';
import 'package:sharethought/styles/ktext_style.dart';

class CommentSection extends StatefulWidget {
  const CommentSection({super.key});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Kcolor.baseBlack,
        title: Text("Comments"),
        backgroundColor: Kcolor.white,
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context,_) {
          return Padding( 
            padding: const EdgeInsets.only(top:20,left:20,right:20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 18.0,
                  child: Image.asset("assets/images/person.jpg", fit: BoxFit.contain,),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Column(
                      children: [
                        RichText(text: TextSpan(children: [
                          TextSpan(text: "username", style: ktextStyle.font18(Kcolor.baseBlack)), 
                          TextSpan(text: "This is my commnet don't you konw", style:  ktextStyle.smallText(Kcolor.blackbg))
                        ])), 
                        Padding(padding:const EdgeInsets.only(top:5),child: Row(
                          children: [
                            Text("1 Decemeber, 2023", style: ktextStyle.smallText(Kcolor.baseBlack),),
                            const SizedBox(width:10), 
                            Text("Likes 20", style: ktextStyle.smallText(Kcolor.baseBlack),),
                            
                          ],
                        ))
                      ],
                    ),
                  ),
                )
            
               
                ,Icon(Icons.favorite_outline_outlined, size: 30,)
              
              ],
            ),
          );
        }
      ),
    );
  }
}
