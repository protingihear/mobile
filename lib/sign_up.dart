import 'package:flutter/material.dart';
import 'dataUser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Sign_Up_Page extends StatefulWidget {
  @override
  sign_up createState() => sign_up();
}

class sign_up extends State<Sign_Up_Page> {
  final dataUser = Datauser();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController registEmailController = TextEditingController();
  final TextEditingController registPasswordController =
      TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String? gender; // Jenis kelamin ("L" atau "P")
  bool isAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/Logo_IHear.png',
                  height: 100,
                ),
                SizedBox(height: 16),
                Text(
                  'Sign Up for IHear',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text('Create your account'),
                SizedBox(height: 16),

                // Username Field
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.green[100],
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ),
                SizedBox(height: 12),

                // Email Field
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: registEmailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.green[100],
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
                SizedBox(height: 12),

                // Password Field
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: registPasswordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.green[100],
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(height: 12),

                // Confirm Password Field
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.green[100],
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(height: 16),

                // Gender Selection
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Jenis Kelamin*',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: 'L',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                        });
                      },
                    ),
                    Text('Laki-Laki'),
                    Radio<String>(
                      value: 'P',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                        });
                      },
                    ),
                    Text('Perempuan'),
                  ],
                ),

                // Terms and Conditions Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: isAgreed,
                      onChanged: (value) {
                        setState(() {
                          isAgreed = value ?? false;
                        });
                      },
                    ),
                    Text('I agree with '),
                    GestureDetector(
                      onTap: () {
                        // Buka halaman syarat dan ketentuan
                      },
                      child: Text(
                        'terms and conditions',
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                // Sign Up Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: isAgreed && gender != null
                      ? () async {
                          // Ambil input user
                          String inputUsername = usernameController.text;
                          String inputEmail = registEmailController.text;
                          String inputPassword = registPasswordController.text;
                          String confirmPassword =
                              confirmPasswordController.text;

                          if (inputPassword != confirmPassword) {
                            // Tampilkan pesan error jika password tidak cocok
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Password dan konfirmasi tidak cocok!'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          // Data yang akan dikirim ke server
                          Map<String, dynamic> requestData = {
                            'username': inputUsername,
                            'email': inputEmail,
                            'password': inputPassword,
                            'gender': gender,
                            'firstName':
                                'John', // Contoh data tambahan, sesuaikan dengan kebutuhan
                            'lastName': 'Doe'
                          };

                          try {
                            // Kirim POST request ke server
                            var response = await http.post(
                              Uri.parse(
                                  'http://10.0.2.2:8000/api/teman-tuli'), 
                              headers: {
                                'Content-Type': 'application/json',
                              },
                              body: jsonEncode(requestData),
                            );

                            // Tangani response dari server
                            if (response.statusCode == 201) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Sign Up Berhasil'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Navigator.pop(
                                  context); // Kembali ke halaman sebelumnya
                            } else {
                              // Tangani error dari server
                              var errorResponse = jsonDecode(response.body);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Error: ${errorResponse['errors']}'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          } catch (e) {
                            // Tangani error jaringan
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Terjadi kesalahan jaringan: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      : null,
                  child: Text('Sign Up', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
