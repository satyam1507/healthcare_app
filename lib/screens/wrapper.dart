import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/screens/homepage.dart';
import 'package:healthcare_app/screens/onboarding/oneboarding1.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    
    // return either the Home or Authenticate widget
    if (user == null){
      return Onboarding1();
    } else {
      return HomePage();
    }
    
  }
}