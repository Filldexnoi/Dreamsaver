import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
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
        title: const Text(
          'Change Password',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Arapey-Regular',
            fontSize: 32
          ),
        ),
      ),
      backgroundColor: Color(0xFFEFE0F6),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white, 
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true, // เราต้องการให้เป็นช่องข้อความรหัสผ่าน
                  decoration: InputDecoration(
                    hintText: 'Your password',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: TextField(
                  controller: _newPasswordController,
                  obscureText: true, // เราต้องการให้เป็นช่องข้อความรหัสผ่าน
                  decoration: InputDecoration(
                    hintText: 'New password',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: TextField(
                  controller: _confirmPasswordController,
                  obscureText: true, // เราต้องการให้เป็นช่องข้อความรหัสผ่าน
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 20),
                    hintText: 'Confirm password',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
            
          ),
          Container(
                child: ElevatedButton(
                  style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFAE6ACE)),
                    ),
              onPressed: () {
                
              },
              child: Text('Confirm',
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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:AppBar(
//         centerTitle: true,
//         toolbarHeight: 75,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios, size:35),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: const Text('Change Password',
//         style: TextStyle(
//                   color: Colors.black,
//                   fontFamily: 'Arapey-Regular',
//                   fontSize: 32
//             ),
//           ),
//         ),
//         backgroundColor: Color(0xFFEFE0F6),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//           Container(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 width: double.infinity,
//                 height: 80,
//                 decoration: BoxDecoration(
//                   color: Colors.white, 
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//                 padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
//                 child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Text('Your password',
//                   style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.grey,
//                 ),
//             ),
//             SizedBox(
//                 width: 360,
//                 height: 1.0,
//                 child: Container(
//                   color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//          Container(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 width: double.infinity,
//                 height: 80,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//                 padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                       'New password',
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 360,
//                       height: 1.0,
//                       child: Container(
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//            Container(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 width: double.infinity,
//                 height: 80,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//                 padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                       'Confirm password',
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 360,
//                       height: 1.0,
//                       child: Container(
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//       ],
//     ),
//   );
// }
// }