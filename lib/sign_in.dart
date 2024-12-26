
import 'package:bisadenger/community.dart';
import 'home_page.dart';
import 'package:bisadenger/lesson1.dart';

import 'package:bisadenger/main.dart';
import 'package:flutter/material.dart';
import 'dataUser.dart';
import 'sign_up.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Sign_In_Page extends StatefulWidget {
  @override
  _Sign_In_Page createState() => _Sign_In_Page();
}

class _Sign_In_Page extends State<Sign_In_Page> {
  bool isChecked = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _responseMessage;

  List<List<String>> dataUser = Datauser().dataUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.asset('assets/images/Logo_IHear.png'),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Sign In For IHear',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(child: Text('Welcome Back To My Guys')),
                  SizedBox(height: 50),
                  // Email/Username TextField
                  Container(
                    width: double.infinity, // Lebar penuh
                    padding: EdgeInsets.only(left: 10),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Email/Username',
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.green,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Icon(Icons.email),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Password TextField
                  Container(
                    width: double.infinity, // Lebar penuh
                    padding: EdgeInsets.only(left: 10),
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.green,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Icon(Icons.lock),
                        ),
                      ),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Checkbox Remember Me
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(color: Colors.purple),
                      ),
                      onTap: () {
                        print('Makanya jangan keringan ngocok');
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  // Tombol Sign In
                  Container(
                    width: double.infinity, // Lebar penuh
                    height: 50,
                    child: ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text(
                        'Sign In',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Tombol Sign Up
                  Container(
                    width: double.infinity, // Lebar penuh
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Sign_Up_Page()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(color: Colors.green),
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Fungsi login untuk mengecek email dan password

  Future<void> login() async {
    final email = Uri.encodeComponent(_emailController.text);
    final password = Uri.encodeComponent(_passwordController.text);

    final url = 'http://10.0.2.2:8000/api/auth?email=$email&password=$password';

    try {
      // Menggunakan http.get untuk fetch request
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _responseMessage = "Login successful: ${data['message']}";
        });

        Navigator.pushReplacement(

          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
      } else {
        setState(() {
          _responseMessage =
              "Login failed: ${jsonDecode(response.body)['message']}";
        });
      }
    } catch (error) {
      setState(() {
        _responseMessage = "Error: $error";
      });
    }
  }
}
