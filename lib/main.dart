import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare_app/model/coolors.dart';
import 'package:healthcare_app/screens/homepage.dart';
import 'package:healthcare_app/screens/login_page.dart';
import 'package:healthcare_app/screens/onboarding/onboarding2.dart';
import 'package:healthcare_app/screens/onboarding/onboarding4.dart';
import 'package:healthcare_app/screens/onboarding/onborading3.dart';
import 'package:healthcare_app/screens/onboarding/oneboarding1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
User firebaseUser = FirebaseAuth.instance.currentUser;
Widget firstWidget;
if (firebaseUser != null) {
  firstWidget = HomePage();
} else {
  firstWidget = Onboarding1();
}
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Healthcare App',
      theme: ThemeData(
        primaryColor: greenish,
        scaffoldBackgroundColor: Colors.white,
       fontFamily: "OpenSans",
      ),
      home: firstWidget,
    );
  }
}
