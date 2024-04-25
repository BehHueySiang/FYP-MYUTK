import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myutk/models/user.dart';
import 'package:myutk/models/review.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';


class editreviewscreen extends StatefulWidget {
  final User user;
  Review review;
   editreviewscreen({super.key, required this.user,required this.review});

  @override
  State<editreviewscreen> createState() => _editreviewscreenState();
}

class _editreviewscreenState extends State<editreviewscreen> {
     List<File?> _images = List.generate(3, (_) => null);
     int index = 0;
     List<Review> ReviewList = <Review>[];
    
     var pathAsset = "assets/images/camera1.png";
     final _formKey = GlobalKey<FormState>();
      late double screenHeight, screenWidth, cardwitdh;
      final TextEditingController _ReviewnameEditingController =
          TextEditingController();
      final TextEditingController _CommentEditingController =
          TextEditingController();
      

       @override
       void initState() {
    super.initState();
    print('Debug destination: ${widget.review.toJson()}');
    _ReviewnameEditingController.text = widget.review.reviewname.toString();
    _CommentEditingController.text = widget.review.comment.toString();
  }

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
      child: Column(children: [ Card(
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
                                      ? "Review name must be longer than 3"
                                      : null,
                              onFieldSubmitted: (v) {},
                              controller: _ReviewnameEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Review Name',
                                  labelStyle: TextStyle(color: Colors.amber),
                                   focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),)),),
                                    const SizedBox(height: 20,),
               TextFormField(
                              textInputAction: TextInputAction.next,
                              
                               maxLines: 4,       
                              onFieldSubmitted: (v) {},
                              controller: _CommentEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Comment',
                                  labelStyle: TextStyle(color: Colors.amber),
                                   focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),)),),
                               const SizedBox(height: 20,),
                 
                            const SizedBox(height: 20,),
                    Row(
                    children: [
                         SizedBox(
                      width: screenWidth / 1.2,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            updatereview();
                          },
                          child: const Text("Submit",style: TextStyle(color: Colors.black), ),
                          style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),)),)
                                    ]
                    ),
                    const SizedBox(height: 30,),
                  ],
                ),
              ),
            ),]),),);}

void updatereview() {
    String ReviewName = _ReviewnameEditingController.text;
    String Comment = _CommentEditingController.text;

    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/update_review.php"),
        body: {
          "userid": widget.user.id.toString(),
          "Reviewid": widget.review.reviewid,
          "reviewname": ReviewName,
          "comment": Comment,
          
        }).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Insert Successfully")));
         
              
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Insert Failed")));
        }
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Insert Failed")));
        Navigator.pop(context);
      }
    });
  }
  
}