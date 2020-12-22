import 'package:cloud_firestore/cloud_firestore.dart';


class Users {
  final String name;
  final String email;
  final String pwd;
  final String uid;
  final String phoneno;
  final String age;
  final String photoUrl;

  Users({
    this.name,
    this.email,
    this.pwd,
    this.uid,
    this.phoneno,
    this.age,
    this.photoUrl,
  });

  factory Users.fromDocument(DocumentSnapshot doc) {
    return Users(
      name: doc['name'],
      email: doc['email'],
      pwd: doc['pwd'],
      uid: doc.id,
      phoneno: doc['phoneno'],
      age: doc['age'],
      photoUrl: doc['photoUrl'],
    );
  }
}
