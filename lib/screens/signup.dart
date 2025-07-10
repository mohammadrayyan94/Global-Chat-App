// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:globalchat/controllers/signup_controller.dart';
// import 'package:globalchat/screens/dashboard_screen.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isloading = false;
  var userform = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController passsword = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController country = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Signup")),
      body: SingleChildScrollView(
        child: Form(
          key: userform,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset("assets/images/logo.png"),
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is Required";
                    }
                  },

                  decoration: InputDecoration(label: Text("Email")),
                ),
                SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: passsword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is Required";
                    }
                  },
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(label: Text("Password")),
                ),
                SizedBox(height: 25),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name is Required";
                    }
                  },

                  decoration: InputDecoration(label: Text("Name")),
                ),
                SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: country,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "country is Required";
                    }
                  },

                  decoration: InputDecoration(label: Text("country")),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(0, 50),
                          foregroundColor: Colors.white,
                          backgroundColor: const Color.fromARGB(
                            255,
                            66,
                            150,
                            228,
                          ),
                        ),
                        onPressed: () {
                          if (userform.currentState!.validate()) {
                            isloading = true;
                            setState(() {});
                            SignupController.createAccount(
                              context: context,
                              email: email.text,
                              passsword: passsword.text,
                              name: name.text,
                              country: country.text,
                            );
                            isloading = false;
                            setState(() {});
                          }
                        },
                        child: isloading
                            ? CircularProgressIndicator()
                            : Text("create account"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
