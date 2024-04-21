import 'package:dreamsaver/usercontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'Signup.dart';
import 'midpage.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  
  void _showErrorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text('An error occurred'),
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
  void _showEmailPasswordworingErrorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text('Invalid email or password. Please try again.'),
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
  Future<void> _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please enter email and password.'),
      ),
    );
    return;
  }
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
    print('User signed in: ${userCredential.user!.uid}');
    Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => MiddlePage()
    ));
  } on FirebaseAuthException catch (e) {
    print('Error signing in: $e');
    if (e.code == 'invalid-email') {
        _showEmailFormatErrorDialog(context);
    }
    else if (e.code == 'invalid-credential') {
      _showEmailPasswordworingErrorDialog(context);
    } else{
      _showErrorDialog(context);
    }
  }
}

  void _navigateToSignUpPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECFBFF),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 20, 0.0, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/LogoDreamSaver.png'),
                  backgroundColor: Color(0xFFECFBFF),
                  radius: 100,
                ),
                Text(
                  'DreamSaver',
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'Arapey-Regular',
                  ),
                ),
                SizedBox(height: 12.0),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 70.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    border: Border.all(color: Color(0xFFBDBDBD)),
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
                SizedBox(height: 24.0),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 70.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    border: Border.all(color: Color(0xFFBDBDBD)),
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
                SizedBox(height: 20.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFAE6ACE))
                  ),
                  onPressed: _login,
                  child: Text('Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Arapey-Regular',
                      fontSize: 20
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Text('-OR-',style: TextStyle(fontFamily: 'Arapey-Regular',fontSize: 16),),
                SizedBox(height: 20.0),
                Text('Sign in with',style: TextStyle(fontFamily: 'Arapey-Regular',fontSize: 16),),
                SizedBox(height: 20.0),
                ElevatedButton(
                  style: ButtonStyle(
                     fixedSize: MaterialStateProperty.all<Size>(
                      Size.fromWidth(75),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      final user = await UserController.loginWithGoogle();
                      if(user != null && mounted){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => MiddlePage()
                        ));
                      }
                    } on FirebaseAuthException catch (error) {
                      print(error.message);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(error.message ?? "Somrthing went wrong")
                      ));
                    }
                    catch (error) {
                      print(error);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(error.toString())
                      ));
                    }
                  },
                  child: Image.asset(
                    'assets/LogoGoogle.png',
                    height: 24,
                    ),
                ),
                SizedBox(height: 70.0),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Don’t have an account? ",
                        style: TextStyle(color: Colors.black,fontFamily: 'Arapey-Regular',fontSize: 16),
                      ),
                      TextSpan(
                        text: "Sign up",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontFamily: 'Arapey-Regular',
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = _navigateToSignUpPage,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}