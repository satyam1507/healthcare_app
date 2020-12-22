import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {
  final String name;
  final String email;
  final String pwd;
  final String uid;
  final String phoneno;
  final String tag;
  final String photoUrl;
  final String address;
  final String fee;
  final String detail;

  Doctor({
    this.name,
    this.email,
    this.pwd,
    this.uid,
    this.phoneno,
    this.tag,
    this.photoUrl,
    this.address,
    this.fee,
    this.detail,
  });

  factory Doctor.fromDocument(DocumentSnapshot doc) {
    return Doctor(
      name: doc['name'],
      email: doc['email'],
      pwd: doc['pwd'],
      uid: doc.id,
      phoneno: doc['phoneno'],
      tag: doc['tag'],
      photoUrl: doc['photoUrl'],
      address: doc['address'],
      fee: doc['fee'],
      detail: doc['detail'],
    );
  }
}
