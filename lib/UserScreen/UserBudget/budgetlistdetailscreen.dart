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
   final int Budgetid;
   
  const BudgetListDetailScreen({super.key, required this.user,
  required this.budgetinfo,required this.Budgetid });

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
  late Map<String, double> dayTotalExpenditure = {};
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
   void reloadPage() {
    loadbudgetinfo(); // Reload budget information
    loadbudgetday(index); // Reload budget days
    setState(() {}); // Trigger a rebuild of the widget
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
      body: Column(
      children: [
        Expanded(
          child:SingleChildScrollView(
        
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
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: int.tryParse(widget.budgetinfo.budgetday.toString()) ?? 0,
                itemBuilder: (context, index) {
                  String dayName = (index + 1).toString();
                  List<Budgetday> budgetForDay = Budgetdaylist.where((expenditureday) => expenditureday.bdayname == dayName).toList();
                   double totalExpenditure = dayTotalExpenditure[dayName] ?? 0;

                  return Card(
                    margin: EdgeInsets.all(10),
                    elevation: 3,
                    child: ExpansionTile(
                      title: Text(
                        'Day ${index + 1} - Total RM $totalExpenditure',
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
                                  imageUrl: "${MyConfig().SERVER}/MyUTK/assets/BudgetDay/${expenditure.bdayid}_image.png?v=${DateTime.now().millisecondsSinceEpoch}",
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
                                         int Dayid = int.parse(expenditure.bdayid.toString());
                                              int Desbudget = int.parse(expenditure.expendamount.toString());
                                              print(Dayid);
                                              onDeleteDialog(Dayid,Desbudget);
                                              reloadPage();
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
              SizedBox(height: 200),
             
            ],
          ),
        ),
      ),
       ),
      SizedBox(
              height: 48,
              width: 400,
              child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: axiscount, 
                childAspectRatio: (9/1), // Adjust this value according to your images aspect ratio
                // You may need to adjust childAspectRatio according to your item's aspect ratio
              ),
              itemCount: Budgetinfolist.length,
              itemBuilder: (context, index) {
              return Container(
                width: 300,
                alignment: Alignment.bottomLeft, // Align to bottom-left
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 177, 177, 177),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align row items to the start (left)
                  children: [
                     Text(
                        "Total budget:",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                    Text(
                      "RM ${widget.budgetinfo.totalbudget.toString()}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );})),

            SizedBox(
              height: 48,
              width: 400,
              child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: axiscount, 
                childAspectRatio: (9/1), // Adjust this value according to your images aspect ratio
                // You may need to adjust childAspectRatio according to your item's aspect ratio
              ),
              itemCount: Budgetinfolist.length,
              itemBuilder: (context, index) {
               return Container(
                width: 300,
                alignment: Alignment.bottomLeft, // Align to bottom-left
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 177, 177, 177),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align row items to the start (left)
                  children: [
                     Text(
                        "Total expenditure:",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                    Text(
                      "RM ${Budgetinfolist[index].totalexpenditure.toString()}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ); })),
            

            const SizedBox(height: 20,),
            SizedBox(
              height: 68,
              width: 250,
              
              child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: axiscount, 
                childAspectRatio: (5/1), // Adjust this value according to your images aspect ratio
                // You may need to adjust childAspectRatio according to your item's aspect ratio
              ),
              itemCount: Budgetinfolist.length,
              itemBuilder: (context, index) {
              return    Container(
                   
                // Align to bottom-left
             decoration: BoxDecoration(
                        color: (int.parse(Budgetinfolist[index].totalexpenditure.toString()) > int.parse(Budgetinfolist[index].totalbudget.toString()))
                          ? Color.fromARGB(255, 246, 3, 3) // Use this color if expenditure is greater than budget
                          : Color.fromARGB(255, 152, 253, 142), // Use transparent color if expenditure is not greater than budget
                        borderRadius: BorderRadius.circular(10),
                      ),

                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Align row items to the start (left)
                  children: [
                     Text(
                        "RM ",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                         calculateTotalDifference(widget.budgetinfo.budgetid.toString()).toStringAsFixed(2),

                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    
                  ],
                ),
              );})),
              
            
              ] 
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

          reloadPage();

         
        
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

    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/loadbudgetinfo.php"),
        body: {
          "userid": widget.user.id.toString(),
           "Budget_id": widget.budgetinfo.budgetid.toString(),

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
      // Handle unregistered user state
    });
    return;
  }

  http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/loadbudgetday.php"), body: {
    "userid": widget.user.id.toString(),
    "Budget_id": widget.budgetinfo.budgetid.toString(),
  }).then((response) {
    print(response.body);
    Budgetdaylist.clear();
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 'success') {
        var extractData = jsonData['data']['Budgetday'] as List<dynamic>;
        Budgetdaylist = extractData.map((v) => Budgetday.fromJson(v)).toList();

        // Clear existing day totals before recalculating
        dayTotalExpenditure.clear();

        // Calculate total expenditure for each day
        for (var budgetDay in Budgetdaylist) {
          String dayName = budgetDay.bdayname.toString();
          double expenditureAmount = double.parse(budgetDay.expendamount.toString());
          
          if (!dayTotalExpenditure.containsKey(dayName)) {
            dayTotalExpenditure[dayName] = 0;
          }
          
dayTotalExpenditure[dayName] = (dayTotalExpenditure[dayName] ?? 0.0) + expenditureAmount;
        }

        // Trigger a rebuild of the widget
        setState(() {});
      }
    }
  }).catchError((error) {
    print('Error loading budget day: $error');
  });
}
  

void onDeleteDialog(int Dayid, int ExpendAmount) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        title: Text("Delete this expenditure from this budget plan?"),
        content: Text("Are you sure?"),
        actions: <Widget>[
          TextButton(
            child: Text("Yes"),
            onPressed: () {
              
              deleteExpenditure(Dayid);
              updatebudgetinfo(  Dayid, ExpendAmount);
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

void deleteExpenditure(int DayId) {
  http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/deleteExpendFromDay.php"),
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
}
void updatebudgetinfo(int Dayid,int ExpendAmount)  {
 
    
     
     http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/updatetotalexpenditure.php"),
        body: {
          "Budgetid" : widget.budgetinfo.budgetid,
          "Total_Expenditure": ExpendAmount.toString(),
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
  }
 
 double calculateTotalDifference(String budgetId) {
  double totalBudget = 0;
  double totalExpenditure = 0;

  // Find the budget info matching the provided budgetId
  Budgetinfo budgetInfo = Budgetinfolist.firstWhere(
    (info) => info.budgetid == budgetId,
    orElse: () => Budgetinfo(totalbudget: "0", totalexpenditure: "0"), // Default values if not found
  );

  // Parse total budget and total expenditure from the found budget info
  totalBudget = double.parse(budgetInfo.totalbudget.toString());
  totalExpenditure = double.parse(budgetInfo.totalexpenditure.toString());

  // Compute the total difference
  return totalBudget - totalExpenditure;
}


  

}