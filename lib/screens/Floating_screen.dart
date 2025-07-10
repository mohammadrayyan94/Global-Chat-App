import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FloatingScreen extends StatefulWidget {
  const FloatingScreen({super.key});

  @override
  State<FloatingScreen> createState() => _FloatingScreenState();
}

class _FloatingScreenState extends State<FloatingScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  final FirebaseFirestore db = FirebaseFirestore.instance;

  void createChatroom() async {
    String name = nameController.text.trim();
    String desc = descController.text.trim();

    if (name.isEmpty || desc.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please fill in both fields")));
      return;
    }

    await db.collection("Chatrooms").add({
      "chatrooms_name": name,
      "desc": desc,
      "created_at": Timestamp.now(),
    });

    Navigator.pop(context); // Go back to DashboardScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Chatroom")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Chatroom Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: descController,
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  
                  onPressed: createChatroom,
                  icon: Icon(Icons.add),
                  label: Text("Add Chatroom"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
