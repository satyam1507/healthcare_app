import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/model/coolors.dart';
import 'package:intl/intl.dart';

CollectionReference appointmentRef =
    FirebaseFirestore.instance.collection('appointments');
final FirebaseAuth auth = FirebaseAuth.instance;

class MakeAppointment extends StatefulWidget {
  final DocumentSnapshot doctor;
  MakeAppointment({this.doctor});
  @override
  _MakeAppointmentState createState() => _MakeAppointmentState();
}

class _MakeAppointmentState extends State<MakeAppointment> {
  GlobalKey<FormState> _updateInfo = GlobalKey<FormState>();
  String patientuid, bookdatetime, address;
  TextEditingController _patientname = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _datetime = TextEditingController();
  final format = DateFormat("yyyy-MM-dd HH:mm");

  String status;

  makeAppointment() async {
    if (_updateInfo.currentState.validate()) {
      _updateInfo.currentState.save();
      await appointmentRef.add({
        'patientname': _patientname.text,
        'age': _age.text,
        'datetime': _datetime.text,
        'bookdatetime': DateTime.now().toString(),
        'patientuid': patientuid,
        'doctorname': widget.doctor['name'],
        'doctoraddress': widget.doctor['address'],
        'status': 'Pending',
        'doctoruid': widget.doctor['uid']
      });
    }
  }

  getUser() async {
    final User user = auth.currentUser;
    patientuid = user.uid;
    //print(patientuid);
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
      backgroundColor: greenish,
      appBar: AppBar(
        backgroundColor: greenish,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Make an Appointment',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: Center(
        child: Card(
          elevation: 10,
          child: Container(
            width: 380,
            height: 350,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            //  width: 400,
            //height: 400,
            child: Form(
              key: _updateInfo,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 15, left: 15, bottom: 10),
                    child: TextFormField(
                      controller: _patientname,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter a valid name ";
                        }
                        return null;
                      },
                      // autofocus: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(25.0)),
                        ),
                        labelText: "Name",
                        hintText: "Name",
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 15, left: 15, bottom: 10),
                    child: TextFormField(
                      controller: _age,
                      validator: (value) {
                        if (value.isEmpty) {
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
                    padding: EdgeInsets.only(right: 15, left: 15, bottom: 10),
                    child: DateTimeField(
                      controller: _datetime,
                      format: format,
                      onShowPicker: (context, currentValue) async {
                        final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()),
                          );
                          return DateTimeField.combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(25.0)),
                        ),
                        labelText: "Date and time",
                        hintText: "Date and time",
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
                          if (_updateInfo.currentState.validate()) {
                            makeAppointment();
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
                          "Book",
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
      ),
    );
  }
}
