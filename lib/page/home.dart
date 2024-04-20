import 'package:dreamsaver/usercontroller.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'addgoal.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? email = UserController.user?.email;
  void _navigateToAddgoal() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddGoalPage()),
    );
  }
  Widget build(BuildContext context) {
    return Column(
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
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('users').doc(email).collection('goallist').snapshots(),
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
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.fromLTRB(20, 5, 20, 10),
                                        width: double.infinity,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: Image.network(
                                            data[index]['image_url'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(20, 5, 20, 10),
                                      width: double.infinity,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: Colors.white
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(data[index]['name'],
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Arapey-Regular',
                                                fontSize: 20,
                                              ),)
                                            ],
                                          ),
                                          //daysLeft(data[index]['startdate'], data[index]['finishdate']
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(data[index]['startdate'].toString(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Arapey-Regular',
                                                fontSize: 20,
                                              ),)
                                            ],
                                          ),
                                        ],),
                                    )
                                  ],
                                )
                              ],
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
      ); 
  }
}