import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharethought/core/controllers/auth/model/usermodel.dart';
import 'package:sharethought/core/controllers/comment/comment_service.dart';

import '../../common_widget/get_time.dart';
import '../../core/controllers/guest/guest_controller.dart';
import '../../model/post_model.dart';
import '../../route/argument_model_classes.dart';
import '../../route/route_generator.dart';
import '../../services/navigator_service.dart';
import '../../styles/kcolor.dart';
import '../../styles/ktext_style.dart';

class PostCard extends StatelessWidget {
  final PostModel postModelData;
  final int index;
  final UserModel userData;
  final bool isProfilePage; 
  const PostCard({
    super.key,
    required this.postModelData,
    required this.index,
    required this.userData,
    this.isProfilePage = false
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Consumer(
              builder: (context,ref,_) {
                return InkWell(
                  onTap: (){
                    if(!isProfilePage){
                       ref.read(guestProvider.notifier).getGeustData(postModelData.userId);
                      NavigatorService.navigateToRouteName(RouteGenerator.guestProfile);
                    }
                  },
                  child: CircleAvatar(
                      radius: 30.0,
                      child: Image.asset("assets/images/profilepic.png")),
                );
              }
            ),

            // user name
            title: Text(
              postModelData.userName,
              style: ktextStyle.font20(Kcolor.baseBlack),
            ),
            subtitle: Text(
              formatDateTime(postModelData.publisDate),
              style: ktextStyle.font18(Kcolor.blackbg),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert, size: 20),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      shrinkWrap: true, // shrinkWrap true work like span
                      children: ['Delete', 'Edit']
                          .map(
                            (e) => InkWell(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                child: Text(e),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                );
              },
            ),
          ),
          // text
          if (postModelData.description != null &&
              postModelData.description!.isNotEmpty) ...{
            Padding(
              padding: EdgeInsets.only(left: width * .1, right: width *.05),
              child: Text(
                postModelData.description!,
                style: ktextStyle.font18(Kcolor.black),
              ),
            )
          },

          const SizedBox(height: 10),

          // Image.asset(
          //   "assets/images/error-image.png",
          //   width:width,
          //   // fit: BoxFit.fitWidth,

          //   height: MediaQuery.of(context).size.height * .4,
          // ),

          const Divider(color: Kcolor.baseGrey),
          const Divider(
            color: Kcolor.baseBlack,
            indent: 20,
            endIndent: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Wrap(
              // Spacing between items
              // runSpacing: 8.0, // Spacing between lines
              children: [
                IconButton(onPressed: ()async{
                     await CommentService().likePost(postModelData, userData.uid);
                }, icon: Icon(
                  postModelData.likes!.contains(userData.uid)
                      ? Icons.favorite
                      : Icons.favorite_outline_outlined,
                  size: 30,
                )),
                Text(postModelData.likes!.length.toString()),
               const SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed("/commentsection", arguments: CommentSectionArguments(postModel: postModelData,userData: userData));
                  },
                  // child: Icon(Icons.comment_outlined, size: 30,)
                  child: Image.asset("assets/images/comment.png",
                      width: 30, height: 30),
                ),
                Text(postModelData.commentCount.toString()?? '0'),
              ],
            ),
          ),
          const Divider(
            color: Kcolor.baseBlack,
            indent: 20,
            endIndent: 20,
          )

          // Image.asset("assets/images/error-image.png")
        ],
      ),
    );
  }

  
}
