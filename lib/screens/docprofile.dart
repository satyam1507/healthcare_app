import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/model/coolors.dart';
import 'package:healthcare_app/screens/makeappointment.dart';
import 'package:page_transition/page_transition.dart';

class DoctorProfile extends StatefulWidget {
  final DocumentSnapshot doctor;
  DoctorProfile({this.doctor});

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.doctor['name'],
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(widget.doctor['photoUrl']),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 8),
                        child: Text(
                          widget.doctor['name'],
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 2, bottom: 8, top: 8),
                        child: Container(
                          child: IconButton(
                              icon: Icon(
                                Icons.call,
                                color: Colors.green,
                              ),
                              onPressed: null),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green.shade100),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 2, right: 2, bottom: 8, top: 8),
                        child: Container(
                          child: IconButton(
                              icon: Icon(
                                Icons.chat,
                                color: Colors.orange,
                              ),
                              onPressed: null),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.orange.shade100),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 2, right: 0, bottom: 8, top: 8),
                        child: Container(
                          child: IconButton(
                              icon: Icon(
                                Icons.videocam,
                                color: Colors.blue,
                              ),
                              onPressed: null),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue.shade100),
                        ),
                      )
                    ],
                  ),
                ),

                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 8, bottom: 8),
                      child: Text(
                        widget.doctor['tag'],
                        style: TextStyle(color: Colors.black45, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 8, bottom: 8),
                        child: Container(
                          width: 200,
                          child: Text(
                            widget.doctor['address'],
                            style:
                                TextStyle(color: Colors.black45, fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'About Doctor',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54),
                      ),
                    ),
                  ],
                ),
                //  Text("About Doctor",),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                              width: 380,
                              height: 200,
                              child: SingleChildScrollView(
                                  child: Text(
                                widget.doctor['detail'],
                                style: TextStyle(color: Colors.black54),
                              )))),
                    ],
                  ),
                ),
              ],
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: SizedBox(
                        width: 200,
                        height: 45,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: MakeAppointment(doctor: widget.doctor,),
                              ),
                            );
                          },
                          child: Text(
                            'Make an Appointment',
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
                    )
                  ],
                )),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(),
    );
  }
}
