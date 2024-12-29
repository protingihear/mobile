import 'package:bisadenger/home_page.dart';
import 'package:bisadenger/information.dart';
import 'package:bisadenger/lesson1.dart';
import 'package:bisadenger/sign_in.dart';
import 'package:flutter/material.dart';
import 'profile.dart';
import 'voice_to_text.dart';
// Import the Image to Text screen
import 'community.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voice & Image to Text Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Sign_In_Page(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voice & Image to Text Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Navigate to Voice to Text Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VoiceToTextScreen()),
                );
              },
              child: Text('Voice to Text'),
            ),
            /*SizedBox(height: 20), // Add some spacing between buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to Image to Text Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RealTimeOCRScreen()),
                );
              },
              child: Text('Image to Text'),
            ),*/
            SizedBox(height: 20), // Add some spacing between buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to Image to Text Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                );
              },
              child: Text('Image to Text'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: Text('Profile Page'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommunityPage()),
                );
              },
              child: Text('Community Page'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InformationPage()),
                );
              },
              child: Text('Information Page'),
            ),
          ],
        ),
      ),
    );
  }
}

