import 'home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dreamsaver/usercontroller.dart';
import 'setting.dart';
import 'calendar.dart';
import 'profile.dart';
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
        return Text(UserController.user?.displayName ?? '',style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Arapey-Regular',
                  fontSize: 24
            ),);
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
        leading: currentPageIndex == 0 ? Container(
          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: CircleAvatar(foregroundImage: NetworkImage(UserController.user?.photoURL ?? ''),)): null,
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