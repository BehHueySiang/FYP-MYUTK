import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myutk/UserScreen/TabScreen/uploadreviewscreen.dart';
import 'package:myutk/models/user.dart';
import 'package:myutk/models/review.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';
import 'package:url_launcher/url_launcher_string.dart';




class ReviewDetailScreen extends StatefulWidget {
  final User user;
  Review review;

   ReviewDetailScreen({super.key, required this.user, required this.review});

  @override
  State<ReviewDetailScreen> createState() => _ReviewDetailScreenState();
}

class _ReviewDetailScreenState extends State<ReviewDetailScreen> {
  late double screenHeight, screenWidth;
  late int axiscount = 2;
  
  

  @override
  void initState() {
    super.initState();
    print("Review Detail");
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
                                    imageUrl:  "${MyConfig().SERVER}/MyUTK/assets/Review/${widget.review.reviewid?.toString() ?? 'default'}_image.png?v=${DateTime.now().millisecondsSinceEpoch}",
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
                                    imageUrl: "${MyConfig().SERVER}/MyUTK/assets/Review/${widget.review.reviewid?.toString() ?? 'default'}_image2.png?v=${DateTime.now().millisecondsSinceEpoch}",
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
                                    imageUrl: "${MyConfig().SERVER}/MyUTK/assets/Review/${widget.review.reviewid?.toString() ?? 'default'}_image3.png?v=${DateTime.now().millisecondsSinceEpoch}",
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
                                "Review Name: ",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, height: 5),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                widget.review.reviewname.toString(),
                                style: TextStyle(fontSize: 16, height: 5),
                              ),
                            )
                          ]),
                           TableRow(children: [
                            const TableCell(
                              child: Text(
                                "Comment: ",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, height: 5),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                widget.review.comment.toString(),
                                style: TextStyle(fontSize: 16, height: 5),
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
                                                                  
                                                                  builder: (content) => uploadreviewscreen(user: widget.user)
                                                                
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
 
}