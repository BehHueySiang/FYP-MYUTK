import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myutk/UserScreen/UserHotel/hotellistscreen.dart';
import 'package:myutk/UserScreen/UserReview/reviewlistscreen.dart';
import 'package:myutk/Notification/admnotificationscreen.dart';
import 'package:myutk/models/tripday.dart';
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
import 'package:myutk/UserScreen/UserItinerary/homeitineraryscreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:myutk/AdminScreen/AdminManagementScreen/HomeManage/addhomedesscreen.dart';
import 'package:myutk/AdminScreen/AdminManagementScreen/HomeManage/addhometripscreen.dart';
import 'package:myutk/AdminScreen/AdminManagementScreen/HomeManage/addhomehotelscreen.dart';
import 'package:myutk/AdminScreen/AdminManagementScreen/HomeManage/addhomereviewscreen.dart';
import 'package:myutk/AdminScreen/AdminItinerary/itinerarylistdetailscreen.dart';





class admhometabscreen extends StatefulWidget {
  final User user;
  const admhometabscreen({super.key, required this.user});

  @override
  State<admhometabscreen> createState() => _admhometabscreenState();
}

class _admhometabscreenState extends State<admhometabscreen> {
  String maintitle = "AdmItinerary";
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
  List<Tripday> Tripdaylist = <Tripday>[];
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
                  
