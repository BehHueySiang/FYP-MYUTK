import 'package:flutter/material.dart';

import 'package:myutk/UserScreen/TabScreen/hometabscreen.dart';
import 'package:myutk/UserScreen/TabScreen/budgettabscreen.dart';
import 'package:myutk/UserScreen/TabScreen/itinerarytabscreen.dart';
import 'package:myutk/UserScreen/TabScreen/uploadinformationscreen.dart';
import 'package:myutk/UserScreen/TabScreen/profiletabscreen.dart';



import '../../models/user.dart';





class MainScreen extends StatefulWidget {
  final User user;



  const MainScreen({super.key, required this.user, });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<Widget> tabchildren;
  int _currentIndex = 0;
  String maintitle = "Home";
 
 
  @override
  void initState() {
    super.initState();
    print(widget.user.name);
    print("Mainscreen");
    tabchildren = [
      hometabscreen(user: widget.user),
      budgettabscreen(user: widget.user),
      itinerarytabscreen(user: widget.user),
      uploadinformationscreen(user: widget.user),
      ProfileTabScreen(user: widget.user,),
   
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
                label: "Home"),
                
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.attach_money_rounded,
                  color: Colors.amber,
                ),
                label: "Budget"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.text_snippet,
                  color: Colors.amber,
                ),
                label: "Itinerary"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.upload_file_sharp,
                  color: Colors.amber,
                ),
                label: "upload"),
            
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.amber,
                ),
                label: "Profile"),
            
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
        maintitle = "Home";
      }
      if (_currentIndex == 1) {
        maintitle = "Budget";
      }
      if (_currentIndex == 2) {
        maintitle = "itinerary";
      }
      if (_currentIndex == 3) {
        maintitle = "upload";
      }
      if (_currentIndex == 4) {
        maintitle = "Profile";
      }
    
    });
  }
}