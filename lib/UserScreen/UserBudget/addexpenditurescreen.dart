import 'dart:convert';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:myutk/models/budget.dart';
import 'package:myutk/models/destination.dart';
import 'package:myutk/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';
import 'package:path_provider/path_provider.dart';

class AddExpenditureScreen extends StatefulWidget {
  final User user;
  //final Des destination;
  final String budgetinfo;
  //final double totaltripfee;

  const AddExpenditureScreen(
      {super.key, required this.user, required this.budgetinfo});

  @override
  State<AddExpenditureScreen> createState() => _AddExpenditureScreenState();
}

class _AddExpenditureScreenState extends State<AddExpenditureScreen> {
  File? _image;
  var pathAsset = "assets/images/camera1.png";

  late double screenHeight, screenWidth;
  TextEditingController _searchController = TextEditingController();
  late int axiscount = 2;
  late List<Widget> tabchildren;
  String maintitle = "Adm Destination List";
  int numofpage = 1, curpage = 1, numberofresult = 0, index = 0;
  List<Des> Deslist = <Des>[];
  List<Budgetinfo> Budgetinfolist = <Budgetinfo>[];
  String expendtype = "Destination";
  List<String> expendtypelist = [
    "Destination",
    "Food",
    "Accommodation",
    "Souviner",
    "other"
  ];
  String Budgetday = "1";
  List<String> bdaylist = ["1", "2", "3"];

  final TextEditingController _ExpendAmountEditingController =
      TextEditingController();
  final TextEditingController _ExpendNameEditingController =
      TextEditingController();

  var color;

  @override
  void initState() {
    super.initState();
    loadbudgetinfo(index);
    print("Add Expenditure");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      axiscount = 3;
    } else {
      axiscount = 1;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          maintitle,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.amber[200],
      ),
      backgroundColor: Colors.amber[50],
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            width: screenWidth,
            alignment: Alignment.center,
            color: Color.fromARGB(255, 239, 219, 157),
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Add Expenditure',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
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
                      )),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60,
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: 'Expenditure Type',
                labelStyle: TextStyle(color: Colors.amber),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2.0),
                ),
              ),
              value: expendtype,
              onChanged: (newValue) {
                setState(() {
                  expendtype = newValue!;
                  print(expendtype);
                });
              },
              items: expendtypelist.map((expendtype) {
                return DropdownMenuItem(
                  value: expendtype,
                  child: Text(expendtype),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (v) {},
            controller: _ExpendNameEditingController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                labelText: 'Expenditure Name',
                labelStyle: TextStyle(color: Colors.amber),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2.0),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(height: 20),
          TextFormField(
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (v) {},
            controller: _ExpendAmountEditingController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                labelText: 'Expenditure Amount',
                labelStyle: TextStyle(color: Colors.amber),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2.0),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment
                .end, // Aligns children to the start (left) of the row
            children: [
              ElevatedButton(
                onPressed: () {
                  _showAddToTripDialog(index);
                },
                child: const Text(
                  "Insert",
                  style: TextStyle(color: Colors.black),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.amber),
                ),
              ),
              // Add other widgets here if needed
            ],
          )
        ]),
      ),
    );
  }

  void _showAddToTripDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add to Budget"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Please select day you want to add this expense to? "),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 60,
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: 'Days',
                      labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0),
                      ),
                    ),
                    value: Budgetday,
                    onChanged: (newValue) {
                      setState(() {
                        Budgetday = newValue!;
                        print(Budgetday);
                      });
                    },
                    items: bdaylist.map((Budgetday) {
                      return DropdownMenuItem(
                        value: Budgetday,
                        child: Text(
                          Budgetday,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                if (_image == null) {
                  _downloadDefaultImage().then((file) {
                    _image = file;
                    addToBudget(index, _image);
                    updatetripinfo();
                  });
                } else {
                  _image;
                  addToBudget(index, _image);
                  updatetripinfo();
                }
              },
            ),
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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

  void loadbudgetinfo(int index) {
    if (widget.user.id == "na") {
      setState(() {
        // titlecenter = "Unregistered User";
      });
      return;
    }

    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/loadbudgetinfo.php"),
        body: {
          "userid": widget.user.id.toString(),
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

            Budgetinfolist.forEach((element) {});
          });
          print(Budgetinfolist[0].budgetname);
        }
        if (mounted) {
          // Check if the widget is still mounted before calling setState()
          setState(() {});
        }
      }
    });
  }

  void addToBudget(int index, File? _image) {
    String base64Image = base64Encode(_image!.readAsBytesSync());
    String expendname = _ExpendNameEditingController.text;
    String expendamount = _ExpendAmountEditingController.text;

    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/addtobudgetday.php"),
        body: {
          "userid": widget.user.id,
          "Budget_id": widget.budgetinfo,
          "Bday_Name": Budgetday,
          "Expend_Type": expendtype,
          "Expend_Name": expendname,
          "Expend_Amount": expendamount,
          "image": base64Image
        }).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Success")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Failed")));
        }
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Failed")));
        Navigator.pop(context);
      }
    });
  }

  void updatetripinfo() {
    String expendamount = _ExpendAmountEditingController.text;
    http.post(
        Uri.parse("${MyConfig().SERVER}/MyUTK/php/updatetotalexpenditure.php"),
        body: {
          "Budgetid": widget.budgetinfo,
          "Total_Expenditure": expendamount,
          "action": 'add',
        }).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Insert Successfully")));
          loadbudgetinfo(index);
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

  Future<File> _downloadDefaultImage() async {
    final url = 'https://www.hsbehopper.com/MyUTK/assets/Default_Image.png';
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/Default_Image.png');
    await file.writeAsBytes(bytes);
    return file;
  }
}
