import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:globalchat/screens/chatroom_screen.dart';
import 'package:globalchat/screens/Floating_screen.dart';
import 'package:globalchat/screens/profile.dart';
import 'package:globalchat/screens/provider/Userprovider.dart';
import 'package:globalchat/screens/settingScreen.dart';
// import 'package:globalchat/screens/setting_screen.dart';
import 'package:globalchat/screens/splash_screen.dart';
import 'package:globalchat/widgets/themeswitcher.dart';
// import 'package:globalchat/widgets/themeswitcher.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var user = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance;
  var scaffoldkey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> chatroomList = [];
  List<String> chatroomIds = [];
  void getChatrooms() {
    db.collection("Chatrooms").get().then((datasnapshot) {
      for (var singleChatroomData in datasnapshot.docs) {
        chatroomList.add(singleChatroomData.data());
        chatroomIds.add(singleChatroomData.id.toString());
      }
      setState(() {});
      ;
    });
  }

  @override
  void initState() {
    getChatrooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userprovider = Provider.of<Userprovider>(context);
    return Scaffold(
      key: scaffoldkey,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FloatingScreen()),
          );
          chatroomList.clear();
          chatroomIds.clear();
          getChatrooms(); // Refresh chatroom list after adding
        },
        child: Icon(Icons.add),
      ),

      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            scaffoldkey.currentState!.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: CircleAvatar(
              radius: 20,
              child: Text(userprovider.userName[0]),
            ),
          ),
        ),
        title: Text("Global Chat"),
      ),
      drawer: Drawer(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 30),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Profile();
                      },
                    ),
                  );
                },
                leading: CircleAvatar(child: Text(userprovider.userName[0])),
                title: Text(
                  userprovider.userName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(userprovider.userEmail),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Profile();
                      },
                    ),
                  );
                },
                leading: Icon(Icons.people),
                title: Text("Profile"),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Settingscreen();
                      },
                    ),
                  );
                },
                leading: Icon(Icons.settings),
                title: Text("Setting"),
              ),
              ListTile(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
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
                },
                leading: Icon(Icons.logout),
                title: Text("Logout"),
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: chatroomList.length,
        itemBuilder: (BuildContext context, int index) {
          String chatroomname = chatroomList[index]["chatrooms_name"] ?? "";
          return SizedBox(
            child: ListTile(
              onTap: () async {
                bool? deleted = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ChatroomScreen(
                        chatroomname: chatroomname,
                        chatroomId: chatroomIds[index],
                      );
                    },
                  ),
                );

                if (deleted == true) {
                  setState(() {
                    chatroomList.removeAt(index);
                    chatroomIds.removeAt(index);
                  });
                }
              },

              leading: CircleAvatar(
                backgroundColor: Colors.black87,
                child: Text(
                  chatroomname[0],
                  style: TextStyle(color: Colors.white),
                ),
              ),

              title: Text(chatroomname),
              subtitle: Text(chatroomList[index]["desc"] ?? ""),
            ),
          );
        },
      ),
    );
  }
}
