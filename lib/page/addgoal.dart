import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
class AddGoalPage extends StatefulWidget {
  const AddGoalPage({super.key});

  @override
  State<AddGoalPage> createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
  final TextEditingController _textFieldController = TextEditingController();
  File? _image;
  int? _moneytarget;
  int? _moneyperday;
  DateTime? _startdate;
  DateTime? _finishdate;
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
      body: Padding(
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
              controller: _textFieldController,
              decoration: InputDecoration(labelText: 'Enter String'),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _moneytarget = int.tryParse(value);
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Integer 1'),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _moneyperday = int.tryParse(value);
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Integer 2'),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _selectDate(true),
                    child: Text('Select Date 1'),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _selectDate(false),
                    child: Text('Select Date 2'),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _saveData,
              child: Text('Save Data'),
            ),
          ],
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

  Future<void> _selectDate(bool isFirstDate) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        if (isFirstDate) {
          _startdate = selectedDate;
        } else {
          _finishdate = selectedDate;
        }
      });
    }
  }

  Future<void> _saveData() async {
    if (_textFieldController.text.isEmpty ||
        _image == null ||
        _moneytarget == null ||
        _moneyperday == null ||
        _startdate == null ||
        _finishdate == null) {
      // Validate input fields
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
    final storageRef = FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}');
    final uploadTask = storageRef.putFile(_image!);

    final TaskSnapshot snapshot = await uploadTask;
    final imageUrl = await snapshot.ref.getDownloadURL();
    // Save data to Firestore
    await FirebaseFirestore.instance.collection('your_collection').add({
      'string_field': _textFieldController.text,
      'moneytarget': _moneytarget,
      'moneyperday': _moneyperday,
      'startdate': _startdate,
      'finishdate': _finishdate,
      'image_url': imageUrl,
    }).then((value) {
      // Data saved successfully
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