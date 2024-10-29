import 'package:flutter/material.dart';

class Lesson2Page extends StatelessWidget {
  // Data yang akan ditampilkan dalam ListView
  final List<String> lessonItems = [
    'Aku',
    'Dia',
    'Kamu',
    'Terima kasih',
    'Perkenalkan',
    'Nama',
    'Tinggal',
    'Sama-sama',
    'Tuli',
    'Dengar',
    'Umur'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 95,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(2.0),
            child: Icon(Icons.arrow_back),
            decoration: BoxDecoration(
              color: Color(0xFFBAE1C4),
              shape: BoxShape.circle,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Perkenalan',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari kategori yang kamu suka!',
                prefixIcon: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Image.asset('assets/images/Icon.png',
                      width: 24, height: 24),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: lessonItems.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                          color: Color(0xFFDEF5E4),
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(
                        title: Text(lessonItems[index]),
                        trailing: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/arrow-right.png',
                              width: 24, height: 24),
                        ),
                        onTap: () {
                          //ntar aja lah ya
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
