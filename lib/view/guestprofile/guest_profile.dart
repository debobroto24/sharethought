import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sharethought/common_widget/loading/k_circularloading.dart';
import 'package:sharethought/common_widget/post_list.dart';
import 'package:sharethought/core/base_state/base_state.dart';
import 'package:sharethought/core/controllers/auth/login_controller.dart';
import 'package:sharethought/core/controllers/profile/profile_controller.dart';
import 'package:sharethought/styles/kcolor.dart';
import 'package:sharethought/styles/ksize.dart';
import 'package:sharethought/styles/ktext_style.dart';
import 'package:sharethought/view/auth/login/login.dart';
import 'package:sharethought/view/auth/login/state.dart';
import 'package:sharethought/view/guestprofile/state.dart';
import 'package:sharethought/view/home/post_card.dart';

import '../../common_widget/custom_back_button.dart';
import '../../common_widget/dialog/k_confirm_dialog.dart';
import '../../core/controllers/guest/guest_controller.dart';
import '../../core/controllers/guest/guest_feed_steam.dart';
import '../../model/post_model.dart';
import '../../route/route_generator.dart';

class GuestProfile extends StatelessWidget {
  GuestProfile({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      body: Consumer(builder: (context, ref, _) {
        final userState = ref.watch(loginProvider);
        final userData =
            userState is LoginSuccessState ? userState.usermodel : null;
        final guestUserState = ref.watch(guestProvider);
        final guestUserData = guestUserState is GuestSuccessState ? guestUserState.GuestUserModel : null;
        if (guestUserState is LoadingState) {
          return const KcircularLoading();
        } else {
          if (guestUserData == null) {
            return const Center(child: Text("User not found"),);
          } else {
            final guestStream =
                ref.watch(guestFeedStream(guestUserData.uid));
            return SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                child: Column(
                  children: [
                    topProfileSection(width, context, guestUserData.username,
                        guestUserData.isActive, guestUserData.photourl),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        numberAndText(number: "0", text: "post"),
                        numberAndText(number: "0", text: "followers"),
                        numberAndText(number: "0", text: "follow"),
                      ],
                    ),
                    // PostList(postList: PostModel.postList, width: width)
                    // PostList(postList: postList, width: width)
                    guestStream.when(data: (allPost) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: allPost.length,
                        itemBuilder: (context, index) {
                          return PostCard(
                              postModelData: allPost[index],
                              index: index,
                              userData: guestUserData, 
                              isProfilePage: true,);
                          // return PostCard(postModelData:postDataList[index] ,index:index);
                        },
                      );
                    }, error: (e, stractace) {
                      return const KcircularLoading();
                    }, loading: () {
                      return const KcircularLoading();
                    })
                  
                  
                  ],
                ),
              ),
            );
          }
        }
      }),
    );
  }

  Column numberAndText({required String number, required String text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          number,
          style: ktextStyle.smallText(Kcolor.baseBlack),
        ),
        SizedBox(height: 10),
        Text(
          text,
          style: ktextStyle.smallText(Kcolor.baseBlack),
        )
      ],
    );
  }

  Widget topProfileSection(double width, BuildContext context, String username,
      bool isActive, String profileUrl) {
    return SizedBox(
      width: width,
      height: Ksize.getHeight(context, width * .2),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          menuIcon(),
          profilePicture(username, isActive, profileUrl),
        ],
      ),
    );
  }

  Widget menuIcon() {
    return Positioned(
      top: 40.0, // Adjust the position based on your layout
      right: 10.0,
      child: IconButton(
        icon: const Icon(Icons.menu, size: 30, color: Kcolor.baseBlack),
        onPressed: () {
          // Open the drawer
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
    );
  }

  Widget profileCover() {
    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(color: Kcolor.secondary),
    );
  }

  Widget profilePicture(String username, bool isActive, String profileUrl) {
    return Positioned(
      top: 30,
      left: 10,
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Kcolor.baseBlack),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: ktextStyle.mediumText(Kcolor.blackbg),
              ),
              const SizedBox(height: 10),
              Text(
                isActive ? "Online" : "Offline",
                style: ktextStyle.mediumText(Kcolor.black),
              ),
            ],
          )
        ],
      ),
    );
  }
}

