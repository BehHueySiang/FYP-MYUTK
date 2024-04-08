import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myutk/UserScreen/UserHotel/hotellistscreen.dart';
import 'package:myutk/UserScreen/UserReview/reviewlistscreen.dart';
import 'package:myutk/models/tripinfo.dart';
import 'package:myutk/models/user.dart';
import 'package:myutk/models/destination.dart';
import 'package:myutk/models/hotel.dart';
import 'package:myutk/models/review.dart';
import 'package:myutk/models/HomeScreen/homedes.dart';
import 'package:myutk/models/HomeScreen/hometrip.dart';
import 'package:myutk/models/HomeScreen/homehotel.dart';
import 'package:myutk/models/HomeScreen/homereview.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';
import 'package:myutk/UserScreen/UserDestination/destinationlistscreen.dart';
import 'package:myutk/UserScreen/UserItinerary/AddUserTripscreen.dart';
import 'package:myutk/UserScreen/UserItinerary/homeitineraryscreen.dart';
import 'package:myutk/EntryScreen/loginscreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:myutk/AdminScreen/AdminManagementScreen/HomeManage/addhomedesscreen.dart';
import 'package:myutk/AdminScreen/AdminManagementScreen/HomeManage/addhometripscreen.dart';
import 'package:myutk/AdminScreen/AdminManagementScreen/HomeManage/addhomehotelscreen.dart';
import 'package:myutk/AdminScreen/AdminManagementScreen/HomeManage/addhomereviewscreen.dart';





class hometabscreen extends StatefulWidget {
  final User user;
  const hometabscreen({super.key, required this.user});

  @override
  State<hometabscreen> createState() => _hometabscreenState();
}

class _hometabscreenState extends State<hometabscreen> {
  String maintitle = "Home";
  Des des = Des ();
  Tripinfo tripinfo =Tripinfo();
  Hotel hotel =Hotel();
  Review review =Review();
  Homedes homedes = Homedes ();
  Hometrip hometrip = Hometrip ();
  Homehotel homehotel = Homehotel ();
  Homereview homereview = Homereview ();
  late double screenHeight, screenWidth;
  late int axiscount = 2;
  int numofpage = 1, curpage = 1,index =0 ;
  int numberofresult = 0;
  List<Des> Deslist = <Des>[];
  List<Tripinfo> Tripinfolist = <Tripinfo>[];
  List<Hotel> Hotellist = <Hotel>[];
  List<Review> Reviewlist = <Review>[]; 
  List<Homedes> Hdeslist = <Homedes>[];
  List<Hometrip> Htriplist = <Hometrip>[];
  List<Homehotel> Hhotellist = <Homehotel>[];
   List<Homereview> Hreviewlist = <Homereview>[];
  var color;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loaddes(1);
    loadhdes();
    loadtripinfo(1);
    loadhtrip();
    loadhotel(1);
    loadhhotel();
    loadreview(1);
    loadhreview();
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
         automaticallyImplyLeading: false,
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
                viewportFraction: 1,
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

            ////////////////////////
//For Popular Destination
          const SizedBox(height: 20,),
           Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "  Popular Destination",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    
                  ),
                 Container(
                                
                  height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: Hdeslist.length, // Set the itemCount to the number of destinations
                      itemBuilder: (context, index) {
                         return  Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5), // Adjust border radius as needed
                            color: Color.fromARGB(255, 224, 204, 123), // You can set any color you like for the background
                            boxShadow: [
                              BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              
                          child: Card(
                            color: Color.fromARGB(255, 238, 216, 150),
                            child: InkWell(
                              onTap: () async {
                               
                              }, 
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      width: 200, // Specify the desired width
                                      height: 200,
                                       // Specify the desired height
                                      imageUrl: "${MyConfig().SERVER}/myutk/assets/Destination/${Hdeslist[index].desid.toString()}_image.png",
                                      placeholder: (context, url) => const LinearProgressIndicator(),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    ),
                                  const SizedBox(height: 20,),
                                  Text(
                                     Hdeslist[index].desname.toString(),
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    softWrap: true,
                                    textAlign: TextAlign.center,),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      );
                                                    },
                                                  ),  
                                                ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                          child: Row(
                               mainAxisAlignment: MainAxisAlignment.end, // Align buttons to the right
                                  children: [
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),),
                                      minWidth: screenWidth / 3,
                                      height: 40,
                                      elevation: 10,
                                      onPressed: () {
                                          Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => DestinationListScreen(user: widget.user)),);
                                          },
                                          color: Colors.amber,textColor: Colors.black,child: Text('More...', style: TextStyle(fontSize: 20)), ),
                                        ],
                                      ),
                                    ),//Popular Destination

                const SizedBox(height: 20,),

                            Card( child: InkWell(
                              onTap: () {
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
                                                left: 100,
                                                right: 100,
                                                child: Center(
                                                child: MaterialButton(
                                                     shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              height: 40,
                                                              elevation: 10,
                                                              onPressed: () {
                                                                /*Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(builder: (context) => destinationlistscreen(user: widget.user)),
                                                                );*/
                                                              },
                                                              color: Color.fromARGB(255, 248, 206, 81),
                                                              textColor: Colors.black,
                                                              child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [Icon(Icons.upload), SizedBox(width: 8), Text('Upload'),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ), 
          //For Popular Itinerary
          const SizedBox(height: 20,),
           Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "  Popular Trip Itinerary",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    
                  ),
                 Container(
                                
                  height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: Htriplist.length, // Set the itemCount to the number of destinations
                      itemBuilder: (context, index) {
                         return  Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5), // Adjust border radius as needed
                            color: Color.fromARGB(255, 224, 204, 123), // You can set any color you like for the background
                            boxShadow: [
                              BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              
                          child: Card(
                            color: Color.fromARGB(255, 238, 216, 150),
                            child: InkWell(
                              onTap: () async {
                              
                              },
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      width: 200, // Specify the desired width
                                      height: 200,
                                       // Specify the desired height
                                      imageUrl: "${MyConfig().SERVER}/myutk/assets/Itinerary/${Htriplist[index].tripid}_image.png?v=${DateTime.now().millisecondsSinceEpoch}",
                                      placeholder: (context, url) => const LinearProgressIndicator(),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    ),
                                  const SizedBox(height: 20,),
                                  Text(
                                     Htriplist[index].tripname.toString(),
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    softWrap: true,
                                    textAlign: TextAlign.center,),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      );
                                                    },
                                                  ),  
                                                ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                          child: Row(
                               mainAxisAlignment: MainAxisAlignment.end, // Align buttons to the right
                                  children: [
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),),
                                      minWidth: screenWidth / 3,
                                      height: 40,
                                      elevation: 10,
                                      onPressed: () {
                                         Tripinfo tripinfo = Tripinfo.fromJson(Tripinfolist[index].toJson());
                                          Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => AddUserTripScreen(user: widget.user, tripinfo: tripinfo,)),);
                                          },
                                          color: Colors.amber,textColor: Colors.black,child: Text('More...', style: TextStyle(fontSize: 20)), ),
                                        ],
                                      ),
                                    ),////For Popular Itinerary

                const SizedBox(height: 20,),     

