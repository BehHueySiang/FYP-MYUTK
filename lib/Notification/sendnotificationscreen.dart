import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myutk/models/user.dart';
import 'package:myutk/models/review.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';



class SendNotificationScreen extends StatefulWidget {
  final User user;
  
  const SendNotificationScreen({super.key, required this.user});

  @override
  State<SendNotificationScreen> createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {
     List<File?> _images = List.generate(3, (_) => null);
     int index = 0;
     List<Review> ReviewList = <Review>[];
    
     var pathAsset = "assets/images/camera1.png";
     final _formKey = GlobalKey<FormState>();
      late double screenHeight, screenWidth, cardwitdh;
      final TextEditingController _TitleEditingController =
          TextEditingController();
      final TextEditingController _ContentEditingController =
          TextEditingController();
     

      @override
        Widget build(BuildContext context) {
           screenHeight = MediaQuery.of(context).size.height;
           screenWidth = MediaQuery.of(context).size.width;
           return Scaffold(
            appBar: AppBar(
        title: Image.asset(
                    "assets/images/Logo.png",
                  ),
         backgroundColor: Colors.amber[200],
        actions: [
             IconButton(
              onPressed: () {
                
              },
              icon: const Icon(Icons.notifications_active)),
              ]
            ),
            backgroundColor: Colors.amber[50],
            
             body: SingleChildScrollView( // Make the entire body scrollable
      child: Column(children: [ 
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Form(
              key: _formKey,
                child: Column(
                  children: [ 
                        TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (val) =>
                                  val!.isEmpty || (val.length < 3)
                                      ? "Title must be longer than 3"
                                      : null,
                              onFieldSubmitted: (v) {},
                              controller: _TitleEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Title',
                                  labelStyle: TextStyle(color: Colors.amber),
                                   focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),)),),
                                    const SizedBox(height: 20,),
                   
                        const SizedBox(height: 20,),
                        TextFormField(
                              textInputAction: TextInputAction.next,
                               maxLines: 10,       
                              onFieldSubmitted: (v) {},
                              controller: _ContentEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Content',
                                  labelStyle: TextStyle(color: Colors.amber),
                                   focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),)),),
                               const SizedBox(height: 20,),

                        SizedBox(
                                      width: screenWidth / 1.2,
                                      height: 50,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            insertDialog();
                                          },
                                          child: const Text("Send",style: TextStyle(color: Colors.black), ),
                                          style: ButtonStyle(
                                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),)),),
                                                    const SizedBox(height: 30,),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ]
                                          ),
                                        ),
                                      );
                                      
                                    }

 void insertDialog() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Check your input")));
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "This notification will send to all user",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                sendnotification();
                //registerUser();
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

  //////////////
void sendnotification() {
    String Title = _TitleEditingController.text;
    String Content = _ContentEditingController.text;
   
    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/sendnotification.php"),
        body: {
        
          "title": Title,
          "content": Content,
          
        }).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Send Successfully")));
         
              
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Send Failed")));
        }
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Send Failed")));
        Navigator.pop(context);
      }
    });
  }
}