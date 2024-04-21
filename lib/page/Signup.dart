import 'package:dreamsaver/page/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();

  Future<void> _saveUserData(String username, String email) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(email).set({
      'email': email,
      'name' : username,
      'profilepic' : null,
    });
    print('User data saved to Firestore');
  } catch (e) {
    print('Error saving user data: $e');
  }
  }
  void _showPasswordMismatchDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Password Mismatch'),
        content: Text('The passwords do not match. Please try again.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
  }
  void _showEmailFormatErrorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text('The email address is badly formatted. Please enter a valid email address.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // ปิดกล่องโต้ตอบ
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
  void _showEmailExistsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Email Already Exists'),
        content: Text('The email address is already registered. Please try another email address.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // ปิดกล่องโต้ตอบ
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
  Future<void> _signUp() async {
    if (_passwordController.text != _confirmpasswordController.text) {
      _showPasswordMismatchDialog(context);
      return;
    }
    try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      print('User signed up: ${userCredential.user!.uid}');
      await _saveUserData(_usernameController.text, _emailController.text.trim());
      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LoginPage()
      ));
    } catch (e) {
      if (e is FirebaseAuthException && e.code == 'invalid-email') {
        _showEmailFormatErrorDialog(context);
    } else if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
        _showEmailExistsDialog(context);
    } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error signing up: $e'),
          ),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECFBFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFECFBFF),
        leading: IconButton(
          icon: Icon(Icons.close_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(40.0, 0, 40.0, 20.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                child:  Padding(
                  padding:  EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text('Sign Up',
                      style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'Arapey-Regular',
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(15.0),
                        ),
                      child: TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: 'Username',
                          hintStyle: TextStyle(color: Color(0xFFB9BDC2),fontFamily: 'Arapey-Regular'),
                          contentPadding: EdgeInsets.all(12.0),
                          border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(15.0),
                        ),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Color(0xFFB9BDC2),fontFamily: 'Arapey-Regular'),
                          contentPadding: EdgeInsets.all(12.0),
                          border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(15.0),
                        ),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Color(0xFFB9BDC2),fontFamily: 'Arapey-Regular'),
                          contentPadding: EdgeInsets.all(12.0),
                          border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(15.0),
                        ),
                      child: TextField(
                        controller: _confirmpasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(color: Color(0xFFB9BDC2),fontFamily: 'Arapey-Regular'),
                          contentPadding: EdgeInsets.all(12.0),
                          border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 40.0),
                      ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFAE6ACE))
                      ),
                      onPressed: _signUp,
                      child: Text('Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Arapey-Regular',
                          fontSize: 20
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
          ],
              ),
        ),
      ),
   );
  }
}