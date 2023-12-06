import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharethought/core/controllers/auth/model/usermodel.dart';
import 'package:sharethought/styles/kcolor.dart';
import 'package:sharethought/view/auth/login/state.dart';

import '../../common_widget/loading/k_circularloading.dart';
import '../../core/controllers/auth/login_controller.dart';
import '../../core/controllers/feed/feed_controller.dart';
import '../../model/post_model.dart';
import '../auth/userdata/user_data_provider.dart';
import '../home/post_card.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => FeedPageState();
}

class FeedPageState extends State<FeedPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kcolor.white,
      appBar: AppBar(
        title: Text("Feed Page"),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Kcolor.white,
        foregroundColor: Kcolor.baseBlack,
        actions: [
          Consumer(
            builder: (context,ref,_) {
              return CircleAvatar(
                radius: 30.0,
                child: Image.asset("assets/images/profilepic.png"),
              );
            }
          )
        ],
      ),
      body: Consumer(builder: (context, ref, _) {
        final userState = ref.watch(loginProvider);
        final userData =
            userState is LoginSuccessState ? userState.usermodel : null;
        final feedData = ref.watch(feedDataProvider);
        if (userData == null) {
          return const Center(child: Text("Not Found UserData"));
        } else {
          return feedData.when(data: (value) {
            if (value.isEmpty) {
              return Center(
                child: Container(
                    width: 30, height: 30, child: const KcircularLoading()),
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return PostCard(
                      postModelData: value[index],
                      index: index,
                      userData: userData);
                },
              );
            }
          }, loading: () {
            return const Center(
              child: KcircularLoading(),
            );
          }, error: (error, stack) {
            return const KcircularLoading();
          });
        }
      }),
    );
  }
}
