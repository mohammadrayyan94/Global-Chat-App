import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:globalchat/screens/editprofile.dart';
import 'package:globalchat/screens/provider/Userprovider.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, dynamic>? userData = {};

  @override
  Widget build(BuildContext context) {
    var userprovider = Provider.of<Userprovider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(radius: 50, child: Text(userprovider.userName[0])),
            SizedBox(height: 15),
            Text(
              userprovider.userName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(userprovider.userEmail),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Editprofile();
                    },
                  ),
                );
              },
              child: Text("Edit Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
