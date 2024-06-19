import 'package:flutter/material.dart';
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
        title: Image.asset("assets/images/Logo.png"),
        backgroundColor: Colors.amber[200],
        actions: [
         
        ],
      ),
      backgroundColor: Colors.amber[50],
      body: Column(
        // Wrap with Column
        children: [
          Expanded(
            // Wrap with Expanded
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
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
                                    imageUrl:
                                        "${MyConfig().SERVER}/MyUTK/assets/Hotel/${widget.hotel.hotelid?.toString() ?? 'default'}_image.png?v=${DateTime.now().millisecondsSinceEpoch}",
                                    placeholder: (context, url) =>
                                        const LinearProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
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
                                    imageUrl:
                                        "${MyConfig().SERVER}/MyUTK/assets/Hotel/${widget.hotel.hotelid?.toString() ?? 'default'}_image2.png?v=${DateTime.now().millisecondsSinceEpoch}",
                                    placeholder: (context, url) =>
                                        const LinearProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
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
                                    imageUrl:
                                        "${MyConfig().SERVER}/MyUTK/assets/Hotel/${widget.hotel.hotelid?.toString() ?? 'default'}_image3.png?v=${DateTime.now().millisecondsSinceEpoch}",
                                    placeholder: (context, url) =>
                                        const LinearProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(4),
                          1: FlexColumnWidth(5),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(children: [
                            const TableCell(
                              child: Text(
                                "Hotel Name: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                widget.hotel.hotelname.toString(),
                                style: TextStyle(fontSize: 13, height: 3),
                              ),
                            )
                          ]),
                          TableRow(children: [
                            const TableCell(
                              child: Text(
                                "State: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                widget.hotel.hotelstate.toString(),
                                style: TextStyle(fontSize: 13, height: 3),
                              ),
                            )
                          ]),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly, // Adjust as needed
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 160, // Adjust the width as needed
                          height: 50, // Adjust the height as needed
                          child: ElevatedButton(
                            onPressed: () {
                              String? hotelname = widget.hotel.hotelname != null
                                  ? widget.hotel.hotelname.toString()
                                  : null;
                              print(hotelname);
                              if (hotelname != null) {
                                _launchGoogleMaps(hotelname);
                              } else {
                                print('Latitude or longitude value is null');
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.directions,
                                  color: Colors.black,
                                ),
                                // Adjust spacing between icon and text
                                Text(
                                  "Directions",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                      height: 1),
                                ),
                              ],
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.amber),
                            ),
                          ),
                        ),
                        SizedBox(width: 10), // Adjust spacing between buttons
                        SizedBox(
                          width: 160, // Adjust the width as needed
                          height: 50, // Adjust the height as needed
                          child: ElevatedButton(
                            onPressed: () {
                              String? bookinglink =
                                  widget.hotel.bookingurl != null
                                      ? widget.hotel.bookingurl.toString()
                                      : null;
                              print(bookinglink);
                              if (bookinglink != null) {
                                _launchbookinglink(bookinglink);
                              } else {
                                print(' null');
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.directions,
                                  color: Colors.black,
                                ),
                                // Adjust spacing between icon and text
                                Text(
                                  "Booking Link",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                      height: 1),
                                ),
                              ],
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.amber),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(10),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(children: [
                            const TableCell(
                              child: Text(
                                "Activity: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    height: 2),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Text(
                                widget.hotel.note.toString(),
                                style: TextStyle(fontSize: 13, height: 2),
                              ),
                            )
                          ]),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(4),
                          1: FlexColumnWidth(5),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(children: [
                            TableCell(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 10,
                                    child: Text(
                                      "Estimate Budget: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          height: 2),
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          height: 2),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Text(
                                      " ${double.parse(widget.hotel.hotelrate.toString()).toStringAsFixed(0)} /10",
                                      style: TextStyle(fontSize: 13, height: 2),
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
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                "",
                                style: TextStyle(fontSize: 16, height: 2),
                              ),
                            )
                          ]),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly, // Adjust as needed
                      children: [
                        SizedBox(
                          width: 5,
                        ),

                        SizedBox(width: 170), // Adjust spacing between buttons
                        SizedBox(
                          width: 150, // Adjust the width as needed
                          height: 50, // Adjust the height as needed
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "Back",
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.amber),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchGoogleMaps(String hotelname) async {
    final Uri _url =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$hotelname');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> _launchbookinglink(String bookinglink) async {
    final Uri _url = Uri.parse(bookinglink);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
