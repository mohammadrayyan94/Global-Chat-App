// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:globalchat/controllers/Login_controller.dart';
import 'package:globalchat/screens/signup.dart';
// import 'package:globalchat/controllers/signup_controller.dart';
// import 'package:globalchat/screens/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _SignupState();
}

class _SignupState extends State<LoginScreen> {
  bool isloading = false;
  var userform = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController passsword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Login")),
      body: Form(
        key: userform,
        child: Padding(
          padding: const EdgeInsets.all(12),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                          LoginController.LoginAccount(
                            context: context,
                            email: email.text,
                            passsword: passsword.text,
                          );
                          isloading = false;
                          setState(() {});
                        }
                      },
                      child: isloading
                          ? CircularProgressIndicator()
                          : Text("Login account"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text("Don't have an account"),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Signup();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Signup here!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
