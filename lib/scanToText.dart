import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CameraScreen(),
    );
  }
}

class CameraScreen extends StatelessWidget {
  void showTranslationDialog(BuildContext context, String translation) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Terjemahan"),
          content: Text(translation),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Tutup"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          // Tombol kembali di sudut kiri atas
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: CircleAvatar(
                backgroundColor: Colors.green[200],
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // Bingkai atas yang bisa diklik
          Positioned(
            top: 120,
            left: 40,
            right: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => showTranslationDialog(
                      context, "Ini adalah terjemahan bagian kiri atas"),
                  child: Container(
                    width: 50,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.blue[200]!, width: 5),
                        top: BorderSide(color: Colors.blue[200]!, width: 5),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => showTranslationDialog(
                      context, "Ini adalah terjemahan bagian kanan atas"),
                  child: Container(
                    width: 50,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(color: Colors.blue[200]!, width: 5),
                        top: BorderSide(color: Colors.blue[200]!, width: 5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bingkai bawah yang bisa diklik
          Positioned(
            bottom: 200,
            left: 40,
            right: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => showTranslationDialog(
                      context, "Ini adalah terjemahan bagian kiri bawah"),
                  child: Container(
                    width: 50,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.blue[200]!, width: 5),
                        bottom: BorderSide(color: Colors.blue[200]!, width: 5),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => showTranslationDialog(
                      context, "Ini adalah terjemahan bagian kanan bawah"),
                  child: Container(
                    width: 50,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(color: Colors.blue[200]!, width: 5),
                        bottom: BorderSide(color: Colors.blue[200]!, width: 5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Tombol kamera di bagian tengah bawah
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  // Tambahkan aksi kamera di sini
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.green[200],
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.teal[700],
                    size: 30,
                  ),
                ),
              ),
            ),
          ),

          // Tombol di bagian bawah yang bisa diklik
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: () => showTranslationDialog(
                  context, "Terjemahan dari scan to text"),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
