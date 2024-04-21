import 'package:dreamsaver/usercontroller.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'addgoal.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
class HomePage extends StatefulWidget{
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final user = FirebaseAuth.instance.currentUser;
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
                  stream: FirebaseFirestore.instance.collection('users').doc(user?.email).collection('goallist').
                        orderBy("finishdate").snapshots(),
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
                            DateTime datenow = DateTime.now();
                            DateTime endDate =data[index]['finishdate'].toDate();
                            Duration difference = endDate.difference(datenow);
                            String daysLeft = (difference.inDays+1).toString();
                            var moneycurrent = data[index]['moneycurrent'];
                            var moneytarget = data[index]['moneytarget'];
                            print(moneycurrent);
                            print(moneytarget);
                            double persent = (moneycurrent/moneytarget)*100;
                            print(persent);
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
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(left : 20),
                                                child: Text(int.parse(daysLeft) <=1 ? daysLeft+' day left' : daysLeft+' days left',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Arapey-Regular',
                                                  fontSize: 20,
                                                ),),
                                              ),
                                              LinearPercentIndicator(
                                                width: MediaQuery.of(context).size.width * 0.45,
                                                lineHeight: 20.0,
                                                percent: persent/100, 
                                                backgroundColor: Color(0xffD3F1F8),
                                                progressColor: Color(0xFFFF59F1),
                                                animation: true,
                                                center: Text(moneycurrent.toInt().toString()+'/'+moneytarget.toInt().toString()),
                                                barRadius: Radius.circular(15), 
                                              ),
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