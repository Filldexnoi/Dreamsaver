import 'package:dreamsaver/usercontroller.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'addgoal.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

 void _navigateToAddgoal() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddGoalPage()),
    );
  }
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Container(
                alignment: Alignment.center,
                width: 125,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xFFD3F1F8), 
                  borderRadius: BorderRadius.circular(45), 
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: Text('My Goal',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Arapey-Regular',
                        fontSize: 18
                          ),
                      ),
                ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    fixedSize: Size(125, 40),
                    side: BorderSide(color: Colors.white, width: 1),
                    backgroundColor: Color(0xFFD3F1F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45),
                      ),
                    ),
                    onPressed: _navigateToAddgoal,
                    child: Text('Add Goal+',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Arapey-Regular',
                        fontSize: 18
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: FutureBuilder(
                  future: FirebaseFirestore.instance.collection('your_collection').get(),
                  builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      List<DocumentSnapshot<Map<String, dynamic>>>? data = snapshot.data?.docs;
                      if (data == null || data.isEmpty) {
                        return const Text('Now Don’t have goal',
                                style: TextStyle(
                                  color: Color(0xFFACACAC),
                                  fontFamily: 'Arapey-Regular',
                                  fontSize: 36
                                ),
                              );
                      } else {
                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Data: ${data[index]['your_data_field']}'),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    }
                  },
                ),
              ),
            ),
        ],
      ),
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