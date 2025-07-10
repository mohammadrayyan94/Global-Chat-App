import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:globalchat/screens/dashboard_screen.dart';
import 'package:globalchat/screens/splash_screen.dart';

class LoginController {
  static Future<void> LoginAccount({
    required BuildContext context,
    required String email,
    required String passsword,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: passsword,
      );
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
