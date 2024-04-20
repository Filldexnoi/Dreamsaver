import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        toolbarHeight: 75,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size:35),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Change Password',
        style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Arapey-Regular',
                  fontSize: 32
            ),
          ),
        ),
        backgroundColor: Color(0xFFEFE0F6),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 350,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white, // สีของกล่อง
                borderRadius: BorderRadius.circular(15.0), // กำหนดขอบมน
              ),
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Your Password                                  *',
                style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
          ),
          SizedBox(
              width: 332,
              height: 1.0,
              child: Container(
                color: Colors.grey, // สีของเส้นใต้
              ),
            ),
              ],
        ),
      ),
    ),
  ],
),

);
  }
}