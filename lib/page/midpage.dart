import 'home.dart';
import 'package:flutter/material.dart';
import 'package:dreamsaver/usercontroller.dart';
import 'setting.dart';
import 'calendar.dart';
import 'profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class MiddlePage extends StatefulWidget {
  const MiddlePage({super.key});

  @override
  State<MiddlePage> createState() => _MiddlePageState();
}

class _MiddlePageState extends State<MiddlePage> {
  int currentPageIndex = 0;
  
  final List<Widget>_bodypage =[
    const HomePage(),
    const CalendarPage(),
    const ProfilePage(),
  ];
  
  
  Widget getTitle(int index) {
    switch (index) {
      case 0:
        return StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').doc(UserController.user?.email).snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;
            String? name = userData['name'];
            bool? check = UserController.user?.providerData.any((userInfo) => userInfo.providerId == 'google.com');
            if (check!=null) {
              if(check){
                return Text(UserController.user?.displayName ?? '',style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Arapey-Regular',
                  fontSize: 24
                ),);
              } else {
                  return Text(name!,style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Arapey-Regular',
                    fontSize: 24
                ),);
              }
            }else{
              return const Text('');
            }
          }
        );
      case 1:
        return const Text('Calendar',style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Arapey-Regular',
                  fontSize: 32
            ),);
      case 2:
        return const Text('Profile',style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Arapey-Regular',
                  fontSize: 32
            ),);
      default:
        return Text(UserController.user?.displayName ?? '',style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Arapey-Regular',
                  fontSize: 32
            ),);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: 75,
        centerTitle: currentPageIndex == 0 ? false : true,
        leading: currentPageIndex == 0 ? StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').doc(UserController.user?.email).snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;
            String? profileImageUrl = userData['profilepic'];

            if (profileImageUrl != null && profileImageUrl.isNotEmpty){
              return Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(profileImageUrl),
                ),
              );
            } else{
              return Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Icon(Icons.account_circle,size: 50,)
                );
            }
          },
          
        ) : null,
        title: getTitle(currentPageIndex),
        actions: currentPageIndex == 0
            ?[Container(
          margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: IconButton(
            icon: Icon(Icons.settings_outlined,size: 35),
             onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingPage()),);  
             }
            )
          )
        ] : null,
      ),
      backgroundColor : Color(0xffEFE0F6),
      body : _bodypage[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        onDestinationSelected: (int index) { 
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Color(0xFFEFE0F6),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home,size: 40),
            icon: Icon(Icons.home_outlined,size: 40,),
            label: 'Home',
          ),
          NavigationDestination(
            icon:Icon(Icons.calendar_month_outlined,size: 40),
            label: 'Calendar',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle_outlined,size: 40),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}