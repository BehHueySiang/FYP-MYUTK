import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myutk/AdminScreen/AdminItinerary/createitineraryscreen.dart';
import 'package:myutk/AdminScreen/AdminItinerary/itinerarylistdetailscreen.dart';
import 'package:myutk/UserScreen/UserReview/addreviewscreen.dart';
import 'package:myutk/UserScreen/UserReview/editreviewscreen.dart';
import 'package:myutk/AdminScreen/AdminItinerary/edittripitinerary.dart';
import 'package:myutk/models/tripinfo.dart';
import 'package:myutk/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';
import 'package:myutk/EntryScreen/loginscreen.dart';
import 'package:myutk/UserScreen/UserReview/reviewdetailscreen.dart';



class admitinerarytabscreen extends StatefulWidget {
  final User user;
  
  const admitinerarytabscreen({super.key, required this.user,});

  @override
  State<admitinerarytabscreen> createState() => _admitinerarytabscreenState();
}

class _admitinerarytabscreenState extends State<admitinerarytabscreen> {
  Tripinfo tripinfo =Tripinfo();

  late double screenHeight, screenWidth;
  TextEditingController _searchController = TextEditingController();
  late int axiscount = 2;
  late List<Widget> tabchildren;
  String maintitle = "Budget";
    int numofpage = 1, curpage = 1, numberofresult = 0, index = 0;
  List<Tripinfo> Tripinfolist = <Tripinfo>[];
 
  var color;
  
  @override
  void initState() {
    super.initState();
    loadtripinfo();
    print("addreviewlist");
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
        automaticallyImplyLeading: false,
        actions: [ Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.0), // Adjust the right padding as needed
                  child: Container(
                    height: 40.0, // Set the height of the search bar
                    width: screenWidth * 0.35, // Set the width of the search bar
                    child: TextField(
                      controller: _searchController,
                      onChanged: (keyword) {
                        // You can perform search on each keystroke or update a debouncer for better performance
                      },
                      onSubmitted: (keyword) {
                       // _performSearch(keyword);
                      },
                      decoration: InputDecoration(
                        labelText: 'Search',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Color.fromARGB(255, 252, 252, 252),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_active),
          ),
        ],
      ),

      
      backgroundColor: Colors.amber[50],
      body: Column(children: [
        const SizedBox(height: 20,),
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
                        'Itinerary',
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
             
              const SizedBox(height: 10,),
           Expanded(
            
            child: Tripinfolist.isEmpty
              ? Center(
                  child: Text("No Data"),
                )
: GridView.builder(

    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: axiscount, 
      childAspectRatio: (6/ 2), // Adjust this value according to your images aspect ratio
      // You may need to adjust childAspectRatio according to your item's aspect ratio
    ),
    itemCount: Tripinfolist.length,
    itemBuilder: (context, index) {
      return Padding( // Padding highlighted
      padding: const EdgeInsets.all(8.0),
     
        
        child:SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Card(
          child: InkWell(
                      onTap: () async {
                        Tripinfo tripinfo = Tripinfo.fromJson(Tripinfolist[index].toJson());
                        await Navigator.push(context, MaterialPageRoute(builder: (content) => ItinerarylListDetailScreen(user: widget.user, tripinfo: tripinfo  ),));
                     
                      },
          child: Container(
            width: 550, // Set the width of the Card
    height: 600, //
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.8), // Adjust the opacity level here (0.0 - 1.0)
                      BlendMode.srcOver,
                    ),
                    child:  CachedNetworkImage(
                              width: 400, // Adjust image width as needed
                              height: 200,
                              fit: BoxFit.cover,
                              imageUrl: "${MyConfig().SERVER}/myutk/assets/Itinerary/${Tripinfolist[index].tripid}_image.png?v=${DateTime.now().millisecondsSinceEpoch}",////////
                            
                            ),
                            
                  ),
                  Positioned(
                    child: Text(
                      Tripinfolist[index].tripname.toString(),
                      style: const TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),Stack(children:[Row(
                mainAxisAlignment: MainAxisAlignment.end,
             
                children:  [
                  IconButton(
                    icon: Icon(Icons.visibility),
                    onPressed: () {
                      // Handle view action
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async{
                       if (widget.user.id != "na") {
           
              Tripinfo tripinfo =Tripinfo.fromJson(Tripinfolist[index].toJson());
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                
                                  builder: (content) => EditTripItineraryScreen(user: widget.user, tripinfo: tripinfo),
                                      ));
                          loadtripinfo();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Please login/register an account")));
            }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                       onDeleteDialog(index);
                       loadtripinfo();
                    },
                  ),
                ],
              ),]),
              // Add spacing between image and icons
              
            ],
          ),
        ),)
         ) ),
   ); },
  ),
),
            ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
    
            if (widget.user.id != "na") {
           
              
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    
                      builder: (content) => CreateItineraryScreen(user: widget.user, ),
                          ));
              loadtripinfo();

              
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Please login/register an account")));
            }
          },
          child: const Text(
            "+",
            style: TextStyle(fontSize: 32),
          ),backgroundColor: Colors.amber,),
          
          ); 
  }

  void loadtripinfo() {
    if (widget.user.id == "na") {
      setState(() {
        // titlecenter = "Unregistered User";
      });
      return;
    }

    http.post(Uri.parse("${MyConfig().SERVER}/myutk/php/loadtripinfo.php"),
        body: {
         
          }).then((response) {
      print(response.body);
      //log(response.body);
      Tripinfolist.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          
       
          var extractdata = jsondata['data'];
          extractdata['Tripinfo'].forEach((v) {
            Tripinfolist.add(Tripinfo.fromJson(v));
             
          Tripinfolist.forEach((element) {
           
          });

          });
          print(Tripinfolist[0].tripname);
        }
        setState(() {});
      }
    });
  }
  void onDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            "Delete this destination from this trip?",
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                deletetripitinerary(index);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void deletetripitinerary(int index) {
    http.post(Uri.parse("${MyConfig().SERVER}/myutk/php/deletetripitinerary.php"),
        body: {
          "userid": widget.user.id,
          "Trip_id": Tripinfolist[index].tripid,
        }).then((response) {
      print(response.body);
      //Deslist.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Delete Success")));
          loadtripinfo();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Failed")));
        }
      }
    });
  } 
  
   
}