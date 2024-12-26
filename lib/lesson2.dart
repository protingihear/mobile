import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart'; // Import url_launcher

class Lesson2Page extends StatefulWidget {
  final String categoryTitle; // Menerima data dari Lesson1Page

  Lesson2Page({Key? key, required this.categoryTitle}) : super(key: key);

  @override
  _Lesson2PageState createState() => _Lesson2PageState();
}

class _Lesson2PageState extends State<Lesson2Page> {
  late Future<List<dynamic>> lessonItems; // Untuk menyimpan data dari API

  @override
  void initState() {
    super.initState();
    // Ambil data dari API saat halaman pertama kali dibuka
    lessonItems = fetchLessonItems();
  }

  // Fungsi untuk mengambil data dari API
  Future<List<dynamic>> fetchLessonItems() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/read')); // Ganti dengan URL server yang sesuai

    if (response.statusCode == 200) {
      // Jika server berhasil memberikan respon
      List data = json.decode(response.body);
      print('Data dari API: $data'); // Debugging: Melihat data dari API

      List<dynamic> filteredData = []; // List untuk menyimpan data yang difilter

      // Menggunakan forEach untuk memeriksa kategori satu per satu
      data.forEach((item) {
        var category = item['kategori']; // Ambil kategori sebagai string
        
        // Cek apakah kategori cocok dengan categoryTitle
        if (category != null && category.toString().trim().toLowerCase() == widget.categoryTitle.trim().toLowerCase()) {
          filteredData.add(item); // Menambahkan item ke filteredData jika cocok
        }
      });

      print('Data setelah difilter: $filteredData'); // Debugging: Melihat hasil filter
      return filteredData; // Kembalikan data yang sudah difilter
    } else {
      throw Exception('Failed to load lesson items');
    }
  }

  // Fungsi untuk membuka URL YouTube
  _launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url); // Meluncurkan URL jika valid
    } else {
      throw 'Could not launch $url'; // Menangani error jika URL tidak valid
    }
  }

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
          'List Course',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Menampilkan kategori yang diterima dari Lesson1Page
            Text(
              'Kategori: ${widget.categoryTitle}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari kategori yang kamu suka!',
                prefixIcon: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Image.asset('assets/images/Icon.png', width: 24, height: 24),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Menampilkan data menggunakan FutureBuilder
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: lessonItems,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator()); // Menunggu data
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}')); // Menampilkan error jika ada
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Tidak ada data')); // Tidak ada data
                  } else {
                    // Menampilkan list jika data tersedia
                    var items = snapshot.data!;
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.transparent),
                                color: Color(0xFFDEF5E4),
                                borderRadius: BorderRadius.circular(30)),
                            child: ListTile(
                              title: Text(items[index]['kata']), // Menampilkan 'kata' dari API
                              trailing: Container(
                                padding: EdgeInsets.all(8.0),
                                child: Image.asset('assets/images/arrow-right.png', width: 24, height: 24),
                              ),
                              onTap: () {
                                // Saat item di-tap, buka URL YouTube
                                String youtubeLink = items[index]['link_yt'];
                                _launchURL(youtubeLink); // Panggil fungsi untuk membuka URL
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
