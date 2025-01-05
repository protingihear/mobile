import 'dart:convert';
import 'package:bisadenger/post_information.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InformationPage extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  List<dynamic> newsData = [];
  Map<int, bool> menuVisible = {};

  @override
  void initState() {
    super.initState();
    fetchNewsData();
  }

  Future<void> fetchNewsData() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:8000/api/information'));
      if (response.statusCode == 200) {
        setState(() {
          newsData = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to fetch news data');
      }
    } catch (error) {
      print('Error fetching news data: $error');
    }
  }

  void toggleMenu(int index) {
    setState(() {
      menuVisible[index] = !(menuVisible[index] ?? false);
    });
  }

  Future<void> handleDelete(int id) async {
    try {
      final response = await http
          .delete(Uri.parse('http://localhost:8000/api/information/$id'));
      if (response.statusCode == 200) {
        setState(() {
          newsData.removeWhere((news) => news['id'] == id);
        });
      } else {
        throw Exception('Failed to delete news');
      }
    } catch (error) {
      print('Error deleting news: $error');
    }
  }

  void addNewData(dynamic newData) {
    setState(() {
      newsData.insert(0, newData); // Menambahkan data baru di urutan pertama.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.hearing),
            SizedBox(width: 8),
            Text('IHear'),
          ],
        ),
        backgroundColor: Colors.blue.shade300,
        actions: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://via.placeholder.com/40'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.more_horiz),
                onPressed: () async {
                  // Navigasi ke PostInformationPage dan tunggu hasilnya
                  final newInformation = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PostInformationPage()),
                  );
                  if (newInformation != null) {
                    // Jika data baru dikembalikan, tambahkan ke daftar
                    addNewData(newInformation);
                  }
                },
              ),
            ),
            Expanded(
              child: newsData.isNotEmpty
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: newsData.length,
                      itemBuilder: (context, index) {
                        final news = newsData[index];
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(8)),
                                child: Image.network(
                                  news['image'] != null
                                      ? 'http://localhost:8000/storage/${news['image']}'
                                      : 'https://via.placeholder.com/300x150',
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      news['source'] ?? '',
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 12),
                                    ),
                                    Text(
                                      '${news['uploadDate']} ${news['uploadTime']}',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      news['title'] ?? '',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      news['content'] ?? '',
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: Icon(Icons.more_vert),
                                  onPressed: () => toggleMenu(index),
                                ),
                              ),
                              if (menuVisible[index] == true)
                                PopupMenuButton(
                                  onSelected: (value) {
                                    if (value == 'edit') {
                                      Navigator.pushNamed(context,
                                          '/edit_information/${news['id']}');
                                    } else if (value == 'delete') {
                                      handleDelete(news['id']);
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 'edit',
                                      child: Text('Edit'),
                                    ),
                                    PopupMenuItem(
                                      value: 'delete',
                                      child: Text('Delete'),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text('Tidak ada data berita.'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
