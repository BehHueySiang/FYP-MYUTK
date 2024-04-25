import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myutk/models/user.dart';
import 'package:myutk/models/budget.dart';
import 'package:myutk/models/tripinfo.dart';
import 'package:myutk/models/useritinerary.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';


class EditBudgetScreen extends StatefulWidget {
  final User user;
  final Budgetinfo budgetinfo;
  EditBudgetScreen({Key? key, required this.user, required this.budgetinfo}) : super(key: key);

  @override
  State<EditBudgetScreen> createState() => _EditBudgetScreenState();
}

class _EditBudgetScreenState extends State<EditBudgetScreen> {
  File? _image;
  var pathAsset = "assets/images/camera1.png";
  late double screenHeight, screenWidth;
  List<String> Daylist = ["1", "2", "3"];
  String daynum = "1";
  int index = 0;
  List<Usertrip> usertripList = [];
  List<String> tripNames = [];
  Map<String, String> tripIdMap = {};
  String? selectedTripName;
  String? selectedTripId;
  String? newselectedname;
  final TextEditingController _totalBudgetEditingController =
  TextEditingController();
  String totalexpenditure = "0";
  List<Budgetinfo> Budgetinfolist = <Budgetinfo>[];

  @override
  void initState() {
    super.initState();
     selectedTripName = widget.budgetinfo.budgetname.toString();
    daynum = widget.budgetinfo.budgetday.toString();
    _totalBudgetEditingController.text = widget.budgetinfo.totalbudget.toString();

    
    fetchTripData();
  }
  Future<void> fetchTripData() async {
    try {
      final response = await http.get(Uri.parse('${MyConfig().SERVER}/MyUTK/php/loaduseritinerary.php'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data']['Usertrip'];
        List<String> names = [];
        Map<String, String> idMap = {};
        data.forEach((item) {
          String tripName = item['Trip_Name'].toString();
          String tripId = item['Utrip_id'].toString();
          names.add(tripName);
          idMap[tripName] = tripId;
          if (tripName == selectedTripName) {
            selectedTripId = tripId;
          }
        });
        setState(() {
          tripNames = names;
          tripIdMap = idMap;
          if (selectedTripId != null) {
            loadTripInfo(selectedTripId!);
          }
        });
      } else {
        throw Exception('Failed to fetch trip data');
      }
    } catch (e) {
      print('Error fetching trip data: $e');
    }
  }
 Future<void> loadTripInfo(String tripId) async {
    try {
      final response = await http.post(
        Uri.parse("${MyConfig().SERVER}/MyUTK/php/loaduseritinerary.php"),
        body: {"tripid": tripId},
      );

      if (response.statusCode == 200) {
        usertripList.clear();
        var jsonData = jsonDecode(response.body);
        if (jsonData['status'] == "success") {
          var extractData = jsonData['data']['Usertrip'];
          extractData.forEach((v) {
            usertripList.add(Usertrip.fromJson(v));
          });
        }
        setState(() {});
      } else {
        throw Exception('Failed to load trip info');
      }
    } catch (e) {
      print('Error loading trip info: $e');
    }
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
            const SizedBox(height: 20),
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
                      "Make Your Budget Plan Better",
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
                        ? NetworkImage(MyConfig().SERVER+"/MyUTK/assets/Budget/"+widget.budgetinfo.budgetid.toString() +"_image.png")
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
                  SizedBox(
                    height: 60,
                    child:  DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Budget Title',
                  labelStyle: TextStyle(color: Colors.amber),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0),
                  ),
                ),
                value: selectedTripName,
                onChanged: (newSelectedTripName) {
                  setState(() {
                    selectedTripName = newSelectedTripName!;
                    selectedTripId = tripIdMap[selectedTripName];
                    loadTripInfo(selectedTripId!);
                  });
                },
                items: tripNames.map((tripName) {
                  return DropdownMenuItem<String>(
                    value: tripName,
                    child: Text(tripName),
                  );
                }).toList(),
              ), 
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 60,
                    child: DropdownButtonFormField<String>(
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
                      onChanged: null,
                      items: Daylist.map((daynum) {
                        return DropdownMenuItem<String>(
                          value: daynum,
                          child: Text(daynum),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (v) {},
                    controller: _totalBudgetEditingController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Total Budget',
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
                    if (selectedTripId != null)
              MinimumTotalBudgetWidget(
                usertripList: usertripList,
                selectedTripId: selectedTripId,
              ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          UpdateBudgetInfo(); // Handle submission here
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.amber),
                        ),
                      ),
                    ],
                  ),
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
        CropAspectRatioPreset.ratio3x2,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.ratio3x2,
          lockAspectRatio: true,
        ),
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

  void loadusertrip() {
    if (selectedTripId == null) return;
    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/loaduseritinerary.php"),
        body: {
          "tripid": selectedTripId!,
        }).then((response) {
      print(response.body);
      usertripList.clear();
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['status'] == "success") {
          var extractData = jsonData['data']['Usertrip'];
          extractData.forEach((v) {
            usertripList.add(Usertrip.fromJson(v));
          });
          setState(() {
            // Trigger rebuild to update MinimumTotalBudgetWidget
          });
        }
      }
    });
  }

  void loadbudgetinfo() {
    if (widget.user.id == "na") {
      setState(() {
        // titlecenter = "Unregistered User";
      });
      return;
    }
    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/loadbudgetinfo.php"),
        body: {
       "userid": widget.user.id,

          }).then((response) {
      print(response.body);
      //log(response.body);
      Budgetinfolist.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['Budgetinfo'].forEach((v) {
            Budgetinfolist.add(Budgetinfo.fromJson(v)); 
            Budgetinfolist.forEach((element) {
          });
          });
          print(Budgetinfolist[0].budgetname);
        }
        setState(() {});
      }
    });
  }
