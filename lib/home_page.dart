import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  static const platform = MethodChannel('com.example.mediapipe/channel');

  void _launchNativeScreen() async {
    try {
      await platform.invokeMethod('launchNativeScreen');
    } on PlatformException catch (e) {
      print("Failed to launch native screen: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _launchNativeScreen,
          child: Text("Launch Native Screen"),
        ),
      ),
    );
  }
}
