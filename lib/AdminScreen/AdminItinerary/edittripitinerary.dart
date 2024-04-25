import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myutk/AdminScreen/AdminItinerary/itinerarylistdetailscreen.dart';
import 'package:myutk/models/tripinfo.dart';
import 'package:myutk/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';
import 'package:cached_network_image/cached_network_image.dart';


class EditTripItineraryScreen extends StatefulWidget {
  final User user;
  final Tripinfo tripinfo;
  EditTripItineraryScreen({super.key, required this.user,required this.tripinfo});

  @override
  State<EditTripItineraryScreen> createState() => _EditTripItineraryScreenState();
}

class _EditTripItineraryScreenState extends State<EditTripItineraryScreen> {
  File? _image;
  var pathAsset = "assets/images/camera1.png";
  late double screenHeight, screenWidth ;
  int index = 0;
  List<String> triptypelist = ["One state Trip", "Two state Trip", "Three state Trip",];
  String triptype = "One state Trip";
  List<String> statelist = ["Kedah", "Pulau Penang", "Perlis","Kedah + Perlis","Kedah + Pulau Penang","Pulau Penang + Perlis","Kedah + Pulau Penang + Perlis",];
  String state = "Kedah";
  List<String> Daylist = ["1", "2", "3"];
  String daynum = "1";
  List<Tripinfo> Tripinfolist = <Tripinfo>[];
  
  final TextEditingController _TripNameEditingController =
          TextEditingController();


 @override
  void initState() {
    super.initState();
      loadtripinfo();
    
    _TripNameEditingController.text = widget.tripinfo.tripname.toString();
    daynum = widget.tripinfo.tripday.toString();
    triptype = widget.tripinfo.triptype.toString();
    state = widget.tripinfo.tripstate.toString();
  }


  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              color: const Color.fromARGB(255, 239, 219, 157),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Edit Trip Itinerary",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
         SizedBox(
           height: screenHeight / 3, 
           child:  GestureDetector(
              onTap: () {
                _selectFromCamera();
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                child: Card(
                  child: Container(
                      width: screenWidth,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                        image: _image == null
                        ? NetworkImage(MyConfig().SERVER+"/MyUTK/assets/Itinerary/"+widget.tripinfo.tripid.toString() +"_image.png")
                        : FileImage(_image!) as ImageProvider,
                        fit: BoxFit.fill,
                        ),
                        )
                      ),
                ),
              ),
            ),),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  TextFormField(
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (v) {},
                              controller: _TripNameEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Trip Name',
                                  labelStyle: TextStyle(color: Colors.amber),
                                   focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),)),),
                                    const SizedBox(height: 20,),
                  SizedBox(
                    height: 60,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: 'Trip Type',
                        labelStyle: TextStyle(color: Colors.amber),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ),
                      ),
                      value: triptype,
                      onChanged: (newValue) {
                        setState(() {
                          triptype = newValue!;
                          print(triptype);
                        });
                      },
                      items: triptypelist.map((triptype) {
                        return DropdownMenuItem(
                          value: triptype,
                          child: Text(triptype),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 60,
                   child:  DropdownButtonFormField(
                          decoration: const InputDecoration(
                            labelText: 'Days',
                            labelStyle: TextStyle(color: Colors.amber),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0),
                            ),
                          ),
                          value: daynum,
                          onChanged: null, // Set onChanged to null to disable the dropdown
                          items: Daylist.map((daynum) {
                            return DropdownMenuItem(
                              value: daynum,
                              child: Text(daynum),
                            );
                          }).toList(),
                        ),
                  ),
                  const SizedBox(height: 20),
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
                      value: state,
                      onChanged: (newValue) {
                        setState(() {
                          state = newValue!;
                          print(state);
                        });
                      },
                      items: statelist.map((state) {
                        return DropdownMenuItem(
                          value: state,
                          child: Text(state),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                   
                Row(
                    mainAxisAlignment: MainAxisAlignment.end, // Aligns children to the start (left) of the row
                    children: [
                      ElevatedButton(
                        onPressed: () {
                            updatetripinfo();

                        },
                        child: const Text(
                          "Update",
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
                        ),
                      ),
                      // Add other widgets here if needed
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
 Future<void> _selectFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1200,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      cropImage();
    } else {
      print('No image selected.');
    }
  }

  Future<void> cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: _image!.path,
      aspectRatioPresets: [
        // CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        // CropAspectRatioPreset.original,
        //CropAspectRatioPreset.ratio4x3,
        // CropAspectRatioPreset.ratio16x9
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
      _image = imageFile;
      int? sizeInBytes = _image?.lengthSync();
      double sizeInMb = sizeInBytes! / (1024 * 1024);
      print(sizeInMb);

      setState(() {});
    }
  }
  void loadtripinfo() {
    if (widget.user.id == "na") {
      setState(() {
        // titlecenter = "Unregistered User";
      });
      return;
    }

    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/loadtripinfo.php"),
        body: {
          "userid": widget.user.id,
         
          }).then((response) {
      print(response.body);
      //log(response.body);
      Tripinfolist.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          
       
          var extractdata = jsondata['data'];
          extractdata['Tripinfo'].forEach((v) {
            Tripinfolist.add(Tripinfo.fromJson(v));
             
          Tripinfolist.forEach((element) {
           
          });

          });
          print(Tripinfolist[0].tripname);
        }
        setState(() {});
      }
    });
  }
  void updatetripinfo() {
    String tripname = _TripNameEditingController.text;
    String base64Image = base64Encode(_image!.readAsBytesSync());


    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/updatetripinfo.php"),
        body: {
          "userid": widget.user.id.toString(),
          "Tripid": widget.tripinfo.tripid.toString(),
          "Trip_Name": tripname,
          "Trip_State": state,
          "Trip_Type": triptype,
          "Trip_Day": daynum,
          "image": base64Image
          
          
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