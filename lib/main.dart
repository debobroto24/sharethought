import 'package:flutter/material.dart';
import 'package:sharethought/route/route_generator.dart';
import 'package:sharethought/styles/kcolor.dart';
import 'package:sharethought/view/auth/login.dart';
import 'package:sharethought/view/home/home_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      
      theme: ThemeData(
        primaryColor: Kcolor.secondary,
        accentColor: Kcolor.white, 
        fontFamily: 'Arimo'
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      home: HomePage(),
    );
  }
}
