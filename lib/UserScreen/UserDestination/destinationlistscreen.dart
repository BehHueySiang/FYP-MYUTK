import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myutk/models/destination.dart';
import 'package:myutk/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';
import 'package:myutk/AdminScreen/AdminDestination/admdestinationdetailscreen.dart';

class DestinationListScreen extends StatefulWidget {
  final User user;

  const DestinationListScreen({
    super.key,
    required this.user,
  });

  @override
  State<DestinationListScreen> createState() => _DestinationListScreenState();
}

class _DestinationListScreenState extends State<DestinationListScreen> {
  Des destination = Des();
  late double screenHeight, screenWidth;
  TextEditingController _searchController = TextEditingController();
  late int axiscount = 2;
  late List<Widget> tabchildren;
  String maintitle = "Destination";
  int numofpage = 1, curpage = 1, numberofresult = 0;
  List<Des> Deslist = <Des>[];

  var color;

  @override
  void initState() {
    super.initState();
    loaddes(1);
    print("AddDesList");
  }

  void reloadPage() {
    loaddes(1);
    print("DesList");
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
          title: Text(
            maintitle,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.amber[200],
        ),
        backgroundColor: Colors.amber[50],
        body: RefreshIndicator(
          onRefresh: () async {
            // Implement your refresh logic here
            reloadPage();
          },
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
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
                padding: EdgeInsets.only(
                    right: 16.0), // Adjust the right padding as needed
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
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Deslist.isEmpty
                  ? Center(
                      child: Text("No Data"),
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: axiscount,
                        childAspectRatio: (6 /
                            2), // Adjust this value according to your images aspect ratio
                        // You may need to adjust childAspectRatio according to your item's aspect ratio
                      ),
                      itemCount: Deslist.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      10), // Adjust border radius as needed
                                  color: Colors
                                      .white, // You can set any color you like for the background
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Card(
                                    color: Colors.amber[100],
                                    child: InkWell(
                                      onTap: () async {
                                        Des destination = Des.fromJson(
                                            Deslist[index].toJson());
                                        await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (content) =>
                                                    AdmDestinationDetailScreen(
                                                        user: widget.user,
                                                        destination:
                                                            destination)));
                                        loaddes(1);
                                      },
                                      // Optional: Adds a slight shadow to the card
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex:
                                                2, // Adjust the flex to control the size ratio between the image and the text/icons
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl:
                                                  "${MyConfig().SERVER}/MyUTK/assets/Destination/${Deslist[index].desid}_image.png?v=${DateTime.now().millisecondsSinceEpoch}",
                                              placeholder: (context, url) =>
                                                  const LinearProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                          Expanded(
                                            flex:
                                                2, // Adjust the flex to control the size ratio between the image and the text/icons
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  horizontal:
                                                      8.0), // Add padding around the text and icons
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Expanded(
                                                    // Wrap the text in an Expanded widget to allow for centering.
                                                    child: FittedBox(
                                                      // Ensures that the text fits within the available space.
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        Deslist[index]
                                                            .desname
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        ),
                                                        textAlign: TextAlign
                                                            .center, // Center text horizontally.
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))));
                      },
                    ),
            ),
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Previous page button
                  TextButton(
                    onPressed: curpage > 1
                        ? () {
                            setState(() {
                              curpage--;
                              loaddes(curpage);
                            });
                          }
                        : null,
                    child: Text(
                      "<<",
                      style: TextStyle(
                        color: curpage > 1 ? Colors.black : Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(
                    curpage.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  // Next page button
                  TextButton(
                    onPressed: curpage < numofpage
                        ? () {
                            setState(() {
                              curpage++;
                              loaddes(curpage);
                            });
                          }
                        : null,
                    child: Text(
                      ">>",
                      style: TextStyle(
                        color: curpage < numofpage ? Colors.black : Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }

  void loaddes(int pageno) {
    if (widget.user.id == "na") {
      setState(() {
        // titlecenter = "Unregistered User";
      });
      return;
    }

    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/load_des.php"),
        body: {"pageno": pageno.toString()}).then((response) {
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

            Deslist.forEach((element) {});
          });
          print(Deslist[0].desname);
        }
        setState(() {});
      }
    });
  }

  void _performSearch(String keyword) {
    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/load_des.php"),
        body: {"userid": widget.user.id, "search": keyword}).then((response) {
      //print(response.body);
      log(response.body);
      Deslist.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['Des'].forEach((v) {
            Deslist.add(Des.fromJson(v));
          });
          print(Deslist[0].desname);
        }
        setState(() {});
      }
    });
  }
}
