import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myutk/models/user.dart';
import 'package:myutk/models/budget.dart';
import 'package:myutk/models/tripinfo.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';
import 'package:myutk/UserScreen/UserBudget/budgetdaylistscreen.dart';

class CreateBudgetScreen extends StatefulWidget {
  final User user;
  CreateBudgetScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<CreateBudgetScreen> createState() => _CreateBudgetScreenState();
}

class _CreateBudgetScreenState extends State<CreateBudgetScreen> {
  File? _image;
  var pathAsset = "assets/images/camera1.png";
  late double screenHeight, screenWidth;
  List<String> Daylist = ["1", "2", "3"];
  String daynum = "1";
  int index = 0;
  List<Tripinfo> tripInfoList = [];
  List<String> tripNames = [];
  Map<String, String> tripIdMap = {};
  String? selectedTripName;
  String? selectedTripId;
  final TextEditingController _totalBudgetEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchTripNames();
  }

  Future<void> fetchTripNames() async {
    try {
      final response =
          await http.get(Uri.parse('${MyConfig().SERVER}/myutk/php/loadtripinfo.php'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data']['Tripinfo'];

        List<String> names = [];
        Map<String, String> idMap = {};

        data.forEach((item) {
          String tripName = item['Trip_Name'].toString();
          String tripId = item['Trip_id'].toString();
          names.add(tripName);
          idMap[tripName] = tripId;
        });

        setState(() {
          tripNames = names;
          tripIdMap = idMap;
          if (tripNames.isNotEmpty) {
            selectedTripName = tripNames[0]; // Initialize selected trip name
            selectedTripId = tripIdMap[selectedTripName!]; // Initialize selected trip ID
            loadTripInfo(); // Load trip info for the initial selected trip
          }
        });
      } else {
        throw Exception('Failed to fetch trip names');
      }
    } catch (e) {
      print('Error fetching trip names: $e');
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
                      "Let's Create Your Own Travel Budget",
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
              child: GestureDetector(
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
                              ? AssetImage(pathAsset)
                              : FileImage(_image!) as ImageProvider,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 60,
                    child: DropdownButtonFormField<String>(
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
                      onChanged: (newValue) {
                        setState(() {
                          selectedTripName = newValue;
                          selectedTripId = tripIdMap[newValue!];
                          loadTripInfo(); // Reload trip information
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
                      onChanged: (newValue) {
                        setState(() {
                          daynum = newValue!;
                        });
                      },
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
                  MinimumTotalBudgetWidget(
                    tripInfoList: tripInfoList,
                    selectedTripId: selectedTripId,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          addBudgetInfo(); // Handle submission here
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

  void addBudgetInfo() {
    String base64Image = base64Encode(_image!.readAsBytesSync());
    String totalBudget = _totalBudgetEditingController.text;
    http.post(Uri.parse("${MyConfig().SERVER}/myutk/php/addbudget.php"),
        body: {
          "userid": widget.user.id,
          "Budget_Name": selectedTripName!,
          "Budget_Day": daynum,
          "Total_Budget": totalBudget,
          "image": base64Image,
        }).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Insert Successfully")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Insert Failed")),
          );
        }
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Insert Failed")),
        );
        Navigator.pop(context);
      }
    });
  }

  void loadTripInfo() {
    if (selectedTripId == null) return;

    http.post(Uri.parse("${MyConfig().SERVER}/myutk/php/loadtripinfo.php"),
        body: {
          "tripid": selectedTripId!,
        }).then((response) {
      print(response.body);
      tripInfoList.clear();
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['status'] == "success") {
          var extractData = jsonData['data']['Tripinfo'];
          extractData.forEach((v) {
            tripInfoList.add(Tripinfo.fromJson(v));
          });
          setState(() {
            // Trigger rebuild to update MinimumTotalBudgetWidget
          });
        }
      }
    });
  }
}

class MinimumTotalBudgetWidget extends StatelessWidget {
  final List<Tripinfo> tripInfoList;
  final String? selectedTripId;

  const MinimumTotalBudgetWidget({
    Key? key,
    required this.tripInfoList,
    required this.selectedTripId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectedTripId == null) return const SizedBox();

    final tripInfo = tripInfoList.firstWhere(
      (info) => info.tripid == selectedTripId,
      orElse: () => Tripinfo(),
    );

    return Row(
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
          tripInfo.totaltripfee.toString(),
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}



