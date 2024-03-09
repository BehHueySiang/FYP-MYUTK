import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myutk/AdminScreen/AdminDestination/adddestinationscreen.dart';
import 'package:myutk/models/destination.dart';
import 'package:myutk/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';
import 'package:myutk/EntryScreen/loginscreen.dart';
import 'package:myutk/UserScreen/UserDestination/destinationdetailscreen.dart';
import 'package:myutk/AdminScreen/AdminDestination/admdestinationdetailscreen.dart';


class admdestinationlistscreen extends StatefulWidget {
  final User user;
  final Des destinationinfo;
  const admdestinationlistscreen({super.key, required this.user,required this.destinationinfo});

  @override
  State<admdestinationlistscreen> createState() => _admdestinationlistscreenState();
}

class _admdestinationlistscreenState extends State<admdestinationlistscreen> {
  late double screenHeight, screenWidth;
  TextEditingController _searchController = TextEditingController();
  late int axiscount = 2;
  late List<Widget> tabchildren;
  String maintitle = "Adm Destination List";
    int numofpage = 1, curpage = 1;
  List<Des> DesList = <Des>[];
  int index = 0;
  var color;
  Des destinationinfo = Des();
  @override
  void initState() {
    super.initState();
    loadDes(index);
    print("Owner");
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
      ),

      
      backgroundColor: Colors.amber[50],
      body: Column(children: [
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
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.0), // Adjust the right padding as needed
                  child: Container(
                    height: 40.0, // Set the height of the search bar
                    width: screenWidth * 0.5, // Set the width of the search bar
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
                        fillColor: Colors.amber,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ),
              
           Expanded(child: DesList.isEmpty
              ? Center(
                  child: Text("No Data"),
                )
: GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: axiscount,
      // You may need to adjust childAspectRatio according to your item's aspect ratio
    ),
    itemCount: DesList.length,
    itemBuilder: (context, index) {
      return Card(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: "${MyConfig().SERVER}/myutk/assets/Des/${DesList[index].DesId}_image0.png?v=${DateTime.now().millisecondsSinceEpoch}",
                placeholder: (context, url) => const LinearProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
           
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Your edit action
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Your delete action
                  },
                ),
              ],
            ),
            SizedBox(
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
                          loadDes(index + 1);
                        },
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(color: color, fontSize: 18),
                        ));
                  },
                ),
              ),
          ],
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
                      builder: (content) => adddestinationscreen(user: widget.user, destinationinfo: destinationinfo)
                          ));
              loadDes(index);
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

  void loadDes(int pg) {
    if (widget.user.id == "na") {
      setState(() {
        // titlecenter = "Unregistered User";
      });
      return;
    }

    http.post(Uri.parse("${MyConfig().SERVER}/mybarter/php/load_Des.php"),
        body: {"userid": widget.user.id}).then((response) {
      //print(response.body);
      //log(response.body);
      DesList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['Dess'].forEach((v) {
            DesList.add(Des.fromJson(v));
             
          DesList.forEach((element) {
           
          });

          });
          print(DesList[0].DesName);
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
            "Delete ${DesList[index].DesName}?",
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                deleteDes(index);
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

  void deleteDes(int index) {
    http.post(Uri.parse("${MyConfig().SERVER}/mybarter/php/delete_Des.php"),
        body: {
          "userid": widget.user.id,
          "Desid": DesList[index].DesId
        }).then((response) {
      print(response.body);
      //DesList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Delete Success")));
          loadDes(index);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Failed")));
        }
      }
    });
  }
 
   
}
void _performSearch(String keyword) {
    // Implement your search logic here
    print('Searching for: $keyword');
    // Add your logic to handle the search results
  }