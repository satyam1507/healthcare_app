import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/model/coolors.dart';
import 'package:page_transition/page_transition.dart';

import '../docprofile.dart';

class OphthalmologistPage extends StatefulWidget {
  OphthalmologistPage({Key key}) : super(key: key);

  @override
  _OphthalmologistPageState createState() => _OphthalmologistPageState();
}

class _OphthalmologistPageState extends State<OphthalmologistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Ophthalmologist',
            style: TextStyle(
              color: greenish,
              fontSize: 25,
            ),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('doctors')
              .where('tag', isEqualTo: 'ophthalmologist')
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null)
              return Center(child: CircularProgressIndicator());
            return ListView.builder(
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot doctor = snapshot.data.documents[index];
                var url = doctor['photoUrl'];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: DoctorProfile(
                          doctor: doctor,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: CircleAvatar(
                          backgroundColor: greenish,
                          backgroundImage:
                              url == null ? null : NetworkImage(url),
                          radius: 30.0,
                        ),
                      ),
                      title: Text(
                        doctor['name'],
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                        doctor['tag'],
                        style: TextStyle(fontSize: 13),
                      ),
                      trailing: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: DoctorProfile(
                                doctor: doctor,
                              ),
                            ),
                          );
                        },
                        elevation: 0.3,
                        child: Text(
                          'Book',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        color: greenish,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}