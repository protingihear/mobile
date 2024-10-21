import 'package:flutter/material.dart';
import 'voice_to_text.dart';
import 'image_to_text.dart';

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
      home: HomeScreen(),
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
            SizedBox(height: 20), // Add some spacing between buttons
            
          ],
        ),
      ),
    );
  }
}

