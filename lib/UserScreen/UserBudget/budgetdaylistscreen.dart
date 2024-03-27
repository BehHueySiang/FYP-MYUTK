import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myutk/UserScreen/UserReview/addreviewscreen.dart';
import 'package:myutk/UserScreen/UserReview/editreviewscreen.dart';
import 'package:myutk/models/review.dart';
import 'package:myutk/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';
import 'package:myutk/EntryScreen/loginscreen.dart';
import 'package:myutk/UserScreen/UserReview/reviewdetailscreen.dart';



class BudgetDayListScreen extends StatefulWidget {
  final User user;
  final int number;
   final int totalbudget;
   final String selectedHotel;
  const BudgetDayListScreen({super.key, required this.user,required this.number,required this.totalbudget,required this.selectedHotel});

  @override
  State<BudgetDayListScreen> createState() => _BudgetDayListScreenState();
}

class _BudgetDayListScreenState extends State<BudgetDayListScreen> {
  Review review = Review ();
  late double screenHeight, screenWidth;
  late int axiscount = 2;
  late List<Widget> tabchildren;
  String maintitle = "Review";
    int numofpage = 1, curpage = 1, numberofresult = 0;
  List<Review> Reviewlist = <Review>[];
 
  var color;
  
  @override
  void initState() {
    super.initState();
    
  }


  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      axiscount = 3;
    } else {
      axiscount = 1;
    }
    return Scaffold(
      appBar: AppBar(
         title: Image.asset("assets/images/Logo.png"),
        backgroundColor: Colors.amber[200],
        
        actions: [ 
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_active),
          ),
        ],   
      ),
      
      backgroundColor: Colors.amber[50],
      
      body: Column(children: [
        const SizedBox(height: 20,),
        Expanded(
         child: SingleChildScrollView(
          child: Center(
                child: Column(
                  children: [
              Container(
                width: screenWidth,
                alignment: Alignment.center,
                color: Color.fromARGB(255, 239, 219, 157),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.selectedHotel,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
                    Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            widget.number,
                            (index) => GestureDetector(
                              onTap: () {
                                // Navigate to the next page here
                                // You can use Navigator.push to navigate to the next page
                                // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => NextPage()));
                              },
                              child: Card(
                                margin: EdgeInsets.all(10),
                               
                                elevation: 3, // Adjust elevation for shadow effect
                                child: Container(
                                  width: 370,
                                  height: 80,
                                   decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10), // Adjust border radius as needed
                                              color: const Color.fromARGB(255, 237, 211, 134), // You can set any color you like for the background
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [ Text(
                                        '     Day  ',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                     
                                         Text(
                                          (index + 1).toString(),
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      
                                     
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 200,),
                         Container(
                                width: screenWidth,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 177, 177, 177),
                                    borderRadius: BorderRadius.circular(10), // Adjust border radius as needed
                                  ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Budget:",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width:140),
                                      Text(
                                        "RM ",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                       Text(
                                        widget.totalbudget.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height:1),
                              Container(
                                width: screenWidth,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 177, 177, 177),
                                    borderRadius: BorderRadius.circular(10), // Adjust border radius as needed
                                  ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Budget:",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width:140),
                                      Text(
                                        "RM ",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                       Text(
                                        widget.totalbudget.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 100,),
                         Container(
                                width: screenWidth,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 142, 245, 142),
                                    borderRadius: BorderRadius.circular(10), // Adjust border radius as needed
                                  ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Budget:",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width:140),
                                      Text(
                                        "RM ",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                       Text(
                                        widget.totalbudget.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                               const SizedBox(height: 50,),
                       ] 
                      )
                     )
                    ),
                   ),
                 ]
                ),
              ); 
             }
    }