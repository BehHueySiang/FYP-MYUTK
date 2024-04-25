import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myutk/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;
  //
 
  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

   int index = 0;
    final TextEditingController _nameEditingController = TextEditingController();
    final TextEditingController _emailEditingController = TextEditingController();
    final TextEditingController _phoneEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final TextEditingController _pass2EditingController = TextEditingController();
   final TextEditingController _useraddressEditingController = TextEditingController();
  
  final _formKey = GlobalKey<FormState>();
  late double screenHeight, screenWidth, cardwitdh;

  @override
  void initState() {
    super.initState();
    _nameEditingController.text = widget.user.name.toString();
    _emailEditingController.text = widget.user.email.toString();
    _phoneEditingController.text = widget.user.phone.toString();
    _passEditingController.text =widget.user.password.toString();
    _pass2EditingController.text =widget.user.password.toString();
    _useraddressEditingController.text =widget.user.useraddress.toString();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile", style: TextStyle(color: Colors.black),),
     backgroundColor: Colors.amber[200],
      foregroundColor: Colors.amber[800],
      ),
      backgroundColor: Colors.amber[50],
      body: SingleChildScrollView(child:
             Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 8,
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Column(children: [
                  Form(
                    key: _formKey,
                    child: Column(children: [
                      TextFormField(
                          controller: _nameEditingController,
                          validator: (val) => val!.isEmpty || (val.length < 5)
                              ? "name must be longer than 5"
                              : null,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              labelText: 'Name',
                              labelStyle: TextStyle(color: Colors.amber),
                              icon: Icon(Icons.person,color: Colors.amber),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2.0),
                              ))),
                      TextFormField(
                          keyboardType: TextInputType.phone,
                          validator: (val) => val!.isEmpty || (val.length < 10)
                              ? "phone must be longer or equal than 10"
                              : null,
                          controller: _phoneEditingController,
                          decoration: const InputDecoration(
                              labelText: 'Phone',
                              labelStyle: TextStyle(color: Colors.amber),
                              icon: Icon(Icons.phone,color: Colors.amber),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2.0),
                              ))),
                      TextFormField(
                          controller: _emailEditingController,
                          validator: (val) => val!.isEmpty ||
                                  !val.contains("@") ||
                                  !val.contains(".")
                              ? "enter a valid email"
                              : null,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              enabled: false,
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.amber),
                              icon: Icon(Icons.email,color: Colors.amber),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2.0),
                              ))),
                      TextFormField(
                          controller: _passEditingController,
                          validator: (val) => val!.isEmpty || (val.length < 5)
                              ? "password must be longer than 5"
                              : null,
                          obscureText: true,
                          decoration: const InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.amber),
                              icon: Icon(Icons.lock,color: Colors.amber),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2.0),
                              ))),
                      TextFormField(
                          controller: _pass2EditingController,
                          validator: (val) => val!.isEmpty || (val.length < 5)
                              ? "password must be longer than 5"
                              : null,
                          obscureText: true,
                          decoration: const InputDecoration(
                              labelText: 'Re-enter password',
                              labelStyle: TextStyle(color: Colors.amber),
                              icon: Icon(Icons.lock,color: Colors.amber),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2.0),
                              ))),
                  TextFormField(
                          controller: _useraddressEditingController,
                        
                          decoration: const InputDecoration(
                              labelText: 'Address',
                              labelStyle: TextStyle(color: Colors.amber),
                              icon: Icon(Icons.email,color: Colors.amber),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2.0),
                              ))),
        
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: screenWidth / 1.2,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            updateDialog();
                          },
                          child: const Text("Update Profile",style: TextStyle(color: Colors.black), ),
                          style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),)),
                    )
                  ],
                ),
              )
            ]
          )
        )
      )
    ),
  
));
         
  }
   void updateDialog() {
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
            "Are you sure want to update profile?",
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
                
                updateprofile();
               
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

  void updateprofile() {
    String name = _nameEditingController.text;
    String phone = _phoneEditingController.text;
    String passa = _passEditingController.text;
    String useraddress = _useraddressEditingController.text;
   

    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/updateprofile.php"),
        body: {
          "userid": widget.user.id,
          "name": name,
          "email": widget.user.email,
          "phone": phone,
          "password": passa,
           "useraddress": useraddress
          
        }).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Update Success")));
              Navigator.pop(context);
              setState(() {
                widget.user.name = name;
                widget.user.phone =phone;
                widget.user.password = passa;
                widget.user.useraddress = useraddress;// 
              });
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Update Failed")));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Update Failed")));
        Navigator.pop(context);
      }
    });
  }
}