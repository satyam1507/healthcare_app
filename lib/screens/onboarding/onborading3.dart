import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthcare_app/model/coolors.dart';
import 'package:healthcare_app/screens/onboarding/onboarding2.dart';
import 'package:healthcare_app/screens/onboarding/onboarding4.dart';
import 'package:page_transition/page_transition.dart';
import 'package:velocity_x/velocity_x.dart';

import '../login_page.dart';

class Onboarding3 extends StatelessWidget {
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
            child: VStack(
              [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: SvgPicture.asset(
                    "assets/images/Doctor1.svg",
                    fit: BoxFit.contain,
                    width: context.percentWidth * 100,
                  ),
                ),
                Center(
                  child: Text(
                    'Smart Booking System',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: greenish,
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 20, top: 30, left: 25, right: 25),
                  child: Center(
                    child: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black26,
                        fontSize: 22,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 130,
            right: 10,
            left: 10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white60),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white60),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white60),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 1,
            left: 1,
            child: Container(
              child: ButtonBar(
                mainAxisSize: MainAxisSize.max,
                alignment: MainAxisAlignment.spaceBetween,
                children: [
                  [
                    SvgPicture.asset(
                      "assets/icons/left.svg",
                      width: 15,
                      height: 15,
                      color: Colors.white,
                    ),
                    FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: Onboarding2(),
                            ),
                          );
                        },
                        child: Text(
                          "Previous",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        )),
                  ].hStack(),
                  [
                    FlatButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: Onboarding4(),
                            ),
                          );
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        )),
                    SvgPicture.asset(
                      "assets/icons/right.svg",
                      width: 15,
                      height: 15,
                      color: Colors.white,
                    )
                  ].hStack()
                ],
              ),
            ),
          ),
          Positioned(
            top: 45,
            right: 10,
            child: Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: LoginPage(),
                    ),
                  );
                },
                child: Text(
                  "Skip ",
                  style: TextStyle(color: greenish, fontSize: 17),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
