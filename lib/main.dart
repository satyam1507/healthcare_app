import 'package:flutter/material.dart';
import 'package:healthcare_app/model/coolors.dart';
import 'package:healthcare_app/screens/login_page.dart';
import 'package:healthcare_app/screens/onboarding/onboarding2.dart';
import 'package:healthcare_app/screens/onboarding/onboarding4.dart';
import 'package:healthcare_app/screens/onboarding/onborading3.dart';
import 'package:healthcare_app/screens/onboarding/oneboarding1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Healthcare App',
      theme: ThemeData(
        primaryColor: greenish,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "OpenSans",
      ),
      home: Onboarding1(),
    );
  }
}
