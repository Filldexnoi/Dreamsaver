import 'package:dreamsaver/usercontroller.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        leading: Container(
          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: CircleAvatar(foregroundImage: NetworkImage(UserController.user?.photoURL ?? ''),)),
        title: Text(UserController.user?.displayName ?? ''),
        actions: [Container(
          margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: IconButton(
            icon: Icon(Icons.settings_outlined,size: 35),
             onPressed: () {
              
             }
            )
          )
        ],
      ),
      backgroundColor: Color(0xFFEFE0F6),
      body: Container(),
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