import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharethought/common_widget/full_width_button.dart';
import 'package:sharethought/common_widget/inputField/username_input_field.dart';
import 'package:sharethought/core/base_state/base_state.dart';
import 'package:sharethought/styles/kcolor.dart';
import 'package:sharethought/styles/ksize.dart';
import 'package:sharethought/styles/ktext_style.dart';

import '../../../common_widget/kinput_field.dart';
import '../../../common_widget/ksmall_button.dart';
import '../../../constants/value_constant.dart';
import '../../../core/controllers/auth/signup_controller.dart';
import '../../../core/network/database_constant.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  final TextEditingController usernameCon = TextEditingController();
  final TextEditingController passwordCon = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isSetUserNmae = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * .6;
    return Scaffold(
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.only(top: Ksize.getWidth(context, 120))),
                    Text(
                      "Pick your username and start sharing now",
                      textAlign: TextAlign.left,
                      style: ktextStyle.headline(Kcolor.deleteColor),
                    ),
                    Padding(
                        padding:
                            EdgeInsets.only(top: Ksize.getWidth(context, 20))),
                    Consumer(builder: (context, ref, _) {
                      final usernameAvailability =
                          ref.watch(usernameAvailabilityProvider);
                      return userNameInputMehtod(ref, usernameAvailability);
                    }),
                    SizedBox(
                      height: Ksize.getHeight(context, 10),
                    ),
                    KInputField(
                      hintText: "Password",
                      icon: Icon(Icons.wifi_password_outlined),
                      controller: passwordCon,
                      isObscure: true,
                    ),
                    SizedBox(
                      height: Ksize.getHeight(context, 30),
                    ),
                    Consumer(builder: (context, ref, _) {
                      final signupProvider =
                          ref.watch(signUpControllerProvider);
                      final isSetUsername =
                          ref.watch(usernameAvailabilityProvider);

                      return FullWidthButton(
                          text: signupProvider is LoadingState
                              ? "Loading..."
                              : "Sign Up",
                          onTap: ()  {
                            if ((formKey.currentState?.validate() ?? false)) {
                              // if(getMessage == ValueConstant.usernameAvailable)
                              ref
                                  .read(signUpControllerProvider.notifier)
                                  .signUp(
                                      username: usernameCon.text,
                                      password: passwordCon.text);
                            }
                          });
                    }),
                    SizedBox(
                      height: Ksize.getHeight(context, 20),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Allready have an account?",
                            style: ktextStyle.mediumText(Kcolor.black)),
                        TextSpan(
                            text: " Login",
                            style: ktextStyle.mediumText(Kcolor.filterColorTwo),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, "/login");
                              })
                      ]),
                    )
                  ],
                ),
              ),
            )));
  }

  Column userNameInputMehtod(
      WidgetRef ref, AsyncValue<String> usernameAvailability) {
    return Column(
      children: [
        UserNameInputField(
            hintText: "Username",
            icon: Icon(Icons.person_outline_outlined),
            controller: usernameCon,
            onChange: (value) async {
              // Check username availability in real-time
              if (value.isNotEmpty) {
                Future.delayed(Duration(microseconds: 1000), () {
                  ref.read(usernameControllerProvider).text = value;
                  ref.refresh(usernameAvailabilityProvider);
                  print('Current username: ${usernameCon.text}');
                });
              }
            },
            validator: userNameValidator),
        usernameAvailability.when(
          data: (text) {
            return Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .094,
                ),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      text ?? '',
                      style: TextStyle(
                          color: text == ValueConstant.usernameAvailable
                              ? Kcolor.stickerColor
                              : Kcolor.errorRedText),
                    )));
          },
          loading: () => const Text("checking..."),
          error: (error, stackTrace) =>
              Text('Error checking username availability'),
        )
      ],
    );
  }

  isUsernameAvailable(value) async {
    Future.delayed(
        Duration(
          seconds: 5,
        ), () {
      print("user name typirn $value");
      userNameValidator(value, isValid: true);
    });
  }

  String? userNameValidator(String? value, {bool? isValid = false}) {
    if (isValid == true) {
      return "this user name alwewady used";
    }
    if (value == null) {
      return "please enter user name null";
    } else {
      if (value.isEmpty) {
        return "Please enter your name is empty";
      } else if (!isUsernameValid(value)) {
        return "Only can use alphanumeric characters (letters and numbers) and underscores.";
      } else {
        return null;
      }
    }
  }
}
