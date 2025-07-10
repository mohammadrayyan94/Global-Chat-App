import 'package:flutter/material.dart';

import 'package:globalchat/screens/provider/themeprovider.dart';
import 'package:provider/provider.dart';

class Themeswitcher extends StatefulWidget {
  const Themeswitcher({super.key});

  @override
  State<Themeswitcher> createState() => _ThemeswitcherState();
}

class _ThemeswitcherState extends State<Themeswitcher> {
  @override
  Widget build(BuildContext context) {
    var themeprovider = Provider.of<Themeprovider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "Theme mode",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: [
            Switch(
              value: themeprovider.isDarkModeChecked,
              onChanged: (value) {
                themeprovider.updateMode(darkMode: value);

                setState(() {});
              },
            ),
            SizedBox(width: 20),
            Text(themeprovider.isDarkModeChecked ? "Light mode":"Dark Mode" ),
          ],
        ),
      ],
    );
  }
}
