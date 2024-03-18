import 'package:flutter/material.dart';

import 'package:myutk/AdminScreen/TabScreen/admhometabscreen.dart';
import 'package:myutk/AdminScreen/TabScreen/admbudgettabscreen.dart';
import 'package:myutk/AdminScreen/TabScreen/admitinerarytabscreen.dart';
import 'package:myutk/AdminScreen/TabScreen/admuploadinformationscreen.dart';
import 'package:myutk/AdminScreen/TabScreen/admprofiletabscreen.dart';



import '../../../models/user.dart';
import '../../../models/destination.dart';





class AdminMainScreen extends StatefulWidget {
  final User user;




  const AdminMainScreen({super.key, required this.user, });

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  late List<Widget> tabchildren;
  int _currentIndex = 0;
  String maintitle = "Home";
 
 
  @override
  void initState() {
    super.initState();
    print(widget.user.name);
    print("AdminMainScreen");
    tabchildren = [
      admhometabscreen(user: widget.user),
      admbudgettabscreen(user: widget.user),
      admitinerarytabscreen(user: widget.user),
      admuploadinformationscreen(user: widget.user,),
      admProfileTabScreen(user: widget.user,),
   
    ];
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: tabchildren[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.amber,
                ),
                label: "AdmHome"),
                
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.attach_money_rounded,
                  color: Colors.amber,
                ),
                label: "AdmBudget"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.text_snippet,
                  color: Colors.amber,
                ),
                label: "AdmItinerary"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.upload_file_sharp,
                  color: Colors.amber,
                ),
                label: "Admupload"),
            
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.amber,
                ),
                label: "AdmProfile"),
            
          ],
               selectedItemColor: Colors.amber[700],
           selectedLabelStyle: TextStyle(color: Colors.amber[700],)
          ),
    );
  }

  void onTabTapped(int value) {
    setState(() {
      _currentIndex = value;
      if (_currentIndex == 0) {
        maintitle = "AdmHome";
      }
      if (_currentIndex == 1) {
        maintitle = "AdmBudget";
      }
      if (_currentIndex == 2) {
        maintitle = "Admitinerary";
      }
      if (_currentIndex == 3) {
        maintitle = "Admupload";
      }
      if (_currentIndex == 4) {
        maintitle = "AdmProfile";
      }
    
    });
  }
}