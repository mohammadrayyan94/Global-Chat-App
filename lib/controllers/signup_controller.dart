import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:globalchat/screens/dashboard_screen.dart';
import 'package:globalchat/screens/splash_screen.dart';

class SignupController {
  static Future<void> createAccount({
    required BuildContext context,
    required String email,
    required String passsword,
    required String name,
    required String country,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: passsword,
      );
      var userID = FirebaseAuth.instance.currentUser!.uid;
      var db = FirebaseFirestore.instance;
      Map<String, dynamic> data = {
        "name": name,
        "email": email,
        "country": country,
        "id": userID.toString(),
      };
      try {
        await db.collection("user").doc(userID.toString()).set(data);
      } catch (e) {
        print(e);
      }

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return SplashScreen();
          },
        ),
        (Route) {
          return false;
        },
      );
      print("Account successful");
    } catch (e) {
      SnackBar messageSnackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text(e.toString(), style: TextStyle(color: Colors.white)),
      );
      ScaffoldMessenger.of(context).showSnackBar(messageSnackBar);
      print("error");
    }
  }
}
