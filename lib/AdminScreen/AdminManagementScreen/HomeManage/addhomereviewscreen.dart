import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myutk/models/review.dart';
import 'package:myutk/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';
import 'package:myutk/UserScreen/UserReview/reviewdetailscreen.dart';




class AddHomeReviewScreen extends StatefulWidget {
  final User user;
  final Review review;
  const AddHomeReviewScreen({super.key, required this.user,required this.review});

  @override
  State<AddHomeReviewScreen> createState() => _AddHomeReviewScreenState();
}

class _AddHomeReviewScreenState extends State<AddHomeReviewScreen> {
  Review review = Review ();
  late double screenHeight, screenWidth;
  TextEditingController _searchController = TextEditingController();
  late int axiscount = 2;
  late List<Widget> tabchildren;
  String maintitle = "Review List";
  int numofpage = 1, curpage = 1, numberofresult = 0;
  List<Review> Reviewlist = <Review>[];
  var color;
  
  @override
  void initState() {
    super.initState();
    loadreview(1);
    print("Review List");
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
        title: Text(maintitle,style: TextStyle(color: Colors.black,),),
         backgroundColor: Colors.amber[200],
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
                        'Review',
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
                        fillColor: const Color.fromARGB(255, 244, 217, 138),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ),
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
      return Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Adjust border radius as needed
                    color: Colors.white, // You can set any color you like for the background
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child:Card(
                    color: Colors.amber[100],
                    child: InkWell(
                     onTap: () async {
                                
                                Review review =Review.fromJson(Reviewlist[index].toJson());
                                await Navigator.push(context, MaterialPageRoute(builder: (content)=>ReviewDetailScreen(user: widget.user, review: review )));
                                loadreview(1);
                              },
                        onLongPress: () async {
                        _showAddDialog(index);
                     
                      },

   // Optional: Adds a slight shadow to the card
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2, // Adjust the flex to control the size ratio between the image and the text/icons
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: "${MyConfig().SERVER}/myutk/assets/Review/${Reviewlist[index].reviewid}_image.png?v=${DateTime.now().millisecondsSinceEpoch}",
                                        placeholder: (context, url) => const LinearProgressIndicator(),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                      ),
                                    ),
                                    Expanded(
                                flex: 2, // Adjust the flex to control the size ratio between the image and the text/icons
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0), // Add padding around the text and icons
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded( // Wrap the text in an Expanded widget to allow for centering.
                                        child: FittedBox( // Ensures that the text fits within the available space.
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            Reviewlist[index].reviewname.toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                            textAlign: TextAlign.center, // Center text horizontally.
                                          ),
                                        ),
                                      ), 
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      )
                    )
                  );
                },
              ),
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
                          loadreview(index + 1);
                        },
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(color: color, fontSize: 18),
                        )
                      );
                    },
                  ),
                ),
              ]
            ),
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
  void _showAddDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add to Review"),
          content: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text("Do you want to add ${Reviewlist[index].reviewname} to homescreen?"),
              const SizedBox(height: 15,),
             ])),
          actions: <Widget>[
            
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                addToHomeReview(index);
                Navigator.of(context).pop();
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

  void addToHomeReview(int index) {
    http.post(Uri.parse("${MyConfig().SERVER}/myutk/php/addtohomereview.php"),
        body: {
          "Review_id": Reviewlist[index].reviewid,
          "userid": widget.user.id,
          
        }).then((response) {
         
      print(response.body);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Success")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Failed")));
        }
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Failed")));
        Navigator.pop(context);
      }
    });
  }
}