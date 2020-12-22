import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/model/coolors.dart';
import 'package:healthcare_app/model/user.dart';
import 'package:healthcare_app/screens/viewappointment.dart';
import 'package:page_transition/page_transition.dart';

class MyAppointment extends StatefulWidget {
  @override
  _MyAppointmentState createState() => _MyAppointmentState();
}

class _MyAppointmentState extends State<MyAppointment> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Users currentUser;
  String useruid;

  getUser() async {
    final User user = auth.currentUser;
    useruid = user.uid;
    print(useruid);
    //print(DateTime.now());
  }

  void initState() {
    super.initState();
    getUser().then((val) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Appointments',
          style: TextStyle(
            color: greenish,
            fontSize: 25,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('appointments')
            .where('patientuid', isEqualTo: useruid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) return Center(child: CircularProgressIndicator());
          return ListView.builder(
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot appointment = snapshot.data.documents[index];
              //bool status = appointment['status'];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: AppointmentDetail(
                        appointment: appointment,
                      ),
                    ),
                  );
                },
                child: Card(
                  child: ListTile(
                    title: Text(
                      appointment['doctorname'],
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(
                      "Appointment date and time: " + appointment['datetime'],
                      style: TextStyle(fontSize: 13),
                    ),
                    trailing: appointment['status'] == 'Pending'
                        ? RaisedButton(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Text('Pending'),
                          )
                        : appointment['status'] == 'Cancelled'
                            ? RaisedButton(
                                color: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                onPressed: () {},
                                child: Text(
                                  'Cancelled',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : RaisedButton(
                                color: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                onPressed: () {},
                                child: Text(
                                  'Confirmed',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
