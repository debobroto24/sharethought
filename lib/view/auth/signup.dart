import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sharethought/common_widget/full_width_button.dart';
import 'package:sharethought/styles/kcolor.dart';
import 'package:sharethought/styles/ksize.dart';
import 'package:sharethought/styles/ktext_style.dart';

import '../../common_widget/kinput_field.dart';
import '../../common_widget/ksmall_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  final TextEditingController usernameCon = TextEditingController();
  final TextEditingController passwordCon = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * .6;
    return Scaffold(
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical, child: SignUpContent(context)));
  }

  Widget SignUpContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(top: Ksize.getWidth(context, 120))),
            Text(
              "Pick your username and start sharing now",
              textAlign: TextAlign.left,
              style: ktextStyle.headline(Kcolor.deleteColor),
            ),
            Padding(padding: EdgeInsets.only(top: Ksize.getWidth(context, 20))),
            KInputField(
              hintText: "Username",
              icon: Icon(Icons.person_outline_outlined),
              controller: usernameCon,
            ),
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
            FullWidthButton(text: "Signup", onTap: () {
              if(formKey.currentState?.validate() ?? false){
                print("text not working"); 

              }
              print("controller data"); 
              print(usernameCon.text); 
              print(passwordCon.text); 
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
                    recognizer: TapGestureRecognizer()..onTap = () {
                      Navigator.pushNamed(context, "/login");
                    })
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class BgCurve extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Kcolor.secondary
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(0, size.height) // Starting point at bottom-left
      ..quadraticBezierTo(
        size.width / 3, // Control point x for the first curve
        size.height / 2, // Control point y for the first curve
        size.width / 2, // End point x for the first curve
        size.height / 2, // End point y for the first curve
      )
      ..quadraticBezierTo(
        3 * size.width / 2, // Control point x for the second curve
        size.height / 4, // Control point y for the second curve
        size.width, // End point x for the second curve
        size.height, // End point y for the second curve
      );
    // final path = Path()
    //   ..moveTo(size.height/2,10)
    //   ..lineTo(1, 20)
    //   ..lineTo(21, -1)
    //   ..close();
    // ..quadraticBezierTo(
    //   size.width / 2, // control point x
    //   size.height,    // control point y
    //   size.width,      // end point x
    //   size.height / 2, // end point y
    // );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
