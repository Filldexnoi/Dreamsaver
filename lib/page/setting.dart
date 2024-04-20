import 'package:dreamsaver/page/home.dart';
import 'package:dreamsaver/page/security.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _Setting_pageState();
}

class _Setting_pageState extends State<SettingPage> {
  @override
void _navigateToSecurity() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecurityPage()),
    );
  }
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
        title: const Text('Setting',
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
              child: ElevatedButton(
                onPressed: _navigateToSecurity,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, 
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Security',
                      style: TextStyle(
                        fontFamily: 'Arapey-Regular',
                        fontSize: 24,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );

  //      body: Column(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
            
  //           child: Container(
  //             padding: EdgeInsets.all(8.0), // เพิ่มระยะห่างรอบข้อความ
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(15.0),
  //           ),
  //           child: Text(
  //             'Security',
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontFamily: 'Arapey-Regular',
  //               fontSize: 18
  //               ),
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
       
  //  );


  }

}