import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sharethought/common_widget/common_app_bar.dart';
import 'package:sharethought/constants/shared_pref_data.dart';
import 'package:sharethought/core/controllers/auth/login_controller.dart';
import 'package:sharethought/core/controllers/auth/model/usermodel.dart';
import 'package:sharethought/model/commnet_model.dart';
import 'package:sharethought/styles/kcolor.dart';
import 'package:sharethought/styles/ktext_style.dart';

import '../core/controllers/comment/comment_service.dart';
import '../model/post_model.dart';
import '../view/auth/userdata/user_data_provider.dart';
import 'get_time.dart';

class CommentSection extends StatefulWidget {
  final PostModel postModel;
  final UserModel userData; 
  const CommentSection({super.key, required this.postModel, required this.userData});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  late CommentService commentService;
  TextEditingController textcon = TextEditingController();
  // late UserModel userData ; 
  @override
  void initState() { 
    super.initState();
    commentService = CommentService();
    // getUserData(); 
  }
  // getUserData()async{
  //   userData = await getuserData();
  // }

  @override
  Widget build(BuildContext context) {
    print(widget.postModel.postId);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CommonAppBar(title: "Comments"),
      body: Column(
      children: [
          // AllComments(),
          Expanded(
            child: Consumer(builder: (context, ref, _) {
              final comments = ref
                  .watch(commentProvider(widget.postModel.postId));
                  // final authUserState = ref.watch(loginProvider);
                  // final data =  ref.read(loginProvider.notifier).getUserData();
                  
                
              // final comments = ref
              //     .watch(commentService.getComments(widget.postModel.postId));
              print(comments.value);
              return comments.when(
                data: (data) {
                if (data.isEmpty) {
                  return const Center(child: Text("emty data"));
                } else {
                  print("--insde ui data---");
                  print(data);
                  print("--insde ui data end-----");
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      // return ListTile(
                      //   title: Text(data[index].text),
                      //   // Add other widgets as needed
                      // );

                      return CommentCard(comment: data[index],userData: widget.userData);
                    },
                  );
                }
              }, error: (Object error, StackTrace stackTrace) {
                return const Center(child: Text("error"));
              }, loading: () {
                return const Center(child: Text("Loading..."));
              });
              // return SingleChildScrollView(
              //   child: ListView.builder(
              //       shrinkWrap: true,
              //       itemCount: 10,
              //       physics: const NeverScrollableScrollPhysics(),
              //       itemBuilder: (context, _) {
              //         return CommentCard();
              //       }),
              // );
            }),
          ),
          // _buildTextField(),

          Column(
            children: [
              Divider(
                color: Kcolor.grey350,
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    child: TextField(
                      controller: textcon,
                      maxLines: 3,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20),
                          border: const UnderlineInputBorder(
                              borderSide: BorderSide.none),
                          suffixIcon: InkWell(
                              onTap: () async {
                                if (textcon.text.isNotEmpty) {
                                  print("comment model printed");
                                  // CommentModel commentModel = CommentModel(
                                  //     '',
                                  //     widget.postModel.userId ?? '',
                                  //     widget.postModel.postId ?? '',
                                  //     '' ?? '',
                                  //     textcon.text,
                                  //     widget.postModel.userName ?? '',
                                  //     [],
                                  //     DateTime.now());

                                  CommentModel commentModel = CommentModel('',
                                   widget.userData.uid,  widget.postModel.postId ?? '',widget.userData.photourl ?? '', textcon.text, 
                                  widget.userData.username,
                                   [], DateTime.now());
                                  final container = ProviderContainer();
                                  final res = await commentService
                                      .addComment(commentModel);
                                  textcon.clear();
                                }
                              },
                              child: const Icon(
                                Icons.send_rounded,
                                color: Kcolor.secondary,
                              ))),
                    ),
                  ))
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return Column(
      children: [
        Divider(
          color: Kcolor.grey350,
        ),
        Row(
          children: [
            Expanded(
                child: Container(
              child: const TextField(
                maxLines: 3,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
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

class CommentCard extends StatelessWidget {
  final CommentModel comment;
  final UserModel userData;
  const CommentCard({
    super.key, required this.comment,required this.userData
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(children: [
                        // username 
                    TextSpan(
                        text: "${comment.username} ",
                        style: ktextStyle.font20(Kcolor.baseBlack)),
                        // comment text 
                    TextSpan(
                        text: comment.text,
                        style: ktextStyle.smallText(Kcolor.blackbg))
                  ])),
                  Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          // date time 
                          Text(
                           comment.date ==null ? "dateTime ": formatDateTime(comment.date!),
                            style: ktextStyle.smallText(Kcolor.baseBlack),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Likes ${comment.likes.length}",
                            style: ktextStyle.smallText(Kcolor.baseBlack),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: ()async{
               await CommentService().likeComment(comment,userData.uid);
              // if(!comment.likes.contains(userData.uid)){
              //   await CommentService().likeComment(comment, comment.likes,userData.uid);
              // }else{
              //   print("allready liked it"); 
              // }
            }, 
           icon: Icon(comment.likes.contains(userData.uid)?Icons.favorite : 
            Icons.favorite_outline_outlined,
            size: 30,
          ),),
        ],
      ),
    );
  }
}
