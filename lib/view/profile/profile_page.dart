import 'package:flutter/material.dart';
import 'package:sharethought/common_widget/post_list.dart';
import 'package:sharethought/styles/kcolor.dart';
import 'package:sharethought/styles/ksize.dart';
import 'package:sharethought/styles/ktext_style.dart';

import '../../common_widget/custom_back_button.dart';
import '../../route/route_generator.dart';

class Profile_Page extends StatelessWidget {
  final List<Map<String, String>> postList = [
    {
      "text": "this is new post",
      "image":
          "https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w600/2023/10/free-images.jpg"
    },
    {
      "text": "",
      "image":
          "https://img.freepik.com/free-photo/wide-angle-shot-single-tree-growing-clouded-sky-during-sunset-surrounded-by-grass_181624-22807.jpg?size=626&ext=jpg&ga=GA1.1.1826414947.1700438400&semt=sph"
    },
    {
      "text":
          "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like",
      "image": ""
    },
    {
      "text": "this is new post",
      "image":
          "https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w600/2023/10/free-images.jpg"
    },
  ];

  Profile_Page({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          child: Column(
            children: [
              topProfileSection(width, context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  topBottomText(number: "0", text: "post"),
                  topBottomText(number: "0", text: "followers"),
                  topBottomText(number: "0", text: "follow"),
                ],
              ),
              PostList(postList: postList, width: width)
              // PostList(postList: postList, width: width)
            ],
          ),
        ),
      ),
      drawer: MyDrawer(),
    );
  }

  Column topBottomText({required String number, required String text}) {
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

  Widget topProfileSection(double width, BuildContext context) {
    return SizedBox(
      width: width,
      height: Ksize.getHeight(context, width * .2),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          menuIcon(),
          profilePicture(),
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

  Widget profilePicture() {
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
                "Username",
                style: ktextStyle.mediumText(Kcolor.blackbg),
              ),
              const SizedBox(height: 10),
              Text(
                "online",
                style: ktextStyle.mediumText(Kcolor.black),
              ),
            ],
          )
        ],
      ),
    );
  }
}
// comment section 


class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            listTile(icon : Icon(Icons.settings), text: "Setting", onTap: (){}),
            listTile(icon: Icon(Icons.email_outlined), text: "Email"  , onTap: (){
              Navigator.pushNamed(context, RouteGenerator.addEmail);
            }
            ),
          ],
        ),
      ),
    );
  }

  ListTile listTile({required Icon icon,required String text,required VoidCallback onTap}) {
    return ListTile(
      leading: icon,
      title: Text(text),
      onTap: onTap,
    );
  }
}
