import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const platform = MethodChannel('com.example.niggerracing/channel');

  Future<void> _printMessage() async {
    try {
      final String result = await platform.invokeMethod('printMessage');
      print(result);  // Expected output: "Message from Kotlin!"
    } on PlatformException catch (e) {
      print("Failed to get message: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Kotlin Integration')),
        body: Center(
          child: ElevatedButton(
            onPressed: _printMessage,
            child: Text('Print Message from Kotlin'),
          ),
        ),
      ),
    );
  }
}
