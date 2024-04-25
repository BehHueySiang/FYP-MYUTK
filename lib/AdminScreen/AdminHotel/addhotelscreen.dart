import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myutk/models/user.dart';
import 'package:myutk/models/hotel.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';


class addhotelscreen extends StatefulWidget {
  final User user;
  
  const addhotelscreen({super.key, required this.user});

  @override
  State<addhotelscreen> createState() => _addhotelscreenState();
}

class _addhotelscreenState extends State<addhotelscreen> {
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
      String HotelRate = "1";
        List<String> Ratelist = [
          "1","2","3","4","5","6","7","8","9","10",
        ];
        String HotelState = "Kedah";
        List<String> Statelist = [
          "Kedah","Pulau Penang","Perlis"
        ];

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
      child: Column(children: [ SizedBox(
                          height: screenHeight / 3, 
                      child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: List.generate(3, (index) {
                      return GestureDetector(
                         onTap: () {
                         _selectFromCamera(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                            child: Card(
                              child: Container(
                                  width: screenWidth,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: _images[index] == null
                                          ? AssetImage(pathAsset)
                                          : FileImage(_images[index]!) as ImageProvider,
                                      fit: BoxFit.contain,
                        ),)),),), ); }))
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
                              validator: (val) =>
                                  val!.isEmpty || (val.length < 3)
                                      ? ""
                                      : null,
                              onFieldSubmitted: (v) {},
                              controller: _HotelUrlEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Hotel Direction',
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
                                value: HotelState,
                                onChanged: (newValue) {
                                  setState(() {
                                    HotelState = newValue!;
                                    print(HotelState);
                                  });
                                },
                                items: Statelist.map((HotelState) {
                                  return DropdownMenuItem(
                                    value: HotelState,
                                    child: Text(
                                      HotelState,
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
                                value: HotelRate,
                                onChanged: (newValue) {
                                  setState(() {
                                    HotelRate = newValue!;
                                    print(HotelRate);
                                  });
                                },
                                items: Ratelist.map((HotelRate) {
                                  return DropdownMenuItem(
                                    value: HotelRate,
                                    child: Text(
                                      HotelRate,
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
                            insertDialog();
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
Future<void> _selectFromCamera(index) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1200,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      _images[index] = File(pickedFile.path);
      cropImage(index);
    } else {
      print('No image selected.');
    }
  }
 Future<void> cropImage(index) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: _images[index]!.path,
      aspectRatioPresets: [
        
        CropAspectRatioPreset.ratio3x2,
        
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.ratio3x2,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      File imageFile = File(croppedFile.path);
      _images[index] = imageFile;
      int? sizeInBytes = _images[index]?.lengthSync();
      double sizeInMb = sizeInBytes! / (1024 * 1024);
      print(sizeInMb);

      setState(() {});
    }
  }
 void insertDialog() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Check your input")));
      return;
    }
    if (_images[index] == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please take picture")));
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Insert this hotel?",
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
                inserthotel();
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
void inserthotel() {
    String HotelName = _HotelnameEditingController.text;
    String BookUrl = _BookUrlEditingController.text;
    String HotelUrl = _HotelUrlEditingController.text;
    String Note = _NoteEditingController.text;
    String HotelBudget = _HotelBudgetEditingController.text;

    String base64Image = base64Encode(_images[0]!.readAsBytesSync());
    String base64Image1 = base64Encode(_images[1]!.readAsBytesSync());
    String base64Image2 = base64Encode(_images[2]!.readAsBytesSync());
    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/insert_hotel.php"),
        body: {
          "userid": widget.user.id.toString(),
          "hotelname": HotelName,
          "bookurl": BookUrl,
          "hotelurl": HotelUrl,
          "note": Note,
          "hotelbudget": HotelBudget,
          "hotelstate": HotelState,
          "hotelrate": HotelRate,
          "image": base64Image,
          "image1": base64Image1,
          "image2": base64Image2
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