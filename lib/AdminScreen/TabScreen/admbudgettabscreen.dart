import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myutk/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';
import 'package:myutk/EntryScreen/loginscreen.dart';



class admbudgettabscreen extends StatefulWidget {
  final User user;
  const admbudgettabscreen({super.key, required this.user});

  @override
  State<admbudgettabscreen> createState() => _admbudgettabscreenState();
}

class _admbudgettabscreenState extends State<admbudgettabscreen> {
  String maintitle = "AdmBudget";
 
  late double screenHeight, screenWidth;
  late int axiscount = 2;
  int numofpage = 1, curpage = 1;
  int numberofresult = 0;
  var color;
  int cartqty = 0;

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
    if (screenWidth > 600) {
      axiscount = 3;
    } else {
      axiscount = 2;
    }
    return Scaffold(
       appBar: AppBar(
         title: Text(maintitle,style: TextStyle(color: Colors.black,),),
         backgroundColor: Colors.amber[200],
        actions: [
          IconButton(
              onPressed: () {
                
              },
              icon: const Icon(Icons.search)),
       
          PopupMenuButton(
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
              itemBuilder: (context) {
            return [
              const PopupMenuItem<int>(
                value: 0,
                child: Text("My Order"),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text("New"),
              ),
            ];
          }, onSelected: (value) async {
            if (value == 0) {
              if (widget.user.id.toString() == "na") {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please login/register an account")));
                return;
              }}})
              
              ]
            ),
             backgroundColor: Colors.amber[50],
      body: const Center(
              child: Text("No Data"),
            ));
}}