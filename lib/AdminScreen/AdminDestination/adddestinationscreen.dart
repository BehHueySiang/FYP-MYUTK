import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myutk/models/user.dart';
import 'package:myutk/models/destination.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';
import 'package:intl/intl.dart'; // Import DateFormat for time parsing



class adddestinationscreen extends StatefulWidget {
  final User user;
  
  const adddestinationscreen({super.key, required this.user});

  @override
  State<adddestinationscreen> createState() => _adddestinationscreenState();
}


class _adddestinationscreenState extends State<adddestinationscreen> {
     List<File?> _images = List.generate(3, (_) => null);
     int index = 0;
     List<Des> DesList = <Des>[];
    
     var pathAsset = "assets/images/camera1.png";
     final _formKey = GlobalKey<FormState>();
      late double screenHeight, screenWidth, cardwitdh;
      final TextEditingController _DesnameEditingController =
          TextEditingController();
      
      final TextEditingController _OpenTimeEditingController =
          TextEditingController();
      final TextEditingController _CloseTimeEditingController =
          TextEditingController();
      final TextEditingController _SuggestTimeEditingController =
          TextEditingController();
      final TextEditingController _ActivityEditingController =
          TextEditingController();
      final TextEditingController _DesBudgetEditingController =
          TextEditingController();
      final TextEditingController _latitudeController = TextEditingController();
      final TextEditingController _longitudeController = TextEditingController();
      String DesRate = "1";
        List<String> Ratelist = [
          "1","2","3","4","5","6","7","8","9","10",
        ];
        String DesState = "Kedah";
        List<String> Statelist = [
          "Kedah","Pulau Pinang","Perlis"
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
                                      ? "Destination name must be longer than 3"
                                      : null,
                              onFieldSubmitted: (v) {},
                              controller: _DesnameEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Destination Name',
                                  labelStyle: TextStyle(color: Colors.amber),
                                   focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),)),),
                                    const SizedBox(height: 20,),
                                  TextFormField(
                                          controller: _latitudeController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            labelText: 'Latitude',
                                            labelStyle: TextStyle(color: Colors.amber),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(width: 2.0),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(width: 2.0),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        TextFormField(
                                          controller: _longitudeController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            labelText: 'Longitude',
                                            labelStyle: TextStyle(color: Colors.amber),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(width: 2.0),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(width: 2.0),
                                            ),
                                          ),
                                        ),
                                    const SizedBox(height: 20,),
                      Row(
                            children: [
                              Flexible(
                                flex: 5,
                                child: TextFormField(
                                  controller: _OpenTimeEditingController,
                                  onTap: () => _selectTime(_OpenTimeEditingController),
                                  validator: (value) => _validateTimeOrder(
                                    value,
                                    _CloseTimeEditingController.text,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Open Time',
                                     labelStyle: TextStyle(color: Colors.amber),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20.0),
                              Flexible(
                                flex: 5,
                                child: TextFormField(
                                  controller: _CloseTimeEditingController,
                                  onTap: () => _selectTime(_CloseTimeEditingController),
                                  validator: (value) => _validateTimeOrder(
                                    _OpenTimeEditingController.text,
                                    value,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Close Time',
                                     labelStyle: TextStyle(color: Colors.amber),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(height: 20,),
                  TextFormField(
                              textInputAction: TextInputAction.next,
                           
                                  
                              onFieldSubmitted: (v) {},
                              controller: _SuggestTimeEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Suggest Time',
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
                              controller: _ActivityEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Activities',
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
                                value: DesState,
                                onChanged: (newValue) {
                                  setState(() {
                                    DesState = newValue!;
                                    print(DesState);
                                  });
                                },
                                items: Statelist.map((DesState) {
                                  return DropdownMenuItem(
                                    value: DesState,
                                    child: Text(
                                      DesState,
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
                                value: DesRate,
                                onChanged: (newValue) {
                                  setState(() {
                                    DesRate = newValue!;
                                    print(DesRate);
                                  });
                                },
                                items: Ratelist.map((DesRate) {
                                  return DropdownMenuItem(
                                    value: DesRate,
                                    child: Text(
                                      DesRate,
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
                             
                              controller: _DesBudgetEditingController,
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
            "Insert your Destination?",
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
                insertDestination();
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
void insertDestination() {
    String DesName = _DesnameEditingController.text;
    String OpenTime = _OpenTimeEditingController.text;
    String CloseTime = _CloseTimeEditingController.text;
    String SuggestTime = _SuggestTimeEditingController.text;
    String Activity = _ActivityEditingController.text;
    String DesBudget = _DesBudgetEditingController.text;
    String Latitude = _latitudeController.text;
    String Longtitude = _longitudeController.text;
    String base64Image = base64Encode(_images[0]!.readAsBytesSync());
    String base64Image1 = base64Encode(_images[1]!.readAsBytesSync());
    String base64Image2 = base64Encode(_images[2]!.readAsBytesSync());
    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/insert_des.php"),
        body: {
          "userid": widget.user.id.toString(),
          "desname": DesName,
          "opentime": OpenTime,
          "closetime": CloseTime,
          "suggesttime": SuggestTime,
          "activity": Activity,
          "desbudget": DesBudget,
          "desstate": DesState,
          "desrate": DesRate,
          "latitude": Latitude,
          "longtitude": Longtitude,
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
   Future<void> _selectTime(TextEditingController controller) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        controller.text = pickedTime.format(context);
      });
    }
  }

  String? _validateTimeOrder(String? openTime, String? closeTime) {
    if (openTime == null || closeTime == null) {
      return null; // Skip validation if times are not selected
    }

    // Parse times into DateTime objects for comparison
    final DateFormat formatter = DateFormat('hh:mm a');
    final DateTime openDateTime = formatter.parse(openTime);
    final DateTime closeDateTime = formatter.parse(closeTime);

    if (closeDateTime.isBefore(openDateTime)) {
      return 'Close time cannot be earlier than open time';
    }

    return null; // Validation passed
  }
}