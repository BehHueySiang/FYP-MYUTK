import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myutk/ipconfig.dart';
import 'package:myutk/EntryScreen/mainscreen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'models/user.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final TextEditingController _emailEditingController =
      TextEditingController();
  final TextEditingController _passEditingController =
      TextEditingController();

  late double screenHeight, screenWidth, cardwitdh;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    checkAndLogin();
    loadPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splashscreen.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  Future<void> checkAndLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';
    String password = prefs.getString('password') ?? '';
    bool ischeck = prefs.getBool('checkbox') ?? false;

    late User user;

    if (ischeck) {
      try {
        http.Response response = await http.post(
          Uri.parse("${MyConfig().SERVER}/MyUTK/php/login_user.php"),
          body: {"email": email, "password": password},
        );

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          if (jsonResponse['data'] != null) {
            user = User.fromJson(jsonResponse['data']);
          } else {
            // Handle case where data is null
            throw Exception('Data is null');
          }
        } else {
          // Handle non-200 status code
          throw Exception('Failed to load data');
        }
      } catch (e) {
        // Handle error during HTTP request or JSON parsing
        print('Error: $e');
        user = User(
          id: "na",
          name: "na",
          email: "na",
          phone: "na",
          datereg: "na",
          password: "na",
          otp: "na",
        );
      }
    } else {
      user = User(
        id: "na",
        name: "na",
        email: "na",
        phone: "na",
        datereg: "na",
        password: "na",
        otp: "na",
      );
    }

    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (content) => MainScreen(user: user)),
      ),
    );
  }

  Future<void> loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';
    String password = prefs.getString('password') ?? '';
    _isChecked = prefs.getBool('checkbox') ?? false;
    if (_isChecked) {
      setState(() {
        _emailEditingController.text = email;
        _passEditingController.text = password;
      });
    }
  }
}
