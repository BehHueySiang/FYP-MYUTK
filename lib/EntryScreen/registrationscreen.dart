import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';
import 'loginscreen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailditingController = TextEditingController();
  final TextEditingController _phonelditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final TextEditingController _pass2EditingController = TextEditingController();
  final TextEditingController _useraddressController = TextEditingController();
  bool _isChecked = false;
  final _formKey = GlobalKey<FormState>();
  late double screenHeight, screenWidth, cardwitdh;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Registration", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.amber[200],
        foregroundColor: Colors.amber[800],
        elevation: 0,
      ),
      backgroundColor: Colors.amber[50],
      body: SingleChildScrollView(
        child: Column(children: [
          
          SizedBox(
              height: screenHeight * 0.35,
              width: screenWidth,
              child: Image.asset(
                "assets/images/registration.png",
                fit: BoxFit.cover,
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 8,
              child: Container(
                margin: const EdgeInsets.all(16),
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
                          controller: _emailditingController,
                          validator: (val) => val!.isEmpty ||
                                  !val.contains("@") ||
                                  !val.contains(".")
                              ? "enter a valid email"
                              : null,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              labelText: 'E- mail address',
                              labelStyle: TextStyle(color: Colors.amber),
                              icon: Icon(Icons.email,color: Colors.amber),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2.0),
                              ))),
                              TextFormField(
                          keyboardType: TextInputType.phone,
                          validator: (val) => val!.isEmpty || (val.length < 10)
                              ? "phone must be longer or equal than 10"
                              : null,
                          controller: _phonelditingController,
                          decoration: const InputDecoration(
                              labelText: 'Phone number',
                              labelStyle: TextStyle(color: Colors.amber),
                              icon: Icon(Icons.phone,color: Colors.amber),
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
                          controller: _useraddressController,
                        
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
                      Row(
                        children: [
                          Checkbox(
                             checkColor: Colors.white,
                            activeColor: Colors.amber[400],
                            value: _isChecked,
                            onChanged: (bool? value) {
                              if (!_isChecked) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Terms have been read and accepted.")));
                              }
                              setState(() {
                                _isChecked = value!;
                              });
                            },
                          ),
                          GestureDetector(
                            onTap: null,
                            child: const Text('Agree with terms',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                              child: ElevatedButton(
                                  onPressed: onRegisterDialog,
                                  child: const Text("Register",style: TextStyle(color: Colors.black,)),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),)))
                        ],
                      )
                    ]),
                  ),
                  
                ]),
              ),
            ),
          ),
          
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: _goLogin,
            child: const Text(
              "Already Registered? Login",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ]),
      ),
    );
  }

  void onRegisterDialog() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Check your input")));
      return;
    }
    if (!_isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please agree with terms and conditions")));
      return;
    }
    String passa = _passEditingController.text;
    String passb = _pass2EditingController.text;
    if (passa != passb) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Check your password")));
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Register new account?",
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
                registerUser();
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

  void registerUser() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text("Please Wait"),
          content: Text("Registration..."),
        );
      },
    );
    String name = _nameEditingController.text;
    String email = _emailditingController.text;
    String phone = _phonelditingController.text;
    String passa = _passEditingController.text;
    String useraddress = _useraddressController.text;

    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/register_user.php"),
        body: {
          "name": name,
          "email": email,
          "phone": phone,
          "password": passa,
          "useraddress": useraddress
        }).then((response) {
     //  print(response.body);        
     print(response.body);
        
      if (response.statusCode == 200 ) {
         var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Registration Success")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Registration Failed")));
        }
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Registration Failed")));
        Navigator.pop(context);
      }
    });
  }

  void _goLogin() {
     Navigator.push(
           context, MaterialPageRoute(builder: (context) =>  LoginScreen()));
  }
}
