import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:globalchat/firebase_options.dart';
import 'package:globalchat/screens/provider/Userprovider.dart';
import 'package:globalchat/screens/provider/themeprovider.dart';
// import 'package:globalchat/screens/provider/themeprovider.dart';
import 'package:globalchat/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Userprovider()),
        ChangeNotifierProvider(create: (context) => Themeprovider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Provider.of<Themeprovider>(context, listen: false).loadMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var themeprovider = Provider.of<Themeprovider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: themeprovider.isDarkModeChecked
          ?ThemeData.light(useMaterial3: true).copyWith(
              textTheme: ThemeData.light(
                useMaterial3: true,
              ).textTheme.apply(fontFamily: "Poppins"),
            ):
          
           ThemeData.dark(useMaterial3: true).copyWith(
              textTheme: ThemeData.dark(
                useMaterial3: true,
              ).textTheme.apply(fontFamily: "Poppins"),
            ),
          

      home: SplashScreen(),
    );
  }
}
