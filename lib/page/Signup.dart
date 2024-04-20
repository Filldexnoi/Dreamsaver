import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();

  void _signup() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    print('Username: $username');
    print('Password: $password');
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
                      onPressed: _signup,
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