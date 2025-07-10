import 'package:flutter/material.dart';
import 'package:globalchat/screens/provider/themeprovider.dart';
import 'package:globalchat/widgets/themeswitcher.dart';
// import 'package:funfacts/Provider/themeprovider.dart';

// import 'package:funfacts/widgets/themeSwitcher.dart';
import 'package:provider/provider.dart'; // ✅ Already correct

class Settingscreen extends StatefulWidget {
  const Settingscreen({super.key});

  @override
  State<Settingscreen> createState() => _SettingscreenState();
}

class _SettingscreenState extends State<Settingscreen> {
  @override
  Widget build(BuildContext context) {
    var themeprovider = Provider.of<Themeprovider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Column(children: [Themeswitcher()]),
    );
  }
}
