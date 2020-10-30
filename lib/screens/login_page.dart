import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthcare_app/model/coolors.dart';
import 'package:healthcare_app/screens/homepage.dart';
import 'package:healthcare_app/screens/signup.dart';
import 'package:page_transition/page_transition.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatelessWidget {
  @override
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
            child: VStack([
              SvgPicture.asset(
                "assets/images/login.svg",
                fit: BoxFit.contain,
                width: context.percentWidth * 100,
              ).py4(),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15, bottom: 10),
                child: TextField(
                  // autofocus: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(25.0)),
                    ),
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                    hintText: "Enter email",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
                child: TextField(
                  // autofocus: true,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(25.0)),
                      ),
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock),
                      hintText: "Enter password"),
                ),
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
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: HomePage(),
                          ),
                        );
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
