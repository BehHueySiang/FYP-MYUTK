import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myutk/UserScreen/UserBudget/addexpenditurescreen.dart';
import 'package:myutk/UserScreen/UserBudget/editbudgetdayscreen.dart';
import 'package:myutk/models/budget.dart';
import 'package:myutk/models/budgetday.dart';
import 'package:myutk/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';



class BudgetListDetailScreen extends StatefulWidget {
  final User user;
  final Budgetinfo budgetinfo;
  final int Budgetid;

  const BudgetListDetailScreen({
    super.key,
    required this.user,
    required this.budgetinfo,
    required this.Budgetid,
  });

  @override
  State<BudgetListDetailScreen> createState() => _BudgetListDetailScreenState();
}

class _BudgetListDetailScreenState extends State<BudgetListDetailScreen> {
  late Budgetinfo budgetinfo;
  late List<Budgetday> Budgetdaylist;
  List<Budgetinfo> Budgetinfolist = <Budgetinfo>[];
  late Map<String, double> dayTotalExpenditure;
  late int totalExpenditure;
  late double screenHeight, screenWidth;
  int axiscount = 2;

  @override
  void initState() {
    super.initState();
    budgetinfo = widget.budgetinfo;
    Budgetdaylist = [];
    dayTotalExpenditure = {};
    totalExpenditure = 0;
    loadBudgetData();
  }

  void loadBudgetData() {
    loadbudgetinfo().then((_) {
      loadbudgetday().then((_) {
        calculateTotalExpenditure();
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    axiscount = screenWidth > 600 ? 3 : 1;

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
      body: RefreshIndicator(
        onRefresh: () async {
          loadBudgetData();
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
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
                            budgetinfo.budgetname.toString(),
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
                        itemCount: int.tryParse(budgetinfo.budgetday.toString()) ?? 0,
                        itemBuilder: (context, index) {
                          String dayName = (index + 1).toString();
                          List<Budgetday> budgetForDay = Budgetdaylist.where(
                            (expenditureday) => expenditureday.bdayname == dayName,
                          ).toList();
                          double totalExpenditureForDay = dayTotalExpenditure[dayName] ?? 0;

                          return Card(
                            margin: EdgeInsets.all(10),
                            elevation: 3,
                            child: ExpansionTile(
                              title: Text(
                                'Day ${index + 1} - Total RM $totalExpenditureForDay',
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
                                              onPressed: () async {
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                      EditBudgetDayScreen(
                                                        user: widget.user,
                                                        budgetinfo: budgetinfo,
                                                        budgetday: expenditure,
                                                      ),
                                                  ),
                                                );
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.delete),
                                              onPressed: () {
                                                int? Dayid = int.tryParse(
                                                    expenditure.bdayid
                                                        .toString());
                                                int? Desbudget = int.tryParse(
                                                    expenditure.expendamount
                                                        .toString());
                                                if (Dayid != null &&
                                                    Desbudget != null) {
                                                  onDeleteDialog(
                                                      Dayid, Desbudget);
                                                } else {
                                                  // Handle the error or show a message to the user
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Text(
                                                            "Invalid expenditure data")),
                                                  );
                                                }
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
              child: Container(
                width: 300,
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 177, 177, 177),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total budget:",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "RM ${budgetinfo.totalbudget.toString()}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              height: 48,
              width: 400,
              child: Container(
                width: 300,
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 177, 177, 177),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total expenditure:",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "RM $totalExpenditure",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 250,
              child: Container(
                decoration: BoxDecoration(
                  color: calculateTotalDifference() < 0
                      ? Color.fromARGB(255, 246, 3,
                          3) // Red color if expenditure exceeds budget
                      : Color.fromARGB(
                          255, 152, 253, 142), // Green color if within budget
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "RM ",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      calculateTotalDifference().toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String budgetinfo = widget.budgetinfo.budgetid.toString();
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddExpenditureScreen(
                  user: widget.user, budgetinfo: budgetinfo),
            ),
          );
          loadBudgetData();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
    );
  }

  Future<void> loadbudgetinfo() async {
    if (widget.user.id == "na") {
      setState(() {
        // titlecenter = "Unregistered User";
      });
      return;
    }

    final response = await http.post(
      Uri.parse("${MyConfig().SERVER}/MyUTK/php/loadbudgetinfo.php"),
      body: {
        "userid": widget.user.id.toString(),
        "Budget_id": widget.budgetinfo.budgetid.toString(),
      },
    );

    print(response.body);
    Budgetinfolist.clear();
    if (response.statusCode == 200) {
      var jsondata = jsonDecode(response.body);
      if (jsondata['status'] == "success") {
        var extractdata = jsondata['data'];
        extractdata['Budgetinfo'].forEach((v) {
          Budgetinfolist.add(Budgetinfo.fromJson(v));
        });
        setState(() {});
      }
    }
  }

  Future<void> loadbudgetday() async {
    if (widget.user.id == "na") {
      setState(() {
        // Handle unregistered user state
      });
      return;
    }

    final response = await http.post(
      Uri.parse("${MyConfig().SERVER}/MyUTK/php/loadbudgetday.php"),
      body: {
        "userid": widget.user.id.toString(),
        "Budget_id": widget.budgetinfo.budgetid.toString(),
      },
    );

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
          double expenditureAmount =
              double.tryParse(budgetDay.expendamount.toString()) ?? 0;

          if (!dayTotalExpenditure.containsKey(dayName)) {
            dayTotalExpenditure[dayName] = 0;
          }

          dayTotalExpenditure[dayName] =
              (dayTotalExpenditure[dayName] ?? 0.0) + expenditureAmount;
        }

        setState(() {});
      }
    } else {
      print('Error loading budget day: ${response.body}');
    }
  }

  void calculateTotalExpenditure() {
    totalExpenditure = Budgetdaylist.fold(0, (sum, item) {
      return sum + (int.tryParse(item.expendamount.toString()) ?? 0);
    });
    setState(() {}); // Ensure the UI updates with the new totalExpenditure
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
                updatebudgetinfo(Dayid, ExpendAmount);
              },
            ),
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void deleteExpenditure(int DayId) {
    http.post(
        Uri.parse("${MyConfig().SERVER}/MyUTK/php/deleteExpendFromDay.php"),
        body: {
          "userid": widget.user.id,
          "DayId": DayId.toString(),
          "action": 'delete',
        }).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Delete Success")));
          loadBudgetData();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Failed")));
        }
      }
    });
  }

  void updatebudgetinfo(int Dayid, int ExpendAmount) {
    http.post(
        Uri.parse("${MyConfig().SERVER}/MyUTK/php/updatetotalexpenditure.php"),
        body: {
          "Budgetid": widget.budgetinfo.budgetid,
          "Total_Expenditure": ExpendAmount.toString(),
          "action": 'delete',
        }).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Insert Successfully")));
          loadBudgetData();
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

  double calculateTotalDifference() {
    double totalBudget =
        double.tryParse(budgetinfo.totalbudget.toString()) ?? 0;
    return totalBudget - totalExpenditure;
  }
}
