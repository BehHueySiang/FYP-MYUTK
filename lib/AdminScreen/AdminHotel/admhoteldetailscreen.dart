import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/src/legacy_api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myutk/AdminScreen/AdminHotel/admhotellistscreen.dart';
import 'package:myutk/models/user.dart';
import 'package:myutk/models/hotel.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';
import 'package:url_launcher/url_launcher_string.dart';




class AdmHotelDetailScreen extends StatefulWidget {
  final User user;
 Hotel hotel;

   AdmHotelDetailScreen({super.key, required this.user, required this.hotel});

  @override
  State<AdmHotelDetailScreen> createState() => _AdmHotelDetailScreenState();
}

class _AdmHotelDetailScreenState extends State<AdmHotelDetailScreen> {
  late double screenHeight, screenWidth;
  late int axiscount = 2;
  
  

  @override
  void initState() {
    super.initState();
    print("Hotel Detail");
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
      body: Column( // Wrap with Column
        children: [
          Expanded( // Wrap with Expanded
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
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
                              'Hotel',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: SizedBox(
                        height: screenHeight / 2.5,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                              child: Card(
                                child: Container(
                                  width: screenWidth,
                                  child: CachedNetworkImage(
                                    width: screenWidth,
                                    fit: BoxFit.cover,
                                    imageUrl:  "${MyConfig().SERVER}/myutk/assets/Destination/${widget.hotel.hotelid?.toString() ?? 'default'}_image.png?v=${DateTime.now().millisecondsSinceEpoch}",
                                    placeholder: (context, url) => const LinearProgressIndicator(),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                              child: Card(
                                child: Container(
                                  width: screenWidth,
                                  child: CachedNetworkImage(
                                    width: screenWidth,
                                    fit: BoxFit.cover,
                                    imageUrl: "${MyConfig().SERVER}/myutk/assets/Destination/${widget.hotel.hotelid?.toString() ?? 'default'}_image2.png?v=${DateTime.now().millisecondsSinceEpoch}",
                                    placeholder: (context, url) => const LinearProgressIndicator(),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                              child: Card(
                                child: Container(
                                  width: screenWidth,
                                  child: CachedNetworkImage(
                                    width: screenWidth,
                                    fit: BoxFit.cover,
                                    imageUrl: "${MyConfig().SERVER}/myutk/assets/Destination/${widget.hotel.hotelid?.toString() ?? 'default'}_image3.png?v=${DateTime.now().millisecondsSinceEpoch}",
                                    placeholder: (context, url) => const LinearProgressIndicator(),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(4),
                          1: FlexColumnWidth(5),
                        },
                        children: [
                          TableRow(children: [
                            const TableCell(
                              child: Text(
                                "Hotel Name: ",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, height: 5),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                widget.hotel.hotelname.toString(),
                                style: TextStyle(fontSize: 16, height: 5),
                              ),
                            )
                          ]),
                          
                             TableRow(children: [
                                 TableCell(
                                  child: ElevatedButton(
                               onPressed: (){_launchUrl(widget.hotel.bookurl.toString());},
                                
                                      
                               child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.directions, color: Colors.black,),
                                            SizedBox(width: 8), // Adjust spacing between icon and text
                                            Text(
                                              "Booking",
                                              style: TextStyle(fontSize: 16, color: Colors.black, height: 1),
                                            ),
                                          ],
                                        ),
                                style: ButtonStyle(
                                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),),
                              ),
                                ),
                                
                                TableCell(
                                   child: ElevatedButton(
                               onPressed: (){_launchUrl(widget.hotel.hotelurl.toString());},
                                
                                      
                               child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.directions, color: Colors.black,),
                                            SizedBox(width: 8), // Adjust spacing between icon and text
                                            Text(
                                              "Direction",
                                              style: TextStyle(fontSize: 16, color: Colors.black, height: 1),
                                            ),
                                          ],
                                        ),
                                style: ButtonStyle(
                                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),),
                              ),
                                )
                              ]), 
                          TableRow(children: [
                              const TableCell(
                                child: Text(
                                  "Note: ",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, height: 2),
                                ),
                              ),
                              TableCell(
                                child: Text(
                                  widget.hotel.note.toString(),
                                  style: TextStyle(fontSize: 16, height: 2),
                                ),
                              )
                            ]),
                            
                              TableRow(children: [
                                const TableCell(
                                  child: Text(
                                    "State: ",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, height: 2),
                                  ),
                                ),
                                TableCell(
                                  child: Text(
                                    widget.hotel.hotelstate.toString(),
                                    style: TextStyle(fontSize: 16, height: 2),
                                  ),
                                )
                              ]),
                                   TableRow(children: [
                            TableCell(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 10,
                                    child: Text(
                                      "Estimate Budget: ",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, height: 2),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "",
                                      style: TextStyle(fontSize: 16, height: 2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TableCell(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Rate: ",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, height: 2),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Text(
                                      " ${double.parse(widget.hotel.hotelrate.toString()).toStringAsFixed(0)} /10",
                                      style: TextStyle(fontSize: 16, height: 2),
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ),
                          ]),
                          TableRow(children: [
                                 TableCell(
                                  child: Text(
                                     "RM ${double.parse(widget.hotel.hotelbudget.toString()).toStringAsFixed(0)} per person",
                                    style: TextStyle( fontSize: 16, ),
                                  ),
                                ),
                                const TableCell(
                                  child: Text(
                                    "",
                                    style: TextStyle(fontSize: 16, height: 2),
                                  ),
                                )
                              ]),
                             TableRow(children: [
                                 const TableCell(
                                  child: Text(
                                      " ",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, height: 2),
                                    ),
                                ),
                                
                                TableCell(
                                    
                                      
                                          child: ElevatedButton(
                                              onPressed: () async{
                                                        
                                                          await Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  
                                                                  builder: (content) => admhotellistscreen(user: widget.user)
                                                                
                                                                ),
                                                              );
              },
                                              child: const Text("Back",style: TextStyle(color: Colors.black), ),
                                              style: ButtonStyle(
                                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),))
                                )
                              ]),   
                              
                        ],
                      ),
                      
                    ),
 
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _launchUrl( urlString) async {
    if (await canLaunch(urlString)) {
      await launch(urlString);
    } else {
      throw 'Could not launch $urlString';
    }
  }
}

