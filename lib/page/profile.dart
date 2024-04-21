import 'package:dreamsaver/page/editprofile.dart';
import 'package:dreamsaver/page/salary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
  @override
  void _navigateToEdit(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditprofilePage()),
    );
  }
  void _navigateToSalary() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SalaryPage()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFE0F6),
      body: Center(
        child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.network(
                'https://w0.peakpx.com/wallpaper/409/354/HD-wallpaper-ten-nct-chittaphon-kpop-love-holic-nct-nct-127-nct-dream-nct-u-nctzen-wayv.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            'User Name',
            style: TextStyle(
              fontFamily: 'Arapey-Regular',
              fontSize: 20
            ),
          ),
          Text(
            'user@example.com',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
           ElevatedButton(
                onPressed: _navigateToEdit,
                 child: Row(
                mainAxisSize: MainAxisSize.min, // This will take the minimum space that children need
                children: [
                  Text('Username and Picture'),
                  Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
              ),
              ElevatedButton(
                onPressed: _navigateToSalary,
                 child: Row(
                mainAxisSize: MainAxisSize.min, // This will take the minimum space that children need
                children: [
                  Text('Salary'),
                  Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
              ),
        ],
          ),
      ),
    );
  }
}
