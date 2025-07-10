import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Userprovider extends ChangeNotifier {
  String userName = "Hello";
  String userEmail = "";
  String userID = "";
  var db = FirebaseFirestore.instance;

  void getUserData() {
    var authUser = FirebaseAuth.instance.currentUser;
    db.collection("user").doc(authUser!.uid).get().then((datasnapshot) {
      userName = datasnapshot.data()?["name"] ?? "";
      userEmail = datasnapshot.data()?["email"] ?? "";
      userID = datasnapshot.data()?["id"] ?? "";
      notifyListeners();
    });
  }
}
