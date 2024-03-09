import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myutk/models/user.dart';
import 'package:myutk/models/destination.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';


class adddestinationscreen extends StatefulWidget {
  final User user;
  final Des destinationinfo;
  const adddestinationscreen({super.key, required this.user, required this.destinationinfo});

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
      final TextEditingController _UrlEditingController =
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
      String DesRate = "1";
        List<String> Ratelist = [
          "1","2","3","4","5","6","7","8","9","10",
        ];
        String DesState = "Kedah";
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
            //////////////////////////
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
                              textInputAction: TextInputAction.next,
                              validator: (val) =>
                                  val!.isEmpty || (val.length < 3)
                                      ? ""
                                      : null,
                              onFieldSubmitted: (v) {},
                              controller: _UrlEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Redirect Link',
                                  labelStyle: TextStyle(color: Colors.amber),
                                   focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),)),),
                                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        Flexible(
                          flex: 5,
                          child: TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (val) =>
                                  val!.isEmpty || (val.length < 3)
                                      ? ""
                                      : null,
                              onFieldSubmitted: (v) {},
                              controller: _OpenTimeEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Open Time',
                                  labelStyle: TextStyle(color: Colors.amber),
                                   focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),)),),
                        ),const SizedBox(width: 20,),
                        Flexible(
                          flex: 5,
                          child:TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (val) =>
                                  val!.isEmpty || (val.length < 3)
                                      ? ""
                                      : null,
                              onFieldSubmitted: (v) {},
                              controller: _CloseTimeEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Close Time',
                                  labelStyle: TextStyle(color: Colors.amber),
                                   focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),)),),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                  TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (val) =>
                                  val!.isEmpty || (val.length < 3)
                                      ? ""
                                      : null,
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
                              validator: (val) =>
                                  val!.isEmpty || (val.length < 3)
                                      ? ""
                                      : null,
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
                              validator: (val) =>
                                  val!.isEmpty || (val.length < 3)
                                      ? ""
                                      : null,
                                    
                              onFieldSubmitted: (v) {},
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
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),)),))]
                    ),
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
    String Url = _UrlEditingController.text;
    String OpenTime = _OpenTimeEditingController.text;
    String CloseTime = _CloseTimeEditingController.text;
    String SuggestTime = _SuggestTimeEditingController.text;
    String Activity = _ActivityEditingController.text;
    String DesBudget = _ActivityEditingController.text;

    String base64Image = base64Encode(_images[0]!.readAsBytesSync());
    String base64Image1 = base64Encode(_images[1]!.readAsBytesSync());
    String base64Image2 = base64Encode(_images[2]!.readAsBytesSync());
    http.post(Uri.parse("${MyConfig().SERVER}/myutk/php/insert_destination.php"),
        body: {
          "userid": widget.user.id.toString(),
          "DesName": DesName,
          "Url": Url,
          "OpenTime": OpenTime,
          "CloseTime": CloseTime,
          "SuggestTime": SuggestTime,
          "Activity": Activity,
          "DesBudget": DesBudget,
          "DesState": DesState,
          "locality": DesRate,
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