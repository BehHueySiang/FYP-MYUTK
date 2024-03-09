import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myutk/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';
import 'package:myutk/EntryScreen/loginscreen.dart';




class admdestinationdetailscreen extends StatefulWidget {
  final User user;
  const admdestinationdetailscreen({super.key, required this.user});

  @override
  State<admdestinationdetailscreen> createState() => _admdestinationdetailscreenState();
}

class _admdestinationdetailscreenState extends State<admdestinationdetailscreen> {
  
  String maintitle = "Destination Detail";
 
  late double screenHeight, screenWidth;
  late int axiscount = 2;
   
  var color;

  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
   
    print("Destination List");
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
      axiscount = 2;
    }
   
    return Scaffold(
       appBar: AppBar(
        title: Image.asset(
                    "assets/images/Logo.png",
                  ),
         backgroundColor: Colors.amber[200],
        actions: [
        
             IconButton(
              onPressed: () {
                
              },
              icon: const Icon(Icons.notifications_active)),
       
              
              ]
            ),
             backgroundColor: Colors.amber[50],
              body: Center(
                
                child: Column(children: [
                  const SizedBox(height: 20,),
                   Container(
                              width: screenWidth,
                              alignment: Alignment.center,
                              color: Color.fromARGB(255, 243, 194, 35),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Destination',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ),
                                Card(
            child: SizedBox(
              height: screenHeight / 3.5,
             child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                    child: Card(
                      child: Container(
                        width: screenWidth,
                       child: Image.asset("assets/images/detail1.jpg", width: 200, height: 100, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                    child: Card(
                      child: Container(
                        width: screenWidth,
                        child: Image.asset("assets/images/detail2.jpg", width: 200, height: 100, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                    child: Card(
                      child: Container(
                        width: screenWidth,
                       child: Image.asset("assets/images/detail3.jpg", width: 200, height: 100, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              " Gua Kelam",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )),
        Expanded(
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(4),
                1: FlexColumnWidth(6),
              },
              children: [
                TableRow(children: [
                  const TableCell(
                    child: Text(
                      "Direction Link: ",
                      style: TextStyle(fontWeight: FontWeight.bold, height: 4),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      "",
                    ),
                  )
                ]),
                TableRow(children: [
                  const TableCell(
                    child: Text(
                      "Open Time: 10:00a.m ",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13, height: 4),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      "                          Closed Time: 5:00p.m ",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13, height: 4),
                    ),
                  )
                ]),
TableRow(children: [
                  const TableCell(
                    child: Text(
                      "Suggest Time: 2:00 p.m.",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13, height: 4),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      "  ",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13, ),
                    ),
                  )
                ]),
TableRow(children: [
                  const TableCell(
                    child: Text(
                      "Activities: ",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13, height: 4),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      "",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13, height: 4),
                    ),
                  )
                ]),
TableRow(children: [
                  const TableCell(
                    child: Text(
                      "Notes: ",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13, height: 4),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      " ",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13, height: 4),
                    ),
                  )
                ]),
TableRow(children: [
                  const TableCell(
                    child: Text(
                      "Estimate Budget: ",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,height: 4),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      "                          Rate: 9/10",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13, height: 4),
                    ),
                  )
                ]),
                
                TableRow(children: [
                  const TableCell(
                    child: Text(
                      "RM 12.00 Per person ",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      " ",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),
                    ),
                  )
                ]),
                
              ],
            ),
          ),
        ),                  
                            
                            
                            ])));}}