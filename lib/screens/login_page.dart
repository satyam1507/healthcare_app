import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthcare_app/model/coolors.dart';
import 'package:healthcare_app/screens/homepage.dart';
import 'package:healthcare_app/screens/signup.dart';
import 'package:page_transition/page_transition.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();

  void _showAlert(String err) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            "Wrong Credentials",
          ),
          content: Text(
            err,
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Close",
              ),
            ),
          ],
        );
      },
    );
  }

  login() async {
    try {
      await auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _pwdController.text);
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: HomePage(),
        ),
      );
    } catch (e) {
      _showAlert(e.message);
    }
  }

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

  Widget build(BuildContext context) {
    return Material(
      child: Stack(
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
              child: VStack([
                SvgPicture.asset(
                  "assets/images/login.svg",
                  fit: BoxFit.contain,
                  width: context.percentWidth * 100,
                ).py4(),
                SingleChildScrollView(
                  child: Form(
                      key: _loginKey,
                      child: Column(children: <Widget>[
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
                      ])),
                ),
                Text(
                  "Forget Password?",
                  style: TextStyle(color: Colors.black54),
                ).objectCenterRight().px16().py12(),
                Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15, top: 15),
                  child: Center(
                    child: SizedBox(
                      width: 200,
                      height: 45,
                      child: RaisedButton(
                        onPressed: () {
                          if (_loginKey.currentState.validate()) {
                            login();
                          }
                        },
                        child: Text(
                          'LOG IN',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 17.0),
                        ),
                        color: greenish,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(25.0)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.black54),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: SignupnPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: greenish),
                        ),
                      )
                    ],
                  ),
                )
              ]),
            ),
          ),
          Positioned(
            bottom: 50,
            right: 10,
            left: 10,
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                  child: Text(
                    'Log In with',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/fb.svg",
                      fit: BoxFit.contain,
                      width: 60,
                    ),
                    SvgPicture.asset(
                      "assets/icons/google.svg",
                      fit: BoxFit.contain,
                      width: 60,
                    ),
                    SvgPicture.asset(
                      "assets/icons/twitter.svg",
                      fit: BoxFit.contain,
                      width: 60,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
