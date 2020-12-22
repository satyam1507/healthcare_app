import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthcare_app/model/coolors.dart';
import 'package:velocity_x/velocity_x.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final userRef = FirebaseFirestore.instance.collection('users');
final storageRef = FirebaseStorage.instance.ref();

class SignupnPage extends StatefulWidget {
  @override
  _SignupnPageState createState() => _SignupnPageState();
}

class _SignupnPageState extends State<SignupnPage> {
  GlobalKey<FormState> _registerKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _phoneno = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _confirmpwdController = TextEditingController();

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  userRegister() async {
    String uid;
    await auth
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _pwdController.text)
        .then((value) => uid = value.user.uid);
    await userRef.doc(uid).set({
      'name': _name.text,
      'email': _emailController.text,
      'pwd': _pwdController.text,
      'age': _age.text,
      'uid': uid,
      'photoUrl': "",
      'phoneno': _phoneno.text,
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: greenish, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign Up',
              style: TextStyle(
                  color: greenish, fontSize: 20, fontWeight: FontWeight.w600),
              textAlign: TextAlign.end,
            ),
          ],
        ),
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: greenish,
          ),
          Container(
            width: context.screenWidth,
            height: context.percentHeight * 80,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60))),
            child: SingleChildScrollView(
              child: Form(
                key: _registerKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 15, left: 15, bottom: 10),
                      child: TextFormField(
                        controller: _name,
                        // autofocus: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(25.0)),
                          ),
                          labelText: "Full Name",
                          hintText: "Full Name",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 15, left: 15, bottom: 10),
                      child: TextFormField(
                        controller: _phoneno,
                        // autofocus: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(25.0)),
                          ),
                          labelText: "Phone Number",
                          hintText: "Phone Number",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 15, left: 15, bottom: 10),
                      child: TextFormField(
                        controller: _emailController,
                        validator: (value) => emailValidator(value),
                        // autofocus: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(25.0)),
                          ),
                          labelText: "Email",
                          hintText: "Email",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 15, left: 15, bottom: 10),
                      child: TextFormField(
                        controller: _age,
                        validator: (value) {
                          if (value.length > 3) {
                            return "Please enter a valid Age ";
                          }
                          return null;
                        },

                        // autofocus: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(25.0)),
                          ),
                          labelText: "Age",
                          hintText: "Age",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 15, left: 15, bottom: 10),
                      child: TextFormField(
                        controller: _pwdController,
                        validator: (value) => pwdValidator(value),
                        //  autofocus: true,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(25.0)),
                          ),
                          labelText: "Password",
                          hintText: "Password",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 15, left: 15, bottom: 10),
                      child: TextField(
                        controller: _confirmpwdController,

                        //  autofocus: true,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(25.0)),
                          ),
                          labelText: "Confirm Password",
                          hintText: "Confirm Password",
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: () {
                            if (_registerKey.currentState.validate()) {
                              userRegister();
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontFamily: "FiraSans",
                              color: Colors.white,
                            ),
                          ),
                          color: greenish,
                          // color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
