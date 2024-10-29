import 'package:flutter/material.dart';
import 'dataUser.dart';

class Sign_Up_Page extends StatefulWidget {
  @override
  sign_up createState() => sign_up();
}

class sign_up extends State<Sign_Up_Page> {
  final dataUser = Datauser();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController registEmailController = TextEditingController();
  final TextEditingController registPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool isTemanKita = false;
  bool isAhliBahasa = false;
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

                // Role Selection
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Role*', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isTemanKita,
                      onChanged: (value) {
                        setState(() {
                          isTemanKita = value ?? false;
                        });
                      },
                    ),
                    Text('Teman kita'),
                    Checkbox(
                      value: isAhliBahasa,
                      onChanged: (value) {
                        setState(() {
                          isAhliBahasa = value ?? false;
                        });
                      },
                    ),
                    Text('Ahli bahasa'),
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
                        style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
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
                  onPressed: isAgreed ? () {
                    String inputEmail = registEmailController.text;
                    String inputPassword = registPasswordController.text;

                    setState(() {
                      dataUser.addUser(inputEmail, inputPassword);
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Sign Up Berhasil'),
                        backgroundColor: Colors.green,
                      ),
                    );

                    Navigator.pop(context);
                  } : null,
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
