import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myutk/AdminScreen/AdminDestination/admdestinationlistscreen.dart';
import 'package:myutk/AdminScreen/AdminHotel/admhotellistscreen.dart';
import 'package:myutk/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';
import 'package:myutk/UserScreen/UserDestination/destinationlistscreen.dart';
import 'package:myutk/UserScreen/UserDestination/destinationdetailscreen.dart';
import 'package:myutk/EntryScreen/loginscreen.dart';
import 'package:carousel_slider/carousel_slider.dart';



class hometabscreen extends StatefulWidget {
  final User user;
  const hometabscreen({super.key, required this.user});

  @override
  State<hometabscreen> createState() => _hometabscreenState();
}

class _hometabscreenState extends State<hometabscreen> {
  String maintitle = "Home";
 
  late double screenHeight, screenWidth;
  late int axiscount = 2;
  int numofpage = 1, curpage = 1;
  int numberofresult = 0;
  var color;
  

  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
   
    print("Home");
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
         title:  Image.asset(
                    "assets/images/Logo.png",
                  ),
         backgroundColor: Colors.amber[200],
        actions: [
          IconButton(
              onPressed: () {
                
              },
              icon: const Icon(Icons.search)),
              IconButton(
              onPressed: () {
                
              },
              icon: const Icon(Icons.notifications_active)),
              
       
          
              ]
            ),
           
            backgroundColor: Colors.amber[50],
      body: SingleChildScrollView(
        child: Column(
          
          children: [
              const SizedBox(
              height: 10,
            ),
            // Add an image slider here
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 2.0,
              ),
              items: [
                // Add your images here 
                Image.asset("assets/images/ss1.png", fit: BoxFit.cover),
                Image.asset("assets/images/ss2.png", fit: BoxFit.cover),
                Image.asset("assets/images/ss3.png", fit: BoxFit.cover),
                Image.asset("assets/images/ss4.png", fit: BoxFit.cover),
                Image.network("https://travellemming.com/wp-content/uploads/Best-Things-to-Do-in-Penang-Featured-Image.jpg", fit: BoxFit.cover),
                
                // Add more images as needed
              ],
            ),
          const SizedBox(height: 10,),
           Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Destination",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                                Container(
                                
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4, // Set the itemCount to the number of destinations
                      itemBuilder: (context, index) {
                        List<String> destinations = ["Gua Kelam", "Penang Komtar", "Alor Setar", "Langkawi"];
                        String destinationName = destinations[index];

                        // Assuming your images are named "image1.png", "image2.png", etc.
                        String imageName = "hd${index + 1}";
                        

                        return Container(
                          height: 100,
                          child: Card(
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (content) => admdestinationlistscreen(user: widget.user)
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
                          ),
                          
                        );
                      },
                    ),  
                  ),
                   Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child:  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    minWidth: screenWidth / 3,
                                    height: 40,
                                    elevation: 10,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => admdestinationlistscreen(user: widget.user)),
                                      );
                                    },
                                    color: Colors.amber,
                                    textColor: Colors.black,
                                    child: const Text('More...',style: const TextStyle(fontSize: 20)),
                                  ),
                              ),
                            ),
                          const SizedBox(height: 20,),
                                  Card(
                                        child: InkWell(
                                          onTap: () {
                                            // Handle button click
                                          },
                                          child: Stack(
                                            children: [
                                              Image.asset(
                                                "assets/images/ss1.png", // Replace with your image path
                                                width: double.infinity,
                                                height: 150,
                                                fit: BoxFit.cover,
                                              ),
                                              Positioned(
                                                // Center the button
                                                top: 0,
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: Center(
                                                  child: MaterialButton(
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20.0),
                                                              ),
                                                              minWidth: screenWidth/5,
                                                              height: 40,
                                                              elevation: 10,
                                                              onPressed: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(builder: (context) => destinationlistscreen(user: widget.user)),
                                                                );
                                                              },
                                                              color: Colors.amber,
                                                              textColor: Colors.black,
                                                                child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Icon(Icons.upload), // Add your upload icon
                                                                                SizedBox(width: 8), // Add some space between icon and text
                                                                                Text('Upload'),
                                                                              ],
                                                                            ),
                                                            ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                        const SizedBox(height: 20,),
                                                Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                            "Hotel",
                                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                          ),
                                                        ),
                                                                      Container(
                                                                      
                                                          height: 150,
                                                          child: ListView.builder(
                                                            scrollDirection: Axis.horizontal,
                                                            itemCount: 4, // Set the itemCount to the number of destinations
                                                            itemBuilder: (context, index) {
                                                              List<String> destinations = ["Eastin Hotel, Penang", "Bayview Hotel, Penang", "Raia Hotel, Kedah", "Putra Brasmana Hotel, Perlis"];
                                                              String destinationName = destinations[index];

                                                              // Assuming your images are named "image1.png", "image2.png", etc.
                                                              String imageName = "hh${index + 1}";
                                                              

                                                              return Container(
                                                                height: 100,
                                                                child: Card(
                                                                  child: InkWell(
                                                                    onTap: () async {
                                                                      await Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (content) => admhotellistscreen(user: widget.user)
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
                                                                ),
                                                                
                                                              );
                                                            },
                                                          ),  
                                                        ),
                                                        Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Align(
                                                                      alignment: Alignment.centerRight,
                                                                      child:  MaterialButton(
                                                                          shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(20.0),
                                                                          ),
                                                                          minWidth: screenWidth / 3,
                                                                          height: 40,
                                                                          elevation: 10,
                                                                          onPressed: () {
                                                                            Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context) => destinationlistscreen(user: widget.user)),
                                                                            );
                                                                          },
                                                                          color: Colors.amber,
                                                                          textColor: Colors.black,
                                                                          child: const Text('More...',style: const TextStyle(fontSize: 20)),
                                                                        ),
                                                                    ),
                                                                  ),

                                                                  const SizedBox(height: 20,),
                                                                    Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                "Review",
                                                                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ),
                                                                                          Container(
                                                                                          
                                                                              height: 150,
                                                                              child: ListView.builder(
                                                                                scrollDirection: Axis.horizontal,
                                                                                itemCount: 4, // Set the itemCount to the number of destinations
                                                                                itemBuilder: (context, index) {
                                                                                  List<String> destinations = ["Entopia, Penang", "Chew Jetty, Penang", "Pantai Cenang, Kedah", "Telaga Tujuh Waterfall"];
                                                                                  String destinationName = destinations[index];

                                                                                  // Assuming your images are named "image1.png", "image2.png", etc.
                                                                                  String imageName = "hr${index + 1}";
                                                                                  

                                                                                  return Container(
                                                                                    height: 100,
                                                                                    child: Card(
                                                                                      child: InkWell(
                                                                                        onTap: () async {
                                                                                          await Navigator.push(
                                                                                            context,
                                                                                            MaterialPageRoute(
                                                                                              builder: (content) => destinationlistscreen(
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
                                                                                    ),
                                                                                    
                                                                                  );
                                                                                },
                                                                              ),  
                                                                            ),
                                                                            Padding(
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: Align(
                                                                                          alignment: Alignment.centerRight,
                                                                                          child:  MaterialButton(
                                                                                              shape: RoundedRectangleBorder(
                                                                                                borderRadius: BorderRadius.circular(20.0),
                                                                                              ),
                                                                                              minWidth: screenWidth / 3,
                                                                                              height: 40,
                                                                                              elevation: 10,
                                                                                              onPressed: () {
                                                                                                Navigator.push(
                                                                                                  context,
                                                                                                  MaterialPageRoute(builder: (context) => destinationlistscreen(user: widget.user)),
                                                                                                );
                                                                                              },
                                                                                              color: Colors.amber,
                                                                                              textColor: Colors.black,
                                                                                              child: const Text('More...',style: const TextStyle(fontSize: 20)),
                                                                                            ),
                                                                                        ),
                                                                                      ),
   
         
          













          
          ],
        ),
      ),
    );
}}