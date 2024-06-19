
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myutk/models/user.dart';
import 'package:myutk/EntryScreen/editprofilescreen.dart';
import 'package:myutk/EntryScreen/loginscreen.dart';
import 'package:myutk/EntryScreen/mainscreen.dart';
import 'package:myutk/EntryScreen/registrationscreen.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';



// for profile screen

class admProfileTabScreen extends StatefulWidget {
  final User user;
 
  const admProfileTabScreen({super.key, required this.user});

  @override
  State<admProfileTabScreen> createState() => _admProfileTabScreenState();
}

class _admProfileTabScreenState extends State<admProfileTabScreen> {
  late List<Widget> tabchildren;
  String maintitle = "AdmProfile";
  late double screenHeight, screenWidth, cardwitdh;

  
   bool isDisable = true;
   void logout() {
    setState(() {
      widget.user.id = "na";
      widget.user.name = "Not Available";
      widget.user.email = "";
      widget.user.phone = "";
      widget.user.useraddress = "";
      isDisable = true;
    });

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MainScreen(user: widget.user)),
      (Route<dynamic> route) => false,
    );
  }
  @override
  void initState() {
    super.initState();
    
    
    print("Profile");
  }

  @override
  void dispose() {
    super.dispose();
     if (widget.user.id == "na") {
      isDisable = true;
    } else {
      isDisable = false;
    }
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
  bool isLoggedIn = widget.user.id != "na";

    return Scaffold(
      appBar: AppBar(
        title: Text(maintitle,style: TextStyle(color: Colors.black,),),
        backgroundColor: Colors.amber[200],
        automaticallyImplyLeading: false,

        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.black),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Logout'),
                    content: Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                      TextButton(
                        child: Text('Logout'),
                        onPressed: logout, // Call logout() method
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
        
      ),
      backgroundColor: Colors.amber[50],
      body: Center(
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: screenHeight * 0.30,
            width: screenWidth,
             color: Colors.amber[200],
            child: Card(
              color: Colors.amber[500],
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  margin: EdgeInsets.all(4),
                  width: screenWidth * 0.4,
                  child: Image.asset(
                    "assets/images/Profilepic.jpg",
                  ),
                ),
                Flexible(
                      flex: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                         
                          widget.user.name.toString() == "na"
                             ?const Column(
                                children: [
                                  Text(
                                    "Not Available",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Divider(),
                                  Text(""),
                                  Text(""),
                                  Text(""),
                                  Text(""),
                                ],
                             )
                           :Column(   children: [
                            
                          Text(widget.user.name.toString(),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 2, 0, 8),
                            child: Divider(
                              color: Colors.amber,
                              height: 3,
                              thickness: 6.0,
                            ),
                          ),
                        Table(
                            columnWidths: const {
                              0: FractionColumnWidth(0.3),
                              1: FractionColumnWidth(0.7)
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: [
                            TableRow(children: [
                                const Icon(Icons.email),
                                Text(widget.user.email.toString()),
                              ]),
                            TableRow(children: [
                                const Icon(Icons.phone),
                                Text(widget.user.phone.toString()),
                              ]),
                               TableRow(children: [
                                const Icon(Icons.home),
                                Text(widget.user.useraddress.toString(),softWrap: true, // Allow text to wrap to the next line
      overflow: TextOverflow.clip, ),
                              ]),
                             
                            
                            
                          
                             ]),
                             //table, children
                             IconButton(
                                     onPressed: () {
                                                      
                                      Navigator.push(
                                          context,
                                            MaterialPageRoute(
                                               builder: (content) =>  EditProfileScreen(user: widget.user)));
                                                ////////
                                                   },
                                                  icon: const Icon(Icons.edit_square,color: Colors.black)
                                                  )
                                                 
                              ],
                              )
                              ]
                              )
                              ),
                                              ]
                                              ),
                              
            ),
          ),
                  
if (!isLoggedIn)
          Expanded(
              child: ListView(
            children: [
             
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (content) => const LoginScreen()));
                },
                child: const Text("LOGIN"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (content) => const RegistrationScreen()));
                },
                child: const Text("REGISTRATION"),
              ),
            ],
          ))
        ]),
      ),
    );
  }
  
  //////
  
  
 
  
  
}