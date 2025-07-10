import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:globalchat/screens/editprofile.dart';
import 'package:globalchat/screens/provider/Userprovider.dart';
import 'package:provider/provider.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _ProfileState();
}

class _ProfileState extends State<Editprofile> {
  Map<String, dynamic>? userData = {};
  var db = FirebaseFirestore.instance;
  TextEditingController nametext = TextEditingController();
  var editprofileform = GlobalKey<FormState>();

  @override
  void initState() {
    nametext.text = Provider.of<Userprovider>(context, listen: false).userName;
    super.initState();
  }

  void updateData() {
    Map<String, dynamic> datatoUpdate = {"name": nametext.text};
    db
        .collection("user")
        .doc(Provider.of<Userprovider>(context, listen: false).userID)
        .update(datatoUpdate);
    Provider.of<Userprovider>(context, listen: false).getUserData();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var userprovider = Provider.of<Userprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        actions: [
          InkWell(
            onTap: () {
              if (editprofileform.currentState!.validate()) {
                updateData();
              }
              ;
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.check),
            ),
          ),
        ],
      ),
      body: Container(
        child: Form(
          key: editprofileform,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name cannot be empty";
                    }
                  },

                  controller: nametext,
                  decoration: InputDecoration(labelText: "Name"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
