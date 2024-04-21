import 'package:flutter/material.dart';

class EditprofilePage extends StatefulWidget {
  const EditprofilePage({super.key});

  @override
  State<EditprofilePage> createState() => _EditprofilePageState();
}

class _EditprofilePageState extends State<EditprofilePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      centerTitle: true,
        toolbarHeight: 75,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size:35),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Edit personal information',
        textAlign: TextAlign.center,
        style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Arapey-Regular',
                  fontSize: 28
            ),
          ),
      ),
      backgroundColor: Color(0xFFEFE0F6),
   );
  }
} 