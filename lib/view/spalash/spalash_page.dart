import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharethought/view/auth/userdata/user_data_provider.dart';
import 'package:sharethought/view/home/home_page.dart';

import '../../common_widget/loading/k_circularloading.dart';
import '../../constants/shared_pref_data.dart';
import '../../constants/value_constant.dart';
import '../../core/controllers/auth/login_controller.dart';
import '../auth/login/login.dart';

class SpalashScreen extends StatefulWidget {
  const SpalashScreen({super.key});

  @override
  State<SpalashScreen> createState() => _SpalashScreenState();
}

class _SpalashScreenState extends State<SpalashScreen> {
  // Future<bool> checkLoginStatus() async {
  //   final token = await SharedPrefData().getUserId();
  //   if (token == null || token.isEmpty) {
  //      ref.read(loginProvider.notifier).getUserData();
  //     return false;
  //   } else {
  //    return true;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      Future<bool> checkLoginStatus() async {
        final token = await SharedPrefData().getUserId();
        if (token == null || token.isEmpty) {
          
          return false;
        } else {
          await ref.read(loginProvider.notifier).getUserData();
          return true;
        }
      }
      return FutureBuilder(
        future: checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: KcircularLoading());
          } else {
            print(snapshot.data!);
            //  ref.read(loginProvider.notifier).getUserData();
            return snapshot.data != null ? HomePage() : Login();
          }
        },
      );
    });
  }
}
