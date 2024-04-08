import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myutk/AdminScreen/AdminItinerary/additinerarydestination.dart';
import 'package:myutk/UserScreen/UserReview/addreviewscreen.dart';
import 'package:myutk/UserScreen/UserReview/editreviewscreen.dart';
import 'package:myutk/models/review.dart';
import 'package:myutk/models/tripday.dart';
import 'package:myutk/models/destination.dart';
import 'package:myutk/models/tripinfo.dart';
import 'package:myutk/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';
import 'package:myutk/EntryScreen/loginscreen.dart';
import 'package:myutk/UserScreen/UserReview/reviewdetailscreen.dart';
import 'package:myutk/AdminScreen/AdminDestination/admdestinationdetailscreen.dart';



class HomeItineraryListDetailScreen extends StatefulWidget {
   final User user;
   final Tripinfo tripinfo;

   
  const HomeItineraryListDetailScreen({super.key, required this.user,
  required this.tripinfo, });

  @override
  State<HomeItineraryListDetailScreen> createState() => _HomeItineraryListDetailScreenState();
}

class _HomeItineraryListDetailScreenState extends State<HomeItineraryListDetailScreen> {
  Review review = Review ();
  Des des = Des ();
    Tripday tripday = Tripday ();
  late double screenHeight, screenWidth;
  late int axiscount = 2;
  late List<Widget> tabchildren;
  String maintitle = "Review";
  int numofpage = 1, curpage = 1, numberofresult = 0, index = 0;
  List<Review> Reviewlist = <Review>[];
  List<Tripday> Tripdaylist = <Tripday>[];
  List<Tripinfo> Tripinfolist = <Tripinfo>[];
  List<Des> Deslist = <Des>[];
  var color;
  
  
  @override
  void initState() {
    super.initState();
    loaddes(1);
    loadtripday();
    loadtripinfo();
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
         children: [
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
                  widget.tripinfo.tripname.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20,),
          Row( children: [
                const SizedBox(width: 20,),
                Text(
                  'Trip Type :  ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.tripinfo.triptype.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    
                  ),
                ),
                const SizedBox(width:50,),
                Text(
                  ' Days :    ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.tripinfo.tripday.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    
                  ),
                ),
              ],),
               const SizedBox(height: 10,),
               Row( children: [const SizedBox(width: 20,),
                Text(
                  '     State :  ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.tripinfo.tripstate.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    
                  ),
                ),
               
              ],),   
               const SizedBox(height: 20,), 
          Column(
          children: List.generate(
  int.tryParse(widget.tripinfo.tripday.toString()) ?? 0,
  (index) {
    // Filter destinations for the current day
    List<Tripday> destinationsForDay = Tripdaylist.where((destination) => destination.dayname == (index + 1).toString()).toList();
    
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '     Day  ',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text(
                (index + 1).toString(),
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: destinationsForDay.isEmpty ? screenHeight * 0.6 : null,
            child: destinationsForDay.isEmpty
                ? Center(
                    child: Text("No Data"),
                  )
                : SingleChildScrollView(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: axiscount,
                        childAspectRatio: (6 / 2),
                      ),
                      itemCount: destinationsForDay.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Card(
                              color: Colors.amber[100],
                              child: InkWell(
                                onTap: () async {
                                  Des destination = Des.fromJson(destinationsForDay[index].toJson());
                                  await Navigator.push(context, MaterialPageRoute(builder: (content) => AdmDestinationDetailScreen(user: widget.user, destination: destination)));
                                  loaddes(1);
                                },

                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: "${MyConfig().SERVER}/myutk/assets/Destination/${destinationsForDay[index].desid}_image.png?v=${DateTime.now().millisecondsSinceEpoch}",
                                        placeholder: (context, url) => const LinearProgressIndicator(),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  destinationsForDay[index].desname.toString(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  },
),

          ),
      SizedBox(height: 30),
          ]
        ),
      ),
    ),
   

  );
}

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
          print(Deslist[0].desname);
        }
        setState(() {});
      }
    });
  }
  void loadtripinfo() {
    if (widget.user.id == "na") {
      setState(() {
        // titlecenter = "Unregistered User";
      });
      return;
    }

    http.post(Uri.parse("${MyConfig().SERVER}/myutk/php/loadtripinfo.php"),
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
          print(Tripinfolist[0].tripname);
        }
        setState(() {});
      }
    });
  }
  void loadtripday() {

 

    http.post(Uri.parse("${MyConfig().SERVER}/myutk/php/loadtripday.php"),
        body: {
          "Trip_id": widget.tripinfo.tripid.toString(),
          }).then((response) {
      print(response.body);
      //log(response.body);
      Tripdaylist.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          
       
          var extractdata = jsondata['data'];
          extractdata['Tripday'].forEach((v) {
            Tripdaylist.add(Tripday.fromJson(v));
             
          Tripdaylist.forEach((element) {
           
          });

          });
          print(Tripdaylist[0].desname);
        }
        setState(() {});
      }
    });
  }
  

  

}