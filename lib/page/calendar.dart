import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dreamsaver/usercontroller.dart';
import 'package:intl/intl.dart';
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  String? email = UserController.user?.email;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  void _onDayselected(DateTime selectedDay, DateTime focusedDay) {
    print(selectedDay);
    setState(() {
      today = selectedDay;
    });
    _loadDataForSelectedDay(selectedDay);
  }
  void _loadDataForSelectedDay(DateTime selectedDayy){

  }
  Future<void> _savedata(num moneycurrent) async {
     try {
      await firestore.collection('users').doc(email).collection('goallist').doc(docid2).update({
      'moneycurrent': FieldValue.increment(moneycurrent),
      });
      print('Field incremented successfully');
    } catch (error) {
      print('Error incrementing field: $error');
    }
  }
  void _dontsavedata(){

  }
  bool isSaved = false;
  bool isSaved2 = false;
  num moneyperday2 = 0;
  String docid2 = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            color: Colors.white,
            child: TableCalendar(
              rowHeight: 42,
              focusedDay: today, 
              firstDay: DateTime.utc(2015), 
              lastDay: DateTime.utc(2101),
              headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
              availableGestures: AvailableGestures.all,
              onDaySelected: _onDayselected,
              selectedDayPredicate: (day)=>isSameDay(day, today),
              ),
          ),
          Expanded(
              child: isSaved ?Container() :Center(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('users').doc(email).collection('goallist').
                        orderBy("name").snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      List<DocumentSnapshot<Map<String, dynamic>>>? data = snapshot.data?.docs;
                      if (data == null || data.isEmpty) {
                        return const Text('Today don’t save money',
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
                            String name = data[index]['name'];
                            num moneyperday = data[index]['moneyperday'];
                            moneyperday2 = moneyperday;
                            String docid = data[index].id;
                            docid2 = docid;
                            return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.fromLTRB(0, 20, 0, 5),
                                            width: double.infinity,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: Color(0xffFFF2C2),
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(name,
                                                  style: const TextStyle(
                                                    fontSize: 24, 
                                                    fontFamily: 'Arapey-Regular',
                                                    color: Colors.black, 
                                                  ),
                                                ),
                                                Text(moneyperday.toString()+' THB',
                                                  style: const TextStyle(
                                                    fontSize: 24, 
                                                    fontFamily: 'Arapey-Regular',
                                                    color: Colors.black, 
                                                  ),
                                                ),
                                                // Checkbox(
                                                //   value: boolList[index],
                                                //   activeColor: Color(0xff9747FF),
                                                //   tristate: true,
                                                //   onChanged: (value) {
                                                //     setState(() {
                                                //       boolList[index] = value;
                                                //     });
                                                //   },
                                                // ),
                                              ],
                                            )
                                        ),
                                      ],
                                    );
                                  }
                                );
                              } 
                            }
                          }
                        )
                      )
                      ),
            Padding(
              padding: const EdgeInsets.only(top:11),
              child: !isSaved ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFAE6ACE)),
                    minimumSize: MaterialStateProperty.all<Size>(Size(145,40)),
                  ),
                  onPressed: () {
                    _savedata(moneyperday2);
                    setState(() {
                      isSaved2 = true;
                      isSaved = true;
                    });
                  },
                  child: Text('Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Arapey-Regular',
                      fontSize: 24
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFBDBDBD)),
                    minimumSize: MaterialStateProperty.all<Size>(Size(140,40)),
                  ),
                  onPressed: () {
                    _dontsavedata();
                    setState(() {
                      isSaved = true;
                    });
                  },
                  child: Text('Don’t Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Arapey-Regular',
                      fontSize: 24
                    ),
                  ),
                ),
              ],
            ) : (isSaved2 ? Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Text('Successful!',
                  style: TextStyle(
                    color: Color(0xFFACACAC),
                    fontFamily: 'Arapey-Regular',
                    fontSize: 36
                  ),
                ),
            ): Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Text('Today don’t save money',
                style: TextStyle(
                  color: Color(0xFFACACAC),
                  fontFamily: 'Arapey-Regular',
                  fontSize: 36
                ),),
              )
            )
          )
        ] 
      )
    );
  }
}

                  
                  
                
              
            
  