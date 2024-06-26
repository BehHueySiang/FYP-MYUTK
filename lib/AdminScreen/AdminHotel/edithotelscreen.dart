import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myutk/models/user.dart';
import 'package:myutk/models/hotel.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';


class edithotelscreen extends StatefulWidget {
  final User user;
  Hotel hotel;
   edithotelscreen({super.key, required this.user,required this.hotel});

  @override
  State<edithotelscreen> createState() => _edithotelscreenState();
}

class _edithotelscreenState extends State<edithotelscreen> {
     List<File?> _images = List.generate(3, (_) => null);
     int index = 0;
     List<Hotel> HotelList = <Hotel>[];
    
     var pathAsset = "assets/images/camera1.png";
     final _formKey = GlobalKey<FormState>();
      late double screenHeight, screenWidth, cardwitdh;
      final TextEditingController _HotelnameEditingController =
          TextEditingController();
      final TextEditingController _BookUrlEditingController =
          TextEditingController();
      final TextEditingController _HotelUrlEditingController =
          TextEditingController();
      final TextEditingController _NoteEditingController =
          TextEditingController();
      final TextEditingController _HotelBudgetEditingController =
          TextEditingController();
      String hotelrate = "1";
        List<String> Ratelist = [
          "1","2","3","4","5"
        ];
        String hotelstate = "Kedah";
        List<String> Statelist = [
          "Kedah","Pulau Pinang","Perlis"
        ];

       @override
       void initState() {
    super.initState();
    print('Debug destination: ${widget.hotel.toJson()}');
    _HotelnameEditingController.text = widget.hotel.hotelname.toString();
    _BookUrlEditingController.text = widget.hotel.bookingurl.toString();
    _NoteEditingController.text = widget.hotel.note.toString();
    _HotelBudgetEditingController.text = widget.hotel.hotelbudget.toString();
    hotelrate = widget.hotel.hotelrate.toString();
    hotelstate = widget.hotel.hotelstate.toString();
     if (!Ratelist.contains(widget.hotel.hotelrate)) {
    hotelrate = Ratelist.first;
  }

  // Check if the selected desstate is in the Statelist, if not set it to the first item
  if (!Statelist.contains(widget.hotel.hotelstate)) {
    hotelstate = Statelist.first;
  
}

 
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
                          imageUrl:  "${MyConfig().SERVER}/MyUTK/assets/Hotel/${widget.hotel.hotelid?.toString() ?? 'default'}_image.png?v=${DateTime.now().millisecondsSinceEpoch}",
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
                          imageUrl: "${MyConfig().SERVER}/MyUTK/assets/Hotel/${widget.hotel.hotelid?.toString() ?? 'default'}_image2.png?v=${DateTime.now().millisecondsSinceEpoch}",
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
                          imageUrl: "${MyConfig().SERVER}/MyUTK/assets/Hotel/${widget.hotel.hotelid?.toString() ?? 'default'}_image3.png?v=${DateTime.now().millisecondsSinceEpoch}",
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
                                      ? "Hotel name must be longer than 3"
                                      : null,
                              onFieldSubmitted: (v) {},
                              controller: _HotelnameEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Hotel Name',
                                  labelStyle: TextStyle(color: Colors.amber),
                                   focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),)),),
                                    const SizedBox(height: 20,),
                    TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (val) =>
                                  val!.isEmpty || (val.length < 3)
                                      ? ""
                                      : null,
                              onFieldSubmitted: (v) {},
                              controller: _BookUrlEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Booking Link',
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
                              controller: _NoteEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Note',
                                  labelStyle: TextStyle(color: Colors.amber),
                                   focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),)),),
                               const SizedBox(height: 20,),
                  //DesState
                  SizedBox(
                              height: 60,
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  labelText: 'State',
                                  labelStyle: TextStyle(color: Colors.amber),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),
                                ),
                                value: hotelstate,
                                onChanged: (newValue) {
                                  setState(() {
                                    hotelstate = newValue!;
                                    print(hotelstate);
                                  });
                                },
                                items: Statelist.map((hotelstate) {
                                  return DropdownMenuItem(
                                    value: hotelstate,
                                    child: Text(
                                      hotelstate,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                             const SizedBox(height: 20,),
                    //DesRate
                  SizedBox(
                              height: 60,
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Rate',
                                  labelStyle: TextStyle(color: Colors.amber),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),
                                ),
                                value: hotelrate,
                                onChanged: (newValue) {
                                  setState(() {
                                    hotelrate = newValue!;
                                    print(hotelrate);
                                  });
                                },
                                items: Ratelist.map((hotelrate) {
                                  return DropdownMenuItem(
                                    value: hotelrate,
                                    child: Text(
                                      hotelrate,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 20,),
                    Row(
                    children: [
                      Flexible(
                          flex: 3,
                          child:  TextFormField(
                              textInputAction: TextInputAction.next,
                             
                              controller: _HotelBudgetEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Estimate Budget Per/Person',
                                  labelStyle: TextStyle(color: Colors.amber),
                                   focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),)),),
                        ),const SizedBox(width: 20,),
                        Flexible( 
                          flex: 2,
                   child: SizedBox(
                      width: screenWidth / 1.2,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            updatehotel();
                          },
                          child: const Text("Submit",style: TextStyle(color: Colors.black), ),
                          style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),)),))
                                    ]
                    ),
                    const SizedBox(height: 30,),
                  ],
                ),
              ),
            ),]),),);
    
  }


  //////////////
void updatehotel() {
    String HotelName = _HotelnameEditingController.text;
    String BookUrl = _BookUrlEditingController.text;
    String Note = _NoteEditingController.text;
    String HotelBudget = _HotelBudgetEditingController.text;

    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/update_hotel.php"),
        body: {
          "userid": widget.user.id.toString(),
          "HotelId": widget.hotel.hotelid,
          "hotelname": HotelName,
          "bookingurl": BookUrl,
          "note": Note,
          "hotelbudget": HotelBudget,
          "hotelstate": hotelstate,
          "hotelrate": hotelrate,
          
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