void UpdateBudgetInfo() async {
  String newtotalbudget = _totalBudgetEditingController.text;
  String base64Image = _image != null ? base64Encode(_image!.readAsBytesSync()) : '';

  // Create a multipart request
  var request = http.MultipartRequest(
    'POST',
    Uri.parse("${MyConfig().SERVER}/MyUTK/php/updatebudgetplan.php"),
  );

  // Attach form fields
  request.fields['userid'] = widget.user.id.toString();
  request.fields['Budgetid'] = widget.budgetinfo.budgetid.toString();
  request.fields['Total_Budget'] = newtotalbudget;

  // Attach image file if available
  if (_image != null) {
    request.files.add(
      http.MultipartFile(
        'image',
        _image!.readAsBytes().asStream(),
        _image!.lengthSync(),
        filename: 'budget_image.png', // Provide a filename for the server
      ),
    );
  }

  try {
    var response = await request.send();
    if (response.statusCode == 200) {
      // Handle successful response
      var jsonData = await response.stream.bytesToString();
      var parsedData = jsonDecode(jsonData);
      if (parsedData['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Update Successful")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Update Failed")),
        );
      }
      Navigator.pop(context); // Navigate back after update
    } else {
      // Handle HTTP error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Update Failed")),
      );
      Navigator.pop(context); // Navigate back on failure
    }
  } catch (error) {
    print("Error updating budget: $error");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Update Failed")),
    );
    Navigator.pop(context); // Navigate back on error
  }
}

}


  class MinimumTotalBudgetWidget extends StatelessWidget {
  final List<Usertrip> usertripList;
  final String? selectedTripId;

  const MinimumTotalBudgetWidget({
    Key? key,
    required this.usertripList,
    required this.selectedTripId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectedTripId == null) return SizedBox();

    final usertrip = usertripList.firstWhere(
      (info) => info.utripid == selectedTripId,
      orElse: () => Usertrip(),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Text(
            'Minimum Total Budget: ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            usertrip.totaltripfee.toString(),
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

  
