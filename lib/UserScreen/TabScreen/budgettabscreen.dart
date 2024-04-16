import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:myutk/models/useritinerary.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myutk/UserScreen/UserBudget/createbudgetscreen.dart';
import 'package:myutk/AdminScreen/AdminItinerary/edittripitinerary.dart';
import 'package:myutk/models/tripinfo.dart';
import 'package:myutk/models/budget.dart';
import 'package:myutk/models/user.dart';
import 'package:myutk/models/useritinerary.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';
import 'package:myutk/EntryScreen/loginscreen.dart';
import 'package:myutk/UserScreen/UserReview/reviewdetailscreen.dart';
import 'package:myutk/UserScreen/UserBudget/budgetlistdetailscreen.dart';
import 'package:myutk/UserScreen/UserBudget/editbudgetscreen.dart';



class BudgetTabScreen extends StatefulWidget {
  final User user;
  
  const BudgetTabScreen({super.key, required this.user,});

  @override
  State<BudgetTabScreen> createState() => _BudgetTabScreenState();
}

class _BudgetTabScreenState extends State<BudgetTabScreen> {
  Tripinfo tripinfo =Tripinfo();
  Budgetinfo budget = Budgetinfo();
  late double screenHeight, screenWidth;
  TextEditingController _searchController = TextEditingController();
  late int axiscount = 2;
  late List<Widget> tabchildren;
  String maintitle = "Budget";
  int numofpage = 1, curpage = 1, numberofresult = 0, index = 0;
  List<Tripinfo> Tripinfolist = <Tripinfo>[];
  List<Budgetinfo> Budgetinfolist = <Budgetinfo>[];
  List<Usertrip> usertripList =<Usertrip> [];
 
  var color;
  
  @override
  void initState() {
    super.initState();
    loadbudgetinfo();
    loadusertrip();
    print("Budgettabscreen");
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
                        "Let's travel with own budget planning",
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
            
            child: Budgetinfolist.isEmpty
              ? Center(
                  child: Text("No Data"),
                )
: GridView.builder(

    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: axiscount, 
      childAspectRatio: (6/ 2), // Adjust this value according to your images aspect ratio
      // You may need to adjust childAspectRatio according to your item's aspect ratio
    ),
    itemCount: Budgetinfolist.length,
    itemBuilder: (context, index) {
      return Padding( // Padding highlighted
      padding: const EdgeInsets.all(8.0),
     
        
        child:SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Card(
          child: InkWell(
                     onTap: () async {
                        Budgetinfo budgetinfo = Budgetinfo.fromJson(Budgetinfolist[index].toJson());
                        int budgetid = int.parse(Budgetinfolist[index].budgetid.toString());
                        await Navigator.push(context, MaterialPageRoute(builder: (content) => 
                        BudgetListDetailScreen(user: widget.user, budgetinfo: budgetinfo , Budgetid: budgetid, ),));
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
                              imageUrl: "${MyConfig().SERVER}/myutk/assets/Budget/${Budgetinfolist[index].budgetid.toString()}_image.png?v=${DateTime.now().millisecondsSinceEpoch}",////////
                            
                            ),
                            
                  ),
                  Positioned(
                    child: Text(
                      Budgetinfolist[index].budgetname.toString(),
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
                    
              
              Budgetinfo budgetinfo =Budgetinfo.fromJson(Budgetinfolist[index].toJson());
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                
                                  builder: (content) => EditBudgetScreen(user: widget.user, budgetinfo: budgetinfo),
                                      ));
                                      loadbudgetinfo();           
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      onDeleteDialog(index);
                       loadbudgetinfo();
                                        },
                                      ),
                                    ],
                                  ),
                                ]
                              ),
              
                            ],
                           ),
                          ),
                         )
                        ) 
                      ),
                     ); 
                    },
                   ),
                  ),
                 ]
                ),
                floatingActionButton: FloatingActionButton(
                    onPressed: () async {
                      if (widget.user.id != "na") {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (content) => CreateBudgetScreen(user: widget.user, ),
                                    ));
                        loadbudgetinfo();
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

  void loadbudgetinfo() {
    if (widget.user.id == "na") {
      setState(() {
        // titlecenter = "Unregistered User";
      });
      return;
    }

    http.post(Uri.parse("${MyConfig().SERVER}/myutk/php/loadbudgetinfo.php"),
        body: {
         
          }).then((response) {
      print(response.body);
      //log(response.body);
      Budgetinfolist.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          
       
          var extractdata = jsondata['data'];
          extractdata['Budgetinfo'].forEach((v) {
            Budgetinfolist.add(Budgetinfo.fromJson(v));
             
          Budgetinfolist.forEach((element) {
           
          });

          });
          print(Budgetinfolist[0].budgetname);
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
            "Delete this budget plan?",
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                deletebudgetplan(index);
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

  void deletebudgetplan(int index) {
    http.post(Uri.parse("${MyConfig().SERVER}/myutk/php/delete_budget.php"),
        body: {
          "userid": widget.user.id,
          "Budget_id": Budgetinfolist[index].budgetid,
        }).then((response) {
      print(response.body);
      //Deslist.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Delete Success")));
         loadbudgetinfo();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Failed")));
        }
      }
    });
  } 
  void loadusertrip() {
    

    http.post(Uri.parse("${MyConfig().SERVER}/myutk/php/loaduseritinerary.php"),
        body: {
          
        }).then((response) {
      print(response.body);
      usertripList.clear();
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['status'] == "success") {
          var extractData = jsonData['data']['Usertrip'];
          extractData.forEach((v) {
            usertripList.add(Usertrip.fromJson(v));
          });
          setState(() {
            // Trigger rebuild to update MinimumTotalBudgetWidget
          });
        }
      }
    });
  }


   
}