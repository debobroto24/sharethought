import 'package:flutter/material.dart';
import 'package:sharethought/styles/kcolor.dart';
import 'package:sharethought/styles/ksize.dart';
import 'package:sharethought/styles/ktext_style.dart';

import '../../common_widget/custom_back_button.dart';

class Profile_Page extends StatelessWidget {
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
              )
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

  SizedBox topProfileSection(double width, BuildContext context) {
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

  Positioned menuIcon() {
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

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Handle the onTap action for Home
                Navigator.pop(context);
              },
            ),
            listTile(context, Icon(Icons.settings), "Setting"),
            listTile(context, Icon(Icons.email_outlined), "Email"),
          ],
        ),
      ),
    );
  }

  ListTile listTile(BuildContext context, Icon icon, String text) {
    return ListTile(
      leading: icon,
      title: Text(text),
      onTap: () {
        // Handle the onTap action for Settings
        Navigator.pop(context);
      },
    );
  }
}
