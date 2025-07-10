import 'package:flutter/material.dart';
import 'package:globalchat/screens/provider/Userprovider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatroomScreen extends StatefulWidget {
  String chatroomname;
  String chatroomId;
  ChatroomScreen({
    super.key,
    required this.chatroomname,
    required this.chatroomId,
  });

  @override
  State<ChatroomScreen> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  TextEditingController messagetext = TextEditingController();
  var db = FirebaseFirestore.instance;
  Future<void> sendmessage() async {
    if (messagetext.text.isEmpty) {
      return;
    }
    Map<String, dynamic> messagetosend = {
      "name": messagetext.text,
      "sender_name": Provider.of<Userprovider>(context, listen: false).userName,
      "sender_id": Provider.of<Userprovider>(context, listen: false).userID,
      "chatroom_id": widget.chatroomId,
      "timestamp": FieldValue.serverTimestamp(),
    };
    messagetext.text = "";
    await db.collection("messages").add(messagetosend);
  }

  Widget singlechatitem({
    required String sender_name,
    required String name,
    required String sender_id,
  }) {
    return Column(
      crossAxisAlignment:
          sender_id == Provider.of<Userprovider>(context, listen: false).userID
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 6, right: 6),
          child: Text(
            sender_name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color:
                sender_id ==
                    Provider.of<Userprovider>(context, listen: false).userID
                ? Colors.grey[300]
                : Colors.blueGrey[900],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 16,
                color:
                    sender_id ==
                        Provider.of<Userprovider>(context, listen: false).userID
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatroomname),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'delete') {
                // Delete the chatroom
                await FirebaseFirestore.instance
                    .collection("Chatrooms")
                    .doc(widget.chatroomId)
                    .delete();

                // Optional: also delete all messages from this chatroom
                final messages = await FirebaseFirestore.instance
                    .collection("messages")
                    .where("chatroom_id", isEqualTo: widget.chatroomId)
                    .get();

                for (var msg in messages.docs) {
                  await msg.reference.delete();
                }

                // Return to dashboard and notify it to remove this room
                if (mounted) Navigator.pop(context, true);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'delete',
                child: Text('Delete Group'),
              ),
            ],
          ),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: db
                  .collection("messages")
                  .where("chatroom_id", isEqualTo: widget.chatroomId)
                  .limit(100)
                  .orderBy("timestamp", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);

                  return Text("snapshot me error hai");
                }

                var allmessages = snapshot.data?.docs ?? [];
                if (allmessages.length < 1) {
                  return Center(child: Text("No messages here"));
                }
                return ListView.builder(
                  reverse: true,
                  itemCount: allmessages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: singlechatitem(
                        sender_name: allmessages[index]["sender_name"] ?? "",
                        name: allmessages[index]["name"] ?? "",
                        sender_id: allmessages[index]["sender_id"] ?? "",
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messagetext,
                      decoration: InputDecoration(
                        labelText: "write your message here ..>",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  InkWell(onTap: sendmessage, child: Icon(Icons.send)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
