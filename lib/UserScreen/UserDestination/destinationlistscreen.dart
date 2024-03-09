import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myutk/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';
import 'package:myutk/EntryScreen/loginscreen.dart';
import 'package:myutk/UserScreen/UserDestination/destinationdetailscreen.dart';



class destinationlistscreen extends StatefulWidget {
  final User user;
  const destinationlistscreen({super.key, required this.user});

  @override
  State<destinationlistscreen> createState() => _destinationlistscreenState();
}

class _destinationlistscreenState extends State<destinationlistscreen> {
  TextEditingController _searchController = TextEditingController();
  String maintitle = "Destination List";
 
  late double screenHeight, screenWidth;
  late int axiscount = 2;
   int itemsPerPage = 6;
  late int curPage = 1;
  late int totalPages = 6;
  List<String> destinations = ["Gua Kelam", "Penang Komtar", "Alor Setar", "Langkawi", /* add more destinations */];

  var color;

  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
   
    print("Destination List");
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
        title: Image.asset(
                    "assets/images/Logo.png",
                  ),
         backgroundColor: Colors.amber[200],
        actions: [
             IconButton(
              onPressed: () {
                
              },
              icon: const Icon(Icons.notifications_active)),
       
              
              ]
            ),
             backgroundColor: Colors.amber[50],
              body: Center(
                
                child: Column(children: [
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
                              const SizedBox(height: 20),
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
                                        filled: true,
                                        fillColor: Colors.amber,
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),),
                                        
                                        suffixIcon: Icon(Icons.search),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
             // Number of items per page
const SizedBox(height: 20,),

Expanded(
  child: PageView.builder(
    controller: PageController(viewportFraction: 0.9), // Adjust the fraction as needed
    itemCount: (destinations.length / itemsPerPage).ceil(),
    itemBuilder: (context, pageIndex) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 items in a row
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: itemsPerPage,
        itemBuilder: (context, index) {
          int itemIndex = pageIndex * itemsPerPage + index;
          if (itemIndex >= destinations.length) {
            return Container(); // Return an empty container for the last page if it's not fully filled
          }

          String destinationName = destinations[itemIndex];

          // Assuming your images are named "image1.png", "image2.png", etc.
          String imageName = "hd${itemIndex + 1}";

          return Card(
            child: InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (content) => destinationdetailscreen(
                      user: widget.user,
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  Image.asset("assets/images/$imageName.jpg", width: 200, height: 100, fit: BoxFit.cover),
                  Text(
                    destinationName,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  ),
),
Container(
            // Pagination controls
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    // Handle going to the previous page
                    _goToPreviousPage();
                  },
                ),
                Text('Page $curPage of $totalPages'),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    // Handle going to the next page
                    _goToNextPage();
                  },
                ),
              ],
            ),
          ),




        ]
      )
    ),











);
}void _goToNextPage() {
    setState(() {
      if (curPage < totalPages) {
        curPage++;
      }
    });
  }

  void _goToPreviousPage() {
    setState(() {
      if (curPage > 1) {
        curPage--;
      }
    });
  }}
void _performSearch(String keyword) {
    // Implement your search logic here
    print('Searching for: $keyword');
    // Add your logic to handle the search results
  }
  