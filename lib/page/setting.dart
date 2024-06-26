
import 'package:dreamsaver/page/security.dart';
import 'package:dreamsaver/usercontroller.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  void _navigateToSecurity() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecurityPage()),
      );
    }
  void signout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    if(mounted){
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false, 
    );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        toolbarHeight: 75,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size:25),
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
       body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
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
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: ElevatedButton(
                  style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFAE6ACE)),
                    ),
              onPressed: signout,
              child: Text('Log Out',
              style: TextStyle(
                fontFamily: 'Arapey-Regular',
                fontSize: 24,
                color: Colors.white
                ),
              ),             
            ),
          ),
        ],
      ),
    );
  }
 }
