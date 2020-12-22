import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthcare_app/model/coolors.dart';
import 'package:healthcare_app/model/user.dart';
import 'package:healthcare_app/screens/category.dart';
import 'package:healthcare_app/screens/category/cardiologist.dart';
import 'package:healthcare_app/screens/category/dentist.dart';
import 'package:healthcare_app/screens/category/ophthalmologist.dart';
import 'package:healthcare_app/screens/category/physician.dart';
import 'package:healthcare_app/screens/chatbot.dart';
import 'package:healthcare_app/screens/doctorlist.dart';
import 'package:healthcare_app/screens/doctorlistpage.dart';
import 'package:healthcare_app/screens/getlocation.dart';
import 'package:healthcare_app/screens/login_page.dart';
import 'package:healthcare_app/screens/myappointment.dart';
import 'package:healthcare_app/screens/news/newspage.dart';
import 'package:healthcare_app/screens/profile_info.dart';
import 'package:healthcare_app/screens/signup.dart';
import 'package:liquid_ui/liquid_ui.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:velocity_x/velocity_x.dart';

final userRef = FirebaseFirestore.instance.collection('users');
final List<String> imgList = [
  "assets/images/c1.svg",
  "assets/images/c1.svg",
  "assets/images/c1.svg",
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    SvgPicture.asset(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Users currentUser;
  String uname = 'profile';
  String dpurl;
  String useruid;

  getUser() async {
    final User user = auth.currentUser;
    final uid = user.uid;
    DocumentSnapshot doc = await userRef.doc(uid).get();
    return Users.fromDocument(doc);
  }

  void initState() {
    super.initState();
    getUser().then((val) {
      setState(() {
        currentUser = val;
        uname = currentUser.name;
        dpurl = currentUser.photoUrl;
        useruid = currentUser.uid;
      });
    });
  }

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future signOut() async {
    try {
      return await _auth.signOut().then((value) => Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: LoginPage(),
            ),
          ));
      // ignore: dead_code
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: HomePage(),
        ),
      );
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      inverse: true, // end side menu
      menu: buildMenu(),
      child: SideMenu(
        key: _sideMenuKey,
        menu: buildMenu(),
        type: SideMenuType.shrinkNSlide,
        background: greenish,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              "Welcome " + uname,
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),
            ),
            leading: IconButton(
              icon: Icon(Icons.short_text),
              onPressed: () {
                final _state = _sideMenuKey.currentState;
                if (_state.isOpened)
                  _state.closeSideMenu();
                else
                  _state.openSideMenu();
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: ChatbotPage()),
                    );
                  },
                  child: Container(
                    child: Image.asset(
                      'assets/icons/chatbot.png',
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: greenish,
                    ),
                    height: 10,
                    width: 35,
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      initialPage: 2,
                      autoPlay: true,
                    ),
                    items: imageSliders,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: CategoryPage(),
                                ),
                              );
                            },
                            child: Text("See All",
                                style: TextStyle(color: greenish))),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: PhysicianPage(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  'assets/icons/stethoscope.svg',
                                ),
                              ),
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: darkblue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            Text('Physician')
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: CardiologistPage(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child:
                                    SvgPicture.asset('assets/icons/heart.svg'),
                              ),
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: lightorange,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            Text('Heart')
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: DentistPage(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child:
                                    SvgPicture.asset('assets/icons/tooth.svg'),
                              ),
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: lightpurple,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            Text('Dental')
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child:
                                  SvgPicture.asset('assets/icons/patches.svg'),
                            ),
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: yellowish,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          Text('Skin')
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child:
                                  SvgPicture.asset('assets/icons/medicine.svg'),
                            ),
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: greentype,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          Text('Medicines')
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: OphthalmologistPage(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child:
                                    SvgPicture.asset('assets/icons/view.svg'),
                              ),
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: lightblue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            Text('Eyes')
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset('assets/icons/bone.svg'),
                            ),
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: pinkish,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          Text('Ortho')
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(
                                  'assets/icons/injection.svg'),
                            ),
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: redish,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          Text('Surgeon')
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: Text(
                          "Top Doctors",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: DoctorListPage(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Text("See All",
                              style: TextStyle(color: greenish)),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 300,
                  child: SingleChildScrollView(child: DoctorList()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenu() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 60.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: CircleAvatar(
                    backgroundColor: greenish,
                    backgroundImage: dpurl == null ? null : NetworkImage(dpurl),
                    radius: 60.0,
                  ),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Text(
                    uname,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                GetLocation(),
                SizedBox(height: 40.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: ProfileInfo(currentUser),
                      ),
                    );
                  },
                  child: Text("Profile",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
                SizedBox(height: 15.0),
                Text("Home",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 15.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: DoctorListPage(),
                      ),
                    );
                  },
                  child: Text("Doctors",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
                SizedBox(height: 15.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: MyAppointment(),
                      ),
                    );
                  },
                  child: Text("Appointment",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
                SizedBox(height: 15.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: ChatbotPage(),
                      ),
                    );
                  },
                  child: Text("Symptom Checker",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
                SizedBox(height: 15.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: CategoryNews(),
                      ),
                    );
                  },
                  child: Text("Health News",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
                SizedBox(height: 15.0),
                Text("Developers",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 15.0),
                Text("Setting",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 15.0),
                GestureDetector(
                  onTap: () {
                    signOut();
                  },
                  child: Text("Log Out",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
