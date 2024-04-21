import 'dart:io';
import 'package:dreamsaver/usercontroller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
class AddGoalPage extends StatefulWidget {
  const AddGoalPage({super.key});

  @override
  State<AddGoalPage> createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _moneytargetController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _finishController = TextEditingController();
  final TextEditingController _moneyperdayController = TextEditingController();
  File? _image;
  DateTime? _startdate;
  DateTime? _finishdate;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _nameController.dispose();
    _moneytargetController.dispose();
    _startController.dispose();
    _finishController.dispose();
    _moneyperdayController.dispose();
    super.dispose();
  }
  
  
  Future<void> addgoal(String? useremail, String name, double? moneytarget,DateTime? start
  ,DateTime? finish,num moneyperday,String imgurl) async {
    try {
      DocumentReference docRef = await firestore.collection('users').doc(useremail).collection('goallist').add({
        'name': name,
        'moneytarget': moneytarget,
        'moneyperday': moneyperday,
        'startdate': start,
        'finishdate': finish,
        'image_url': imgurl,
        'moneycurrent' : 0,
      });
      for (DateTime? date = start; date!.isBefore(finish!.add(const Duration(days: 1))); date = date.add(Duration(days: 1))) {
        await firestore.collection('users').doc(useremail).collection('goallist')
        .doc(docRef.id).collection('dailydata').doc(date.toString()).set({
            'checkstatus': false,
        });
      }
      print('Data added successfully!');
    } catch (e) {
      print('Error adding data: $e');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        toolbarHeight: 75,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Add Goal',
                  style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Arapey-Regular',
                  fontSize: 32
                ),
              ),
      ),
      backgroundColor : Color(0xFFF4EFF6),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [ 
              GestureDetector(
                  onTap: () {
                    _selectImage();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      children: [
                        if (_image != null) 
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Opacity(
                                opacity: 0.5,
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        Center(
                          child: Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 100,
                            color: Color(0xff53C9D0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(top: 20),
                      hintText: 'Name',
                      hintStyle: TextStyle(color: Color(0xFFB9BDC2),fontFamily: 'Arapey-Regular',fontSize: 24),  
                      ),
                style: const TextStyle(
                  fontSize: 24, 
                  fontFamily: 'Arapey-Regular',
                  color: Colors.black, 
                ),
               ),
              TextField(
                controller: _moneytargetController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(top: 20),
                      hintText: 'Money Target',
                      hintStyle: TextStyle(color: Color(0xFFB9BDC2),fontFamily: 'Arapey-Regular',fontSize: 24),  
                      ),
                style: const TextStyle(
                  fontSize: 24, 
                  fontFamily: 'Arapey-Regular',
                  color: Colors.black, 
                ),
              ),
              TextField(
                style: const TextStyle(
                  fontSize: 24, 
                  fontFamily: 'Arapey-Regular',
                  color: Colors.black, 
                ),
                controller: _startController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 20),
                  hintText: 'Start Date',
                  hintStyle: TextStyle(color: Color(0xFFB9BDC2),fontFamily: 'Arapey-Regular',fontSize: 24),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.arrow_drop_down,size: 40,),
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2015, 8),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _startdate = pickedDate;
                          _startController.text = DateFormat.yMd().format(pickedDate); 
                        });
                      }
                    },
                  ),
                ),
                readOnly: true,
              ),
              TextField(
                style: const TextStyle(
                  fontSize: 24, 
                  fontFamily: 'Arapey-Regular',
                  color: Colors.black, 
                ),
                controller: _finishController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 20),
                  hintText: 'Finish Date',
                  hintStyle: TextStyle(color: Color(0xFFB9BDC2),fontFamily: 'Arapey-Regular',fontSize: 24),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.arrow_drop_down,size: 40,),
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2015, 8),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _finishdate = pickedDate;
                          _finishController.text = DateFormat.yMd().format(pickedDate); 
                        });
                      }
                    },
                  ),
                ),
                readOnly: true,
              ),
              TextField(
                controller: _moneyperdayController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(top: 20),
                      hintText: 'Min money save per day (optional)',
                      hintStyle: TextStyle(color: Color(0xFFB9BDC2),fontFamily: 'Arapey-Regular',fontSize: 24),  
                      ),
                style: const TextStyle(
                  fontSize: 24, 
                  fontFamily: 'Arapey-Regular',
                  color: Colors.black, 
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 120,vertical: 30),
                child: ElevatedButton(
                  style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFAE6ACE)),
                    ),
                  onPressed: _saveData,
                  child: const Text('Save',
                            style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Arapey-Regular',
                            fontSize: 24
                            ),
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  Future<void> _saveData() async {
    if (_nameController.text.isEmpty ||
        _image == null ||
        _moneytargetController.text.isEmpty||
        _startdate == null ||
        _finishdate == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill in all fields.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }
    else if (double.parse(_moneytargetController.text).toInt()==0){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Money target less than 1'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }
    final storageRef = FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch.toString()}');
    final uploadTask = storageRef.putFile(_image!);

    final TaskSnapshot snapshot = await uploadTask;
    final imageUrl = await snapshot.ref.getDownloadURL();
    num moneyperday;
    if(_moneyperdayController.text.isNotEmpty){
      moneyperday = double.parse(_moneyperdayController.text);
    }else{
      int difference = _finishdate!.difference(_startdate!).inDays;
      moneyperday = (double.parse(_moneytargetController.text)/difference).ceil();
    }
    // Save data to Firestore
    addgoal(UserController.user?.email,
    _nameController.text,
    double.tryParse(_moneytargetController.text),
    _startdate,
    _finishdate,
    moneyperday,
    imageUrl
    ).then((value) {
      Navigator.of(context).pop();
    }).catchError((error) {
      // Error saving data
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to save data. Please try again later.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }
}