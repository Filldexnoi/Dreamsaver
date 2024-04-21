import 'package:flutter/material.dart';

class SalaryPage extends StatefulWidget {
  const SalaryPage({super.key});

  @override
  State<SalaryPage> createState() => _SalaryPageState();
}

class _SalaryPageState extends State<SalaryPage> {
  TextEditingController _salaryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        toolbarHeight: 75,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size:35),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Security',
        style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Arapey-Regular',
                  fontSize: 32
            ),
          ),
          backgroundColor: Color(0xFFEFE0F6) ,
      ),
     body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Salary:',
              style: TextStyle(fontSize: 20,fontFamily: 'Arapey-Regular')
            ),
            SizedBox(height: 10),
            TextField(
              controller: _salaryController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter your salary',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                
              ),
              
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Do something with the entered salary
                String salary = _salaryController.text;
                // Handle the salary data here
                print('Entered salary: $salary');
              },
              child: Text('Confirm',
              style: TextStyle(fontSize: 20,fontFamily: 'Arapey-Regular')),
            ),
          ],
        ),
      ),
    );
  }
}
