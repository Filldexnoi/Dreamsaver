import 'package:dreamsaver/page/midpage.dart';
import 'package:dreamsaver/usercontroller.dart';
import 'package:flutter/material.dart';
import 'page/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized () ;
  await Firebase.initializeApp (
    options : DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool? check = false;
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:LoginPage(),//UserController.user != null ? const MiddlePage() : LoginPage(),
    );
  }
}