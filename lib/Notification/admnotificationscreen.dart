import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myutk/models/notification.dart';
import 'package:myutk/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';
import 'package:myutk/Notification/sendnotificationscreen.dart';



class AdmNotificationScreen extends StatefulWidget {
  final User user;
  
  const AdmNotificationScreen({super.key, required this.user,});

  @override
  State<AdmNotificationScreen> createState() => _AdmNotificationScreenState();
}

class _AdmNotificationScreenState extends State<AdmNotificationScreen> {
  Notify notification =  Notify();
  late double screenHeight, screenWidth;
  TextEditingController _searchController = TextEditingController();
  late int axiscount = 2;
  late List<Widget> tabchildren;
  String maintitle = "Notification"; 
  List<Notify> Notifylist = <Notify>[];
 
  var color;
  
  @override
  void initState() {
    super.initState();
    loadnotification();
    print("Notification Screen");
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
                        //_performSearch(keyword);
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
                        'Notification',
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
             Expanded(
  child: Notifylist.isEmpty
      ? Center(
          child: Text("No Data"),
        )
      : ListView.builder(
          itemCount: Notifylist.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2), // Outline color and width
                  borderRadius: BorderRadius.circular(10), // Add border radius for rounded corners if desired
                  color: Colors.amber[100],
                ),
                child: ListTile(
                  onTap: () async {
                    // Handle tap
                  },
                  
                  title: Text(
                    Notifylist[index].title.toString(),
                    
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    
                  ),
                  
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      onDeleteDialog(index); 
                    },
                  ),
                ),
              ),
            );
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
                      builder: (content) => SendNotificationScreen(user: widget.user)
                          ));
              loadnotification();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Please login/register an account")));
            }
          },
          child: const Icon(Icons.message),backgroundColor: Colors.amber,),
          
          ); 
  }

  void loadnotification() {
    if (widget.user.id == "na") {
      setState(() {
        // titlecenter = "Unregistered User";
      });
      return;
    }

    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/load_notification.php"),
        body: {
         "userid": widget.user.id.toString(),
          
          }).then((response) {
            log(response.body);
      print(response.body);
      //log(response.body);
      Notifylist.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['Notify'].forEach((v) {
            Notifylist.add(Notify.fromJson(v));
             
          Notifylist.forEach((element) {
           
          });

          });
          print(Notifylist[0].title);
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
            "Delete ${Notifylist[index].title}?",
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
    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/delete_notification.php"),
        body: {
         
          "NotificationId": Notifylist[index].notificationid
        }).then((response) {
      print(response.body);
      //Deslist.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Delete Success")));
          loadnotification();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Failed")));
        }
      }
    });
  }
 /*void _performSearch(String keyword) {
  
    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/load_review.php"),
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
  
  }*/
   
}