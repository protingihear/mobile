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

  // void toggleMenu(int index) {
  //   setState(() {
  //     menuVisible[index] = !(menuVisible[index] ?? false);
  //   });
  // }

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
                        builder: (context) => PostInformationPage(
                              selectedIndex: -1,
                            )),
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
                        childAspectRatio: 1.0,
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
                                      '${news['upload_date']} ${news['upload_time']}',
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
                                child: MenuAnchor(
                                  builder: (
                                    BuildContext context,
                                    MenuController controller,
                                    Widget? child,
                                  ) {
                                    return IconButton(
                                      onPressed: () {
                                        if (controller.isOpen) {
                                          controller.close();
                                        } else {
                                          controller.open();
                                        }
                                      },
                                      icon: const Icon(Icons.more_vert),
                                    );
                                  },
                                  menuChildren: [
                                    MenuItemButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PostInformationPage(
                                              selectedIndex: news['id'],
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Edit',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                    MenuItemButton(
                                      onPressed: () {
                                        handleDelete(news['id']);
                                      },
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    )
                                  ],
                                ),
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
