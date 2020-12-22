import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthcare_app/model/coolors.dart';
import 'package:healthcare_app/model/coolors.dart';
import 'package:healthcare_app/screens/getlocation.dart';
import 'package:healthcare_app/screens/news/newspage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_ui/liquid_ui.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:healthcare_app/model/user.dart';
import 'package:healthcare_app/screens/signup.dart';

final userRef = FirebaseFirestore.instance.collection('users');
final storageRef = FirebaseStorage.instance.ref();

class ProfileInfo extends StatefulWidget {
  final Users user;
  ProfileInfo(this.user);

  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  File _image;
  String _uploadedFileUrl;
  final picker = ImagePicker();
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  GlobalKey<FormState> _updateInfo = GlobalKey<FormState>();
  String name, phoneno, age, email, pass, uname, dpurl = null;
  bool showPwd = false;

  @override
  void initState() {
    super.initState();
  }

  handleUpdate() async {
    if (_updateInfo.currentState.validate()) {
      _updateInfo.currentState.save();
      await userRef.doc(widget.user.uid).update({
        'name': name,
        'email': email,
        'pwd': pass,
        'age': age,
        'phoneno': phoneno,
      });
    }
  }

  handleRemove() async {
    await userRef.doc(widget.user.uid).update({'photoUrl': ""});
  }

  openCam() async {
    final pickedImg = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedImg.path);
    });
    Reference ref = storageRef.child("dp_${widget.user.name}");
    final UploadTask storageUploadTask = ref.putFile(_image);

    await (await storageUploadTask).ref.getDownloadURL().then((fileURL) {
      userRef.doc(widget.user.uid).update({'photoUrl': fileURL});
    });
  }

  chooseFile() async {
    final pickedImg = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImg.path);
    });
    Reference ref = storageRef.child("dp_${widget.user.name}");
    UploadTask storageUploadTask = ref.putFile(_image);

    await (await storageUploadTask).ref.getDownloadURL().then((fileURL) {
      userRef.doc(widget.user.uid).update({'photoUrl': fileURL});
    });
  }

  updatePhoto() async {
    await userRef.doc(widget.user.uid).update({'photoUrl': _uploadedFileUrl});
  }

  handlePhoto() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Select Photo from:"),
        content: Container(
          height: 125.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                color: greenish,
                onPressed: () {
                  openCam();
                },
                child: Text(
                  'Camera',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              RaisedButton(
                color: greenish,
                onPressed: () {
                  chooseFile();
                },
                child: Text('Gallery',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              )
            ],
          ),
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
      ),
    );
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: userRef.doc(widget.user.uid).snapshots(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                  strokeWidth: 5.0,
                ),
              ),
            );
          }
          Users user = Users.fromDocument(snap.data);
          uname = user.name;
          dpurl = user.photoUrl;
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
                  title: Text('Profile'),
                ),
                body: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 0.0, bottom: 10.0),
                          child: Stack(
                            alignment: Alignment(0, 0.7),
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: greenish,
                                backgroundImage: user.photoUrl == null
                                    ? null
                                    : NetworkImage(user.photoUrl),
                                radius: 70.0,
                              ),
                              Container(
                                decoration:
                                    BoxDecoration(color: Colors.black45),
                                child: InkWell(
                                  onTap: () {
                                    handlePhoto();
                                  },
                                  child: Text(
                                    "Update Photo",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Form(
                          key: _updateInfo,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 15, left: 15, bottom: 10),
                                child: TextFormField(
                                  onSaved: (val) => name = val,
                                  initialValue: user.name,

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
                                  onSaved: (val) => phoneno = val,
                                  initialValue: user.phoneno,
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
                                  onSaved: (val) => email = val,
                                  initialValue: user.email,
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
                                  onSaved: (val) => age = val,
                                  initialValue: user.age,

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
                                  initialValue: user.pwd,
                                  onSaved: (val) => pass = val,
                                  obscureText: showPwd ? false : true,
                                  validator: (value) => pwdValidator(value),
                                  //  autofocus: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          const Radius.circular(25.0)),
                                    ),
                                    labelText: "Password",
                                    hintText: "Password",
                                    suffix: GestureDetector(
                                      child: Icon(
                                        Icons.remove_red_eye,
                                        size: 25.0,
                                        color: greenish,
                                      ),
                                      onTap: () => setState(() {
                                        showPwd = !showPwd;
                                      }),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              SizedBox(
                                width: 200,
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RaisedButton(
                                    onPressed: () async {
                                      await handleUpdate();
                                    },
                                    child: Text(
                                      "Update Profile",
                                      style: TextStyle(
                                        fontFamily: "FiraSans",
                                        color: Colors.white,
                                      ),
                                    ),
                                    color: greenish,
                                    // color: Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RaisedButton(
                                    onPressed: () async {
                                      await handleRemove();
                                    },
                                    child: Text(
                                      "Remove Picture",
                                      style: TextStyle(
                                        fontFamily: "FiraSans",
                                        color: Colors.white,
                                      ),
                                    ),
                                    color: greenish,
                                    // color: Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
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
                    backgroundColor: Colors.white,
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
                Text("Profile",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 15.0),
                Text("Home",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 15.0),
                Text("Doctors",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 15.0),
                Text("Appointment",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 15.0),
                Text("Buy Medicines",
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
                Text("Log Out",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
