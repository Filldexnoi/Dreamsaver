import 'package:dreamsaver/usercontroller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(foregroundImage: NetworkImage(UserController.user?.photoURL ?? ''),),
        title: Text(UserController.user?.displayName ?? ''),
        actions: [Icon(Icons.settings_outlined)],
      ),
      body: Container()
    );
  }
}