                   Navigator.push(
                        context,
                         MaterialPageRoute(builder: (context) => AdmNotificationScreen(user: widget.user)),);
              
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
                               onDeleteDesDialog(index);
                               loadhdes();
                              }, 
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      width: 200, // Specify the desired width
                                      height: 200,
                                       // Specify the desired height
                                      imageUrl: "${MyConfig().SERVER}/MyUTK/assets/Destination/${Hdeslist[index].desid.toString()}_image.png",
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
                                      onPressed: () async{
                                          Des destination = Des.fromJson(Deslist[index].toJson());
                                          await Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => AddHomeDesScreen(user: widget.user, destination: destination)),); 
                                          loadhdes();},
                                          color: Colors.amber,textColor: Colors.black,child: Text('Edit', style: TextStyle(fontSize: 20)),),
                                    SizedBox(width: 10), // Add some spacing between buttons
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),),
                                      minWidth: screenWidth / 3,
                                      height: 40,
                                      elevation: 10,
                                      onPressed: () {
                                          Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => HomeItineraryScreen(user: widget.user)),);
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
                        Tripinfo tripinfo = Tripinfo.fromJson(Tripinfolist[index].toJson());
                                                Tripday tripday = Tripday.fromJson(Tripdaylist[index].toJson());

                        await Navigator.push(context, MaterialPageRoute(builder: (content) => ItinerarylListDetailScreen(user: widget.user, tripinfo: tripinfo  ),));
                     
                      },
                              onLongPress: () async {
                               onDeleteHTripDialog(index);
                               loadhtrip();
                              },
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      width: 200, // Specify the desired width
                                      height: 200,
                                       // Specify the desired height
                                      imageUrl: "${MyConfig().SERVER}/MyUTK/assets/Itinerary/${Htriplist[index].tripid}_image.png?v=${DateTime.now().millisecondsSinceEpoch}",
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
                                      onPressed: () async{
                                          Tripinfo tripinfo = Tripinfo.fromJson(Tripinfolist[index].toJson());
                                          await Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => AddHomeTripScreen(user: widget.user, tripinfo: tripinfo)),); 
                                          loadhtrip();},
                                          color: Colors.amber,textColor: Colors.black,child: Text('Edit', style: TextStyle(fontSize: 20)),),
                                    SizedBox(width: 10), // Add some spacing between buttons
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),),
                                      minWidth: screenWidth / 3,
                                      height: 40,
                                      elevation: 10,
                                      onPressed: () {
                                          Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => HomeItineraryScreen(user: widget.user)),);
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
                               onDeleteHHotelDialog(index);
                               loadhhotel();
                              },
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      width: 200, // Specify the desired width
                                      height: 200,
                                       // Specify the desired height
                                      imageUrl: "${MyConfig().SERVER}/MyUTK/assets/Hotel/${Hhotellist[index].hotelid}_image.png?v=${DateTime.now().millisecondsSinceEpoch}",
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
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),),
                                      minWidth: screenWidth / 3,
                                      height: 40,
                                      elevation: 10,
                                      onPressed: () async{
                                          Hotel hotel = Hotel.fromJson(Hotellist[index].toJson());
                                          await Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => AddHomeHotelScreen(user: widget.user, hotel: hotel)),); 
                                          loadhhotel();},
                                          color: Colors.amber,textColor: Colors.black,child: Text('Edit', style: TextStyle(fontSize: 20)),),
                                    SizedBox(width: 10), // Add some spacing between buttons
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
                               onDeleteHReviewDialog(index);
                               loadhreview();
                              },
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      width: 200, // Specify the desired width
                                      height: 200,
                                       // Specify the desired height
                                      imageUrl: "${MyConfig().SERVER}/MyUTK/assets/Review/${Hreviewlist[index].reviewid}_image.png?v=${DateTime.now().millisecondsSinceEpoch}",
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
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),),
                                      minWidth: screenWidth / 3,
                                      height: 40,
                                      elevation: 10,
                                      onPressed: () async{
                                          Review review = Review.fromJson(Reviewlist[index].toJson());
                                          await Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => AddHomeReviewScreen(user: widget.user, review: review)),); 
                                          loadhreview();},
                                          color: Colors.amber,textColor: Colors.black,child: Text('Edit', style: TextStyle(fontSize: 20)),),
                                    SizedBox(width: 10), // Add some spacing between buttons
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
//After class _admhometabscreenState extends State<admhometabscreen> 
 
 //Homedes backend
 void loaddes(int pageno) {
    if (widget.user.id == "na") {
      setState(() {
        // titlecenter = "Unregistered User";
      });
      return;
    }

    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/load_des.php"),
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
    if (widget.user.id == "na") {
      setState(() {
        // titlecenter = "Unregistered User";
      });
      return;
    }
 

    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/loadhomedes.php"),
        body: {
          "userid": widget.user.id.toString(),
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

 

  void onDeleteDesDialog(index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            "Delete ${Hdeslist[index].desname}?",
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () async{
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

  void deleteDes(index) {
    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/deletehomedes.php"),
        body: {
          "userid": widget.user.id,
          "HdesId": Hdeslist[index].hdesid
        }).then((response) {
      print(response.body);
      //Deslist.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Delete Success")));
          loadhdes();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Failed")));
        }
      }
    });
  } //Homedes backend

 //HomeTrip backend
 void loadtripinfo(index) {
    if (widget.user.id == "na") {
      setState(() {
        // titlecenter = "Unregistered User";
      });
      return;
    }

    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/loadtripinfo.php"),
        body: {
          "userid": widget.user.id.toString(),
         
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
    if (widget.user.id == "na") {
      setState(() {
        // titlecenter = "Unregistered User";
      });
      return;
    }
 

    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/loadhometrip.php"),
        body: {
          "userid": widget.user.id.toString(),
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
  }

  void onDeleteHTripDialog(index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            "Delete ${Htriplist[index].tripname}?",
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () async{
                deleteHTrip(index);
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

  void deleteHTrip(index) {
    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/deletehomeitinerary.php"),
        body: {
          "userid": widget.user.id,
          "HtripId": Htriplist[index].htripid
        }).then((response) {
      print(response.body);
      //Deslist.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Delete Success")));
          loadhtrip();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Failed")));
        }
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

    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/load_hotel.php"),
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
  if (widget.user.id == "na") {
    setState(() {
      // titlecenter = "Unregistered User";
    });
    return;
  }

  if (Hhotellist == null) {
    // Initialize Hhotellist if it's null
    Hhotellist = [];
  }

  http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/loadhomehotel.php"),
    body: {
      "userid": widget.user.id.toString(),
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
}

  void onDeleteHHotelDialog(index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            "Delete ${Hhotellist[index].hotelname}?",
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () async{
                deleteHHotel(index);
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

  void deleteHHotel(index) {
    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/deletehomehotel.php"),
        body: {
          "userid": widget.user.id,
          "HhotelId": Hhotellist[index].hhotelid
        }).then((response) {
      print(response.body);
      //Deslist.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Delete Success")));
          loadhhotel();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Failed")));
        }
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

    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/load_review.php"),
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
  if (widget.user.id == "na") {
    setState(() {
      // titlecenter = "Unregistered User";
    });
    return;
  }

  if (Hreviewlist == null) {
    // Initialize Hhotellist if it's null
    Hreviewlist = [];
  }

  http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/loadhomereview.php"),
    body: {
      "userid": widget.user.id.toString(),
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

  void onDeleteHReviewDialog(index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            "Delete ${Hreviewlist[index].reviewname}?",
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () async{
                deleteHReview(index);
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

  void deleteHReview(index) {
    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/deletehomereview.php"),
        body: {
          "userid": widget.user.id,
          "HreviewId": Hreviewlist[index].hreviewid
        }).then((response) {
      print(response.body);
      //Deslist.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Delete Success")));
          loadhreview();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Failed")));
        }
      }
    });
  }// Homereview backend

////////
}