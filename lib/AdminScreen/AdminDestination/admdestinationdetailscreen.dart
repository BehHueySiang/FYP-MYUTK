import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/src/legacy_api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myutk/AdminScreen/AdminDestination/admdestinationlistscreen.dart';
import 'package:myutk/models/user.dart';
import 'package:myutk/models/destination.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';

class AdmDestinationDetailScreen extends StatefulWidget {
  final User user;
  Des destination;

  AdmDestinationDetailScreen(
      {super.key, required this.user, required this.destination});

  @override
  State<AdmDestinationDetailScreen> createState() =>
      _AdmDestinationDetailScreenState();
}

class _AdmDestinationDetailScreenState
    extends State<AdmDestinationDetailScreen> {
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
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_active),
          ),
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
                                        "${MyConfig().SERVER}/MyUTK/assets/Destination/${widget.destination.desid?.toString() ?? 'default'}_image.png?v=${DateTime.now().millisecondsSinceEpoch}",
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
                                        "${MyConfig().SERVER}/MyUTK/assets/Destination/${widget.destination.desid?.toString() ?? 'default'}_image2.png?v=${DateTime.now().millisecondsSinceEpoch}",
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
                                        "${MyConfig().SERVER}/MyUTK/assets/Destination/${widget.destination.desid?.toString() ?? 'default'}_image3.png?v=${DateTime.now().millisecondsSinceEpoch}",
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
                                "Destination Name: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                widget.destination.desname.toString(),
                                style: TextStyle(fontSize: 13, height: 3),
                              ),
                            )
                          ]),

                          // Third TableRow with 4 columns (open time and close time in the same row)
                          TableRow(children: [
                            TableCell(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      "Open Time: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          height: 2),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Text(
                                      widget.destination.opentime.toString(),
                                      style: TextStyle(fontSize: 13, height: 2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TableCell(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      "Close Time: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          height: 2),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Text(
                                      widget.destination.closetime.toString(),
                                      style: TextStyle(fontSize: 13, height: 2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            const TableCell(
                              child: Text(
                                "Suggest Time: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    height: 2),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                widget.destination.suggesttime.toString(),
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
                                widget.destination.activity.toString(),
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
                            const TableCell(
                              child: Text(
                                "State: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    height: 2),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                widget.destination.desstate.toString(),
                                style: TextStyle(fontSize: 13, height: 2),
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
                                      " ${double.parse(widget.destination.desrate.toString()).toStringAsFixed(0)} /10",
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
                                "RM ${double.parse(widget.destination.desbudget.toString()).toStringAsFixed(0)} per person",
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
                        SizedBox(width: 5,),
                        SizedBox(
                          width: 160, // Adjust the width as needed
                          height: 50, // Adjust the height as needed
                          child: ElevatedButton(
                            onPressed: () {
                              double? la = widget.destination.latitude != null
                                  ? double.parse(
                                      widget.destination.latitude.toString())
                                  : null;
                              double? long = widget.destination.longtitude !=
                                      null
                                  ? double.parse(
                                      widget.destination.longtitude.toString())
                                  : null;
                              print(la);
                              if (la != null && long != null) {
                                _launchGoogleMaps(la, long);
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
                                      fontSize: 16,
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
                       SizedBox(width: 5,),

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

  Future<void> _launchGoogleMaps(double la, double long) async {
    final String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$la,$long';
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      print('Could not launch Google Maps URL');
    }
  }

}