//For Popular Hotel      
 Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "  Popular Hotel",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    
                  ),
                 Container(
                                
                  height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: Hhotellist.length, // Set the itemCount to the number of destinations
                      itemBuilder: (context, index) {
                         return  Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5), // Adjust border radius as needed
                            color: Color.fromARGB(255, 224, 204, 123), // You can set any color you like for the background
                            boxShadow: [
                              BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              
                          child: Card(
                            color: Color.fromARGB(255, 238, 216, 150),
                            child: InkWell(
                              onTap: () async {
                              
                              },
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      width: 200, // Specify the desired width
                                      height: 200,
                                       // Specify the desired height
                                      imageUrl: "${MyConfig().SERVER}/myutk/assets/Hotel/${Hhotellist[index].hotelid}_image.png?v=${DateTime.now().millisecondsSinceEpoch}",
                                      placeholder: (context, url) => const LinearProgressIndicator(),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    ),
                                  const SizedBox(height: 20,),
                                  Text(
                                     Hhotellist[index].hotelname.toString(),
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    softWrap: true,
                                    textAlign: TextAlign.center,),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      );
                                                    },
                                                  ),  
                                                ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                          child: Row(
                               mainAxisAlignment: MainAxisAlignment.end, // Align buttons to the right
                                  children: [
                                   // Add some spacing between buttons
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),),
                                      minWidth: screenWidth / 3,
                                      height: 40,
                                      elevation: 10,
                                      onPressed: () {
                                          Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => HotelListScreen(user: widget.user)),);
                                          },
                                          color: Colors.amber,textColor: Colors.black,child: Text('More...', style: TextStyle(fontSize: 20)), ),
                                        ],
                                      ),
                                    ),////For Popular Itinerary

                const SizedBox(height: 20,),
    //For Popular Review      
 Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "  Popular Review",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    
                  ),
                 Container(        
                  height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: Hreviewlist.length, // Set the itemCount to the number of destinations
                      itemBuilder: (context, index) {
                         return  Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5), // Adjust border radius as needed
                            color: Color.fromARGB(255, 224, 204, 123), // You can set any color you like for the background
                            boxShadow: [
                              BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              
                          child: Card(
                            color: Color.fromARGB(255, 238, 216, 150),
                            child: InkWell(
                              onTap: () async {
                               loadhreview();
                              },
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      width: 200, // Specify the desired width
                                      height: 200,
                                       // Specify the desired height
                                      imageUrl: "${MyConfig().SERVER}/myutk/assets/Review/${Hreviewlist[index].reviewid}_image.png?v=${DateTime.now().millisecondsSinceEpoch}",
                                      placeholder: (context, url) => const LinearProgressIndicator(),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    ),
                                  const SizedBox(height: 20,),
                                  Text(
                                     Hreviewlist[index].reviewname.toString(),
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    softWrap: true,
                                    textAlign: TextAlign.center,),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      );
                                                    },
                                                  ),  
                                                ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                          child: Row(
                               mainAxisAlignment: MainAxisAlignment.end, // Align buttons to the right
                                  children: [
                                   // Add some spacing between buttons
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),),
                                      minWidth: screenWidth / 3,
                                      height: 40,
                                      elevation: 10,
                                      onPressed: () {
                                          Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => ReviewListScreen(user: widget.user)),);
                                          },
                                          color: Colors.amber,textColor: Colors.black,child: Text('More...', style: TextStyle(fontSize: 20)), ),
                                        ],
                                      ),
                                    ),////For Popular Itinerary

                const SizedBox(height: 20,),                                      

 

                                      
                                 
                                                                            
       ],
      ),
    ),
  );
}
//After class _hometabscreenState extends State<hometabscreen> 
 
 //Homedes backend
 void loaddes(int pageno) {
    if (widget.user.id == "na") {
      setState(() {
        // titlecenter = "Unregistered User";
      });
      return;
    }

    http.post(Uri.parse("${MyConfig().SERVER}/myutk/php/load_des.php"),
        body: {
          
          "pageno": pageno.toString()
          }).then((response) {
      print(response.body);
      //log(response.body);
      Deslist.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          numofpage = int.parse(jsondata['numofpage']); //get number of pages
          numberofresult = int.parse(jsondata['numberofresult']);
          print(numberofresult);
          var extractdata = jsondata['data'];
          extractdata['Des'].forEach((v) {
            Deslist.add(Des.fromJson(v));
             
          Deslist.forEach((element) {
           
          });

          });
         
        }
        setState(() {});
      }
    });
  }

 
  void loadhdes() {
   
 

    http.post(Uri.parse("${MyConfig().SERVER}/myutk/php/loadhomedes.php"),
        body: {
          }).then((response) {
      print(response.body);
      //log(response.body);
      Hdeslist.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          
       
          var extractdata = jsondata['data'];
          extractdata['Homedes'].forEach((v) {
            Hdeslist.add(Homedes.fromJson(v));
             
          Hdeslist.forEach((element) {
           
          });

          });
          
        }
        setState(() {});
      }
    });
  }

 

 //Homedes backend

 //HomeTrip backend
 void loadtripinfo(index) {
    

    http.post(Uri.parse("${MyConfig().SERVER}/myutk/php/loadtripinfo.php"),
        body: {
         
         
          }).then((response) {
      print(response.body);
      //log(response.body);
      Tripinfolist.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          
       
          var extractdata = jsondata['data'];
          extractdata['Tripinfo'].forEach((v) {
            Tripinfolist.add(Tripinfo.fromJson(v));
             
          Tripinfolist.forEach((element) {
           
          });

          });
         
        }
        setState(() {});
      }
    });
  }
  void loadhtrip() {
   
    
 

    http.post(Uri.parse("${MyConfig().SERVER}/myutk/php/loadhometrip.php"),
        body: {
          }).then((response) {
      print(response.body);
      //log(response.body);
      Htriplist.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          
       
          var extractdata = jsondata['data'];
          extractdata['Hometrip'].forEach((v) {
            Htriplist.add(Hometrip.fromJson(v));
             
          Htriplist.forEach((element) {
           
          });

          });
         
        }
        setState(() {});
      }
    });
  } //HomeTrip backend

  //HomeHotel backend
   void loadhotel(int pageno) {
    if (widget.user.id == "na") {
      setState(() {
        // titlecenter = "Unregistered User";
      });
      return;
    }

    http.post(Uri.parse("${MyConfig().SERVER}/myutk/php/load_hotel.php"),
        body: {
          
          "pageno": pageno.toString()
          }).then((response) {
      print(response.body);
      //log(response.body);
      Hotellist.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          numofpage = int.parse(jsondata['numofpage']); //get number of pages
          numberofresult = int.parse(jsondata['numberofresult']);
          print(numberofresult);
          var extractdata = jsondata['data'];
          extractdata['Hotel'].forEach((v) {
            Hotellist.add(Hotel.fromJson(v));
          Hotellist.forEach((element) {

           }); });
        }
        setState(() {});
      }
    });
  }
 void loadhhotel() {
 

  if (Hhotellist == null) {
    // Initialize Hhotellist if it's null
    Hhotellist = [];
  }

  http.post(Uri.parse("${MyConfig().SERVER}/myutk/php/loadhomehotel.php"),
    body: {
    }).then((response) {
      print(response.body);
      //log(response.body);
      Hhotellist.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['Homehotel'].forEach((v) {
            Hhotellist.add(Homehotel.fromJson(v));
          });
        }
        setState(() {});
      }
    });
}// HomeHotel backend

  //HomeReview backend
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
        }
        setState(() {});
      }
    });
  }
 void loadhreview() {
  

  if (Hreviewlist == null) {
    // Initialize Hhotellist if it's null
    Hreviewlist = [];
  }

  http.post(Uri.parse("${MyConfig().SERVER}/myutk/php/loadhomereview.php"),
    body: {
    }).then((response) {
      print(response.body);
      //log(response.body);
      Hreviewlist.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['Homereview'].forEach((v) {
            Hreviewlist.add(Homereview.fromJson(v));
          });
        }
        setState(() {});
      }
    });
}
// Homereview backend

////////
}