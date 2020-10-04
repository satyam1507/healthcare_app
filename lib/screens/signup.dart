import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthcare_app/model/coolors.dart';
import 'package:velocity_x/velocity_x.dart';

class SignupnPage extends StatelessWidget {
  @override
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
            child: VStack(
              [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 15, left: 15, bottom: 10),
                  child: TextField(
                    // autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(25.0)),
                      ),
                      labelText: "Full Name",
                      hintText: "Full Name",
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 15, left: 15, bottom: 10),
                  child: TextField(
                    // autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(25.0)),
                      ),
                      labelText: "Phone Number",
                      hintText: "Phone Number",
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 15, left: 15, bottom: 10),
                  child: TextField(
                    // autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(25.0)),
                      ),
                      labelText: "Email",
                      hintText: "Email",
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 15, left: 15, bottom: 10),
                  child: TextField(
                    //  autofocus: true,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(25.0)),
                      ),
                      labelText: "Password",
                      hintText: "Password",
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 15, left: 15, bottom: 10),
                  child: TextField(
                    //  autofocus: true,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(25.0)),
                      ),
                      labelText: "Confirm Password",
                      hintText: "Confirm Password",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
