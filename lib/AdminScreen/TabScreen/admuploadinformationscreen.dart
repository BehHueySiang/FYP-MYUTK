import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myutk/models/destination.dart';
import 'package:myutk/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';
import 'package:myutk/EntryScreen/loginscreen.dart';
import 'package:myutk/AdminScreen/AdminDestination/admdestinationlistscreen.dart';
import 'package:myutk/AdminScreen/AdminHotel/admhotellistscreen.dart';
import 'package:myutk/AdminScreen/AdminReview/admreviewlistscreen.dart';


class admuploadinformationscreen extends StatefulWidget {
  final User user;

  const admuploadinformationscreen({super.key, required this.user,});

  @override
  State<admuploadinformationscreen> createState() => _admuploadinformationscreenState();
}

class _admuploadinformationscreenState extends State<admuploadinformationscreen> {
  TextEditingController _searchController = TextEditingController();
  String maintitle = "Admupload";
 Des destination = new Des();
  late double screenHeight, screenWidth;
  late int axiscount = 2;
  int numofpage = 1, curpage = 1;
  int numberofresult = 0;
  var color;
  Des destinationinfo = Des();

  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
   
    print("Home");
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
    
    return Scaffold(
       appBar: AppBar(
        title: Image.asset(
                    "assets/images/Logo.png",
                  ),
         backgroundColor: Colors.amber[200],
         automaticallyImplyLeading: false,
        actions: [
      
              
              ]
            ),
      backgroundColor: Colors.amber[50],
              body: Center(
                
                child: Column(children: [
                  const SizedBox(height: 100,),
                        

                Expanded(
                  child:Container(
                  width: 380, // Adjust width as needed
                  height: 350, 
                  // Adjust height as needed
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Adjust border radius as needed
                    color: Colors.white, // You can set any color you like for the background
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Card(
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (content) => admdestinationlistscreen(user: widget.user, )
                            ),
                          );},
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                         ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              Colors.white.withOpacity(0.8), // Adjust the opacity level here (0.0 - 1.0)
                              BlendMode.srcOver,
                            ),
                            child: Image.asset("assets/images/hd3.jpg", width: double.infinity, height: double.infinity, fit: BoxFit.cover),
                          ),
                        Positioned(
                        child: Text(
                          "Destination",
                          style: const TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),))
                )  
                ),
                const SizedBox(height: 20,),// expand1
                 Expanded(
                  child:Container(
                  width: 380, // Adjust width as needed
                  height: 350, 
                  // Adjust height as needed
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Adjust border radius as needed
                    color: Colors.white, // You can set any color you like for the background
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Card(
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (content) => admhotellistscreen(user: widget.user, )
                            ),
                          );},
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                         ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              Colors.white.withOpacity(0.8), // Adjust the opacity level here (0.0 - 1.0)
                              BlendMode.srcOver,
                            ),
                            child: Image.asset("assets/images/hh1.jpg", width: double.infinity, height: double.infinity, fit: BoxFit.cover),
                          ),
                        Positioned(
                        child: Text(
                          "Hotel",
                          style: const TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),))
                )  
                ),// expand 2
                        const SizedBox(height: 20,),
                         Expanded(
                  child:Container(
                  width: 380, // Adjust width as needed
                  height: 350, 
                  // Adjust height as needed
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Adjust border radius as needed
                    color: Colors.white, // You can set any color you like for the background
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Card(
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (content) => AdmReviewListScreen(user: widget.user,)
                            ),
                          );},
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                         ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              Colors.white.withOpacity(0.8), // Adjust the opacity level here (0.0 - 1.0)
                              BlendMode.srcOver,
                            ),
                            child: Image.asset("assets/images/hr1.jpg", width: double.infinity, height: double.infinity, fit: BoxFit.cover),
                          ),
                        Positioned(
                        child: Text(
                          "Review",
                          style: const TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),))
                )  
                ),//Expand 3
                               
                const SizedBox(height: 100,)
        ]
      )
    ),
  );
 }
}
