import 'package:flutter/material.dart';
import 'package:sharethought/common_widget/common_app_bar.dart';
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
      resizeToAvoidBottomInset: true,
      appBar: CommonAppBar(title: "Comments"), 
      body: Column(
        children: [
          AllComments(),
          _buildTextField(),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return Column(
      children: [
        Divider(color: Kcolor.grey350,), 

        Row(
          children: [
            Expanded(
                child: Container(
              child: TextField(
                
                maxLines: 3,
                decoration:const InputDecoration(
                  contentPadding: EdgeInsets.only(left:20),
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                    suffixIcon: InkWell(
                        child: Icon(
                      Icons.send_rounded,
                      color: Kcolor.secondary,
                    ))),
                
              ),
            ))
          ],
        ),
      ],
    );
  }
}

class AllComments extends StatelessWidget {
  const AllComments({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, _) {
              return CommentCard();
            }),
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  const CommentCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18.0,
            child: Image.asset(
              "assets/images/profilepic.png",
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "username ",
                        style: ktextStyle.font20(Kcolor.baseBlack)),
                    TextSpan(
                        text: "This is my commnet don't you konw",
                        style: ktextStyle.smallText(Kcolor.blackbg))
                  ])),
                  Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Text(
                            "1 Decemeber, 2023",
                            style: ktextStyle.smallText(Kcolor.baseBlack),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Likes 20",
                            style: ktextStyle.smallText(Kcolor.baseBlack),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
          Icon(
            Icons.favorite_outline_outlined,
            size: 30,
          )
        ],
      ),
    );
  }
}
