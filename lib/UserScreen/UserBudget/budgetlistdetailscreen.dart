import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myutk/AdminScreen/AdminItinerary/additinerarydestination.dart';
import 'package:myutk/UserScreen/UserBudget/addexpenditurescreen.dart';
import 'package:myutk/models/budget.dart';
import 'package:myutk/models/budgetday.dart';
import 'package:myutk/models/review.dart';
import 'package:myutk/models/tripday.dart';
import 'package:myutk/models/destination.dart';
import 'package:myutk/models/tripinfo.dart';
import 'package:myutk/models/useritinerary.dart';
import 'package:myutk/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';
import 'package:myutk/EntryScreen/loginscreen.dart';
import 'package:myutk/AdminScreen/AdminDestination/admdestinationdetailscreen.dart';



class BudgetListDetailScreen extends StatefulWidget {
   final User user;
   final Budgetinfo budgetinfo;
  
   
  const BudgetListDetailScreen({super.key, required this.user,
  required this.budgetinfo, });

  @override
  State<BudgetListDetailScreen> createState() => _BudgetListDetailScreenState();
}

class _BudgetListDetailScreenState extends State<BudgetListDetailScreen> {
  
  Budgetday budgetday = Budgetday();
  late double screenHeight, screenWidth;
  late int axiscount = 2;
  late List<Widget> tabchildren;
  String maintitle = "Budget List Detail";
  int numofpage = 1, curpage = 1, numberofresult = 0, index = 0;
  
  List<Budgetinfo> Budgetinfolist = <Budgetinfo>[];
  List<Budgetday> Budgetdaylist = <Budgetday>[];
    final df = DateFormat('dd-MM-yyyy hh:mm a');


  var color;
  
  
  @override
  void initState() {
    super.initState();
    loadbudgetinfo();
    loadbudgetday(index);
    
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
    body: SingleChildScrollView(
      
      child: Center( 
          
        child: Column(
         children: [
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
                  widget.budgetinfo.budgetname.toString(),
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
  Column(
 children: List.generate(
  int.tryParse(widget.budgetinfo.budgetday.toString()) ?? 0,
  (index) {
    // Filter destinations for the current day
    List<Budgetday> budgetForDay = Budgetdaylist.where((expenditureday) =>expenditureday.bdayname == (index + 1).toString()).toList();
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
                    Card(
                         margin: EdgeInsets.all(10),
                                elevation: 3, // Adjust elevation for shadow effect
                                child: Container(
                                  width: screenWidth,
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
            children: [
              Text(
                '     Day  ',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text(
                (index + 1).toString(),
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),)),
          SizedBox(height: 10),
          Container(
            height: budgetForDay.isEmpty ? screenHeight * 0.6 : null,
            child: budgetForDay.isEmpty
                ? Center(
                    child: Text("No expenditure"),
                  )
                : SingleChildScrollView(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: axiscount,
                        childAspectRatio: (6 / 2),
                      ),
                      itemCount: budgetForDay.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                             // Set desired width
                              height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Card(
                              color: Colors.amber[100],
                              child: InkWell(
                                onTap: () async {
                                },
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: "${MyConfig().SERVER}/myutk/assets/BudgetDay/${budgetForDay[index].bdayid}_image.png?v=${DateTime.now().millisecondsSinceEpoch}",
                                        placeholder: (context, url) => const LinearProgressIndicator(),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    budgetForDay[index].expendname.toString(),
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(height: 2), 
                                                  Row(children: [
                                                    Text(
                                                      "RM : ",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),// Add spacing between the two Text widgets
                                                  Text(
                                                    budgetForDay[index].expendamount.toString(),
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),])
                                                ],
                                              ),
                                            ),
                                      
                                          ],
                                        ),
                                      ),
                                    ),
                                      IconButton(
                                            icon: Icon(Icons.delete),
                                             
                                            onPressed: () {
                                              /*int Dayid = int.parse(budgetForDay[index].dayid.toString());
                                              int Desbudget = int.parse(budgetForDay[index].desbudget.toString());
                                              print(Dayid);
                                              onDeleteDialog(Dayid,Desbudget);
                                              loadbudgetday(index);*/
                                            },
                                          ),
                                  ],
                                ),
                              ), 
                            
                            ),
                          ),
                        );
                      },
                        
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
                                        widget.budgetinfo.totalbudget.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
        ],
      ),
    );
  },
  
),

          ),
          
         
           SizedBox(height: 30),
          
          ]
        ),
      ),
    ),
   
floatingActionButton: 
    FloatingActionButton(

      onPressed: () async {
      
                       String budgetinfo = widget.budgetinfo.budgetid.toString();
                      
                       //double totaltripfee = double.parse(Tripinfolist[index].totaltripfee.toString());
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddExpenditureScreen(user: widget.user, budgetinfo: budgetinfo),
                          ),
                        );
                        loadbudgetday(index);
                      

              

      },
      child: Icon(Icons.add),
      backgroundColor: Colors.amber, // Set your preferred background color
    ),
  

   
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
          "userid": widget.user.id.toString(),
         
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
  void loadbudgetday(int index) {
    if (widget.user.id == "na") {
      setState(() {
        // titlecenter = "Unregistered User";
      });
      return;
    }
 

    http.post(Uri.parse("${MyConfig().SERVER}/myutk/php/loadbudgetday.php"),
        body: {
          "userid": widget.user.id.toString(),
          "Budget_id": widget.budgetinfo.budgetid.toString(),
          }).then((response) {
      print(response.body);
      //log(response.body);
      Budgetdaylist.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          
       
          var extractdata = jsondata['data'];
          extractdata['Budgetday'].forEach((v) {
            Budgetdaylist.add(Budgetday.fromJson(v));
             
          Budgetdaylist.forEach((element) {
           
          });

          });
          print(Budgetdaylist[0].expendname);
        }
        setState(() {});
      }
    });
  }

/*void onDeleteDialog(int Dayid, int Desbudget) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        title: Text("Delete this destination from this trip?"),
        content: Text("Are you sure?"),
        actions: <Widget>[
          TextButton(
            child: Text("Yes"),
            onPressed: () {
              
              deleteDes(Dayid);
              updatetripinfo(  Dayid,Desbudget);
             // Close the dialog
            },
          ),
          TextButton(
            child: Text("No"),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog without deleting
            },
          ),
        ],
      );
    },
  );
}

void deleteDes(int DayId) {
  http.post(Uri.parse("${MyConfig().SERVER}/myutk/php/deletedesfromday.php"),
    body: {
      "userid": widget.user.id,
      "DayId": DayId.toString(),
      "action": 'detele',
    }).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Delete Success")));
          loadbudgetday(index);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed")));
        }
      }
    });
}*/
/*void updatetripinfo(int Dayid,int Desbudget)  {
 
    
     
     http.post(Uri.parse("${MyConfig().SERVER}/myutk/php/updatetotaltripfee.php"),
        body: {
          "Tripid" : widget.tripinfo.tripid,
          "Total_Tripfee": Desbudget.toString(),
          "action": 'delete',
          
         }).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Insert Successfully")));
          loadbudgetinfo();
              
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Insert Failed")));
        }
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Insert Failed")));
        Navigator.pop(context);
      }
    });
  }*/


  

}