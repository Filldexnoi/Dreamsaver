import 'package:dreamsaver/page/editprofile.dart';
import 'package:dreamsaver/page/salary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dreamsaver/usercontroller.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser;
  String email = UserController.user!.email!;

  void _navigateToEdit(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditprofilePage()),
    );
  }
  void _navigateToSalary() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SalaryPage()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [Column(
      children: [
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: user!.photoURL == null ? Icon(Icons.account_circle,size: 150,): 
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(user!.photoURL!),
                  fit: BoxFit.fitHeight,
                ),
              ),
            )
          ),
        ),
        StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(user?.email).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.data == null){
            return Container();
          }
          Map<String?, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;
          String? name = userData['name'];
          bool? check = UserController.user?.providerData.any((userInfo) => userInfo.providerId == 'google.com');
          if (check!=null) {
            if(check){
              return Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: Text(UserController.user?.displayName ?? '',style: const TextStyle(
                  color:  Color(0xff50555C),
                  fontFamily: 'Arapey-Regular',
                  fontSize: 24,
                ),),
              );
            } else {
                return Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                  child: Text(name!,style: const TextStyle(
                    color:  Color(0xff50555C),
                    fontFamily: 'Arapey-Regular',
                    fontSize: 24
                  ),),
                );
            }
          }else{
            return const Text('');
          }
        }
      ),
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Text(
            user!.email!,
            style: TextStyle(
              fontSize: 24,
              color: Color(0xff50555C),
              fontFamily: 'Arapey-Regular',
            ),
          ),
        ),
        ],
      ),
      Container(
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
          color: Colors.white
        ),
        child: Column(
          children: [
            TextField(
              readOnly: true,
                decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Picture and Username',
                      hintStyle: TextStyle(color: Colors.black,fontFamily: 'Arapey-Regular',fontSize: 24),
                      suffixIcon: IconButton(
                      icon: Icon(Icons.arrow_forward_ios_rounded,size: 24,),
                      onPressed : _navigateToEdit
                    ),
                ),
                style: TextStyle(
                  fontSize: 24, 
                  fontFamily: 'Arapey-Regular',
                  color: Colors.black, 
                ),
              ),
            TextField(
              readOnly: true,
                decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Salary',
                      hintStyle: TextStyle(color: Colors.black,fontFamily: 'Arapey-Regular',fontSize: 24),
                      suffixIcon: IconButton(
                      icon: Icon(Icons.arrow_forward_ios_rounded,size: 24,),
                      onPressed : _navigateToSalary,
                      
                    ),
                ),
                style: TextStyle(
                  fontSize: 24, 
                  fontFamily: 'Arapey-Regular',
                  color: Colors.black, 
                ),
              ),
          ],
        ),
      )
      ]
    );
  }
}
