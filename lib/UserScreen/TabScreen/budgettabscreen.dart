import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myutk/UserScreen/UserBudget/createbudgetscreen.dart';
import 'package:myutk/UserScreen/UserReview/addreviewscreen.dart';
import 'package:myutk/UserScreen/UserReview/editreviewscreen.dart';
import 'package:myutk/models/review.dart';
import 'package:myutk/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';
import 'package:myutk/EntryScreen/loginscreen.dart';
import 'package:myutk/UserScreen/UserReview/reviewdetailscreen.dart';



class BudgetTabScreen extends StatefulWidget {
  final User user;
  
  const BudgetTabScreen({super.key, required this.user,});

  @override
  State<BudgetTabScreen> createState() => _BudgetTabScreenState();
}

class _BudgetTabScreenState extends State<BudgetTabScreen> {
  Review review = Review ();
  int index = 0;
  late double screenHeight, screenWidth;
  TextEditingController _searchController = TextEditingController();
  late int axiscount = 2;
  late List<Widget> tabchildren;
  String maintitle = "Budget";
    int numofpage = 1, curpage = 1, numberofresult = 0;
  List<Review> Reviewlist = <Review>[];
 
  var color;
  
  @override
  void initState() {
    super.initState();
    loadreview(1);
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
                        _performSearch(keyword);
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
                        'Budget',
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
            
            child: Reviewlist.isEmpty
              ? Center(
                  child: Text("No Data"),
                )
: GridView.builder(

    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: axiscount, 
      childAspectRatio: (6/ 2), // Adjust this value according to your images aspect ratio
      // You may need to adjust childAspectRatio according to your item's aspect ratio
    ),
    itemCount: Reviewlist.length,
    itemBuilder: (context, index) {
      return Padding( // Padding highlighted
      padding: const EdgeInsets.all(8.0),
     
        
        child:SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Card(
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
                              imageUrl: "${MyConfig().SERVER}/myutk/assets/Review/${Reviewlist[index].reviewid}_image.png?v=${DateTime.now().millisecondsSinceEpoch}",////////
                            
                            ),
                            
                  ),
                  Positioned(
                    child: Text(
                      Reviewlist[index].reviewname.toString(),
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
                    onPressed: () {
                      // Handle edit action
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Handle delete action
                    },
                  ),
                ],
              ),]),
              // Add spacing between image and icons
              
            ],
          ),
        ),)
      ),
   ); },
  ),
),SizedBox(
                height: 50,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: numofpage,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    //build the list for textbutton with scroll
                    if ((curpage - 1) == index) {
                      //set current page number active
                      color = Colors.amber[800];
                    } else {
                      color = Colors.black;
                    }
                    return TextButton(
                        onPressed: () {
                          curpage = index + 1;
                          loadreview(index + 1);
                        },
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(color: color, fontSize: 18),
                        ));
                  },
                ),
              ),
            ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
    
            if (widget.user.id != "na") {
           
              
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    
                      builder: (content) => CreateBudgetScreen(user: widget.user, ),
                          ));
              loadreview(1);
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

  void loadreview(int pageno) {
    if (widget.user.id == "na") {
      setState(() {
        // titlecenter = "Unregistered User";
      });
      return;
    }

    http.post(Uri.parse("${MyConfig().SERVER}/myutk/php/load_review.php"),
        body: {
          
          "pageno": pageno.toString()
          }).then((response) {
      print(response.body);
      //log(response.body);
      Reviewlist.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          numofpage = int.parse(jsondata['numofpage']); //get number of pages
          numberofresult = int.parse(jsondata['numberofresult']);
          print(numberofresult);
          var extractdata = jsondata['data'];
          extractdata['Review'].forEach((v) {
            Reviewlist.add(Review.fromJson(v));
             
          Reviewlist.forEach((element) {
           
          });

          });
          print(Reviewlist[0].reviewname);
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
            "Delete ${Reviewlist[index].reviewname}?",
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                deleteReview(index);
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

  void deleteReview(int index) {
    http.post(Uri.parse("${MyConfig().SERVER}/myutk/php/delete_review.php"),
        body: {
          "userid": widget.user.id,
          "ReviewId": Reviewlist[index].reviewid
        }).then((response) {
      print(response.body);
      //Deslist.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Delete Success")));
          loadreview(index);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Failed")));
        }
      }
    });
  }
 void _performSearch(String keyword) {
  
    http.post(Uri.parse("${MyConfig().SERVER}/myutk/php/load_review.php"),
        body: {
          "userid":  widget.user.id,
          "search": keyword
        }).then((response) {
      //print(response.body);
      log(response.body);
      Reviewlist.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['Review'].forEach((v) {
            Reviewlist.add(Review.fromJson(v));
          });
          print(Reviewlist[0].reviewname);
        }
        setState(() {});
      }
    });
  
  }
   
}