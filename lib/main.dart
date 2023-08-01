import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBX6Tw18pbYAdQ5DdVN1MzxioB0dTVndB0",
        appId: "1:520560154849:web:eeec4cd9328b8c89693fa0",
        messagingSenderId: "520560154849",
        projectId: "instagramclone-868d1",
        storageBucket: "instagramclone-868d1.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram ',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: const Scaffold(
      //   body: ResponsiveLayout(
      //     mobileScreenLayout: MobileScreen(),
      //     webScreenLayout: WebScreen(),
      //   ),
      // ),
      home: const SignUpScreen(),
    );
  }
}
