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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Container(
                width: screenWidth,
                alignment: Alignment.center,
                color: Color.fromARGB(255, 239, 219, 157),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    widget.budgetinfo.budgetname.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: int.tryParse(widget.budgetinfo.budgetday.toString()) ?? 0,
                itemBuilder: (context, index) {
                  List<Budgetday> budgetForDay = Budgetdaylist.where((expenditureday) => expenditureday.bdayname == (index + 1).toString()).toList();

                  return Card(
                    margin: EdgeInsets.all(10),
                    elevation: 3,
                    child: ExpansionTile(
                      title: Text(
                        'Day ${index + 1}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      children: [
                        if (budgetForDay.isEmpty)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Center(
                              child: Text('No expenditures'),
                            ),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: budgetForDay.length,
                            itemBuilder: (context, expIndex) {
                              Budgetday expenditure = budgetForDay[expIndex];
                              return ListTile(
                                leading: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: "${MyConfig().SERVER}/myutk/assets/BudgetDay/${expenditure.bdayid}_image.png?v=${DateTime.now().millisecondsSinceEpoch}",
                                  placeholder: (context, url) => CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                                title: Text(
                                  expenditure.expendname.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  'RM ${expenditure.expendamount.toString()}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
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
                                ),
                                onTap: () {
                                  // Handle tap on expenditure item
                                },
                              );
                            },
                          ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 500),
              Container(
                width: screenWidth,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 177, 177, 177),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Budget:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "RM ${widget.budgetinfo.totalbudget.toString()}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String budgetinfo = widget.budgetinfo.budgetid.toString();
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddExpenditureScreen(user: widget.user, budgetinfo: budgetinfo),
            ),
          );
          loadbudgetday(index);

         
        
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.amber,
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