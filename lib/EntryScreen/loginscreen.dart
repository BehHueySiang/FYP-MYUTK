import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/models/user.dart';
import 'package:myutk/ipconfig.dart';
import 'package:myutk/EntryScreen/registrationscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myutk/AdminScreen/AdminManagementScreen/adminmainscreen.dart';
import 'mainscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;

  final String adminPassword = "admin123"; // Specify admin password here

  @override
  void initState() {
    super.initState();
    loadPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber[200],
        foregroundColor: Colors.amber[800],
        elevation: 0,
      ),
      backgroundColor: Colors.amber[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/Login.png",
              height: MediaQuery.of(context).size.height * 0.4,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailEditingController,
                          validator: (val) => val!.isEmpty || !val.contains("@") || !val.contains(".")
                              ? "Enter a valid email"
                              : null,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.amber),
                            icon: Icon(Icons.email, color: Colors.amber),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0),
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: _passEditingController,
                          validator: (val) => val!.isEmpty || val.length < 5
                              ? "Password must be at least 5 characters"
                              : null,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.amber),
                            icon: Icon(Icons.lock, color: Colors.amber),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Colors.amber[400],
                              value: _isChecked,
                              onChanged: (bool? value) {
                                saveremovepref(value!);
                                setState(() {
                                  _isChecked = value;
                                });
                              },
                            ),
                            Text(
                              'Remember Me',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            MaterialButton(
                              onPressed: onLogin,
                              minWidth: MediaQuery.of(context).size.width / 3,
                              height: 50,
                              elevation: 10,
                              color: Colors.amber,
                              textColor: Colors.black,
                              child: const Text('Login'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: _goToRegister,
              child: const Text(
                "New account?",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void onLogin() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Check your input")));
      return;
    }

    String email = _emailEditingController.text;
    String pass = _passEditingController.text;

    try {
      final response = await http.post(
        Uri.parse("${MyConfig().SERVER}/MyUTK/php/login_user.php"),
        body: {
          "email": email,
          "password": pass,
        },
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          User user = User.fromJson(jsondata['data']);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Success")));

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => pass == adminPassword
                  ? AdminMainScreen(user: user)
                  : MainScreen(user: user),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Failed")));
        }
      }
    } on TimeoutException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Request timed out")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error occurred")));
    }
  }

  void _goToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegistrationScreen()),
    );
  }

  Future<void> saveremovepref(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value) {
      // Save preference
      await prefs.setString('email', _emailEditingController.text);
      await prefs.setString('pass', _passEditingController.text);
    } else {
      // Remove preference
      await prefs.remove('email');
      await prefs.remove('pass');
    }
    await prefs.setBool('checkbox', value);
  }

  Future<void> loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _emailEditingController.text = prefs.getString('email') ?? '';
      _passEditingController.text = prefs.getString('pass') ?? '';
      _isChecked = prefs.getBool('checkbox') ?? false;
    });
  }
}

