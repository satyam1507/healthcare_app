import 'package:flutter/material.dart';
import 'package:healthcare_app/model/coolors.dart';
import 'package:healthcare_app/screens/doctorlist.dart';

class DoctorListPage extends StatefulWidget {
  DoctorListPage({Key key}) : super(key: key);

  @override
  _DoctorListPageState createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Doctors',
          style: TextStyle(
            color: greenish,
            fontSize: 25,
          ),
        ),
      ),
      body: DoctorList(),
    );
  }
}
