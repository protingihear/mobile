import 'package:flutter/material.dart';

class InformationPage extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  final List<Map<String, String>> _newsList = [
    {
      'image': 'https://via.placeholder.com/150',
      'source': 'Wolipop',
      'time': 'Jumat, 22 Nov 2024 19:30 WIB',
      'title': 'Finalis Tuli Pertama Miss Universe Mundur, Penyakitnya Bikin Tak Kuat Berdiri',
      'content': 'Mia le Roux, finalis tuli pertama Miss Universe 2024, mundur karena masalah kesehatan...',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'source': 'detikJatim',
      'time': 'Senin, 11 Nov 2024 18:05 WIB',
      'title': 'Senangnya Tunarungu Pacitan Terima Alat Bantu Dengar dari Bhayangkari',
      'content': 'Sukiran dan Novi, penyandang tunarungu di Pacitan, kini dapat berkomunikasi lebih baik...',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'source': 'detikJatim',
      'time': 'Senin, 29 Jul 2024 14:35 WIB',
      'title': 'Pemohon SIM Tunarungu di Kota Kediri Didampingi Juru Bahasa Isyarat',
      'content': 'Para penyandang disabilitas yang mengurus SIM A dan SIM C di Kota Kediri...',
    },
  ];

  void _navigateToAddNews(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNewsPage(
          onAddNews: (newNews) {
            setState(() {
              _newsList.add(newNews);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Information'),
      ),
      body: ListView.builder(
        itemCount: _newsList.length,
        itemBuilder: (context, index) {
          final news = _newsList[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.network(news['image']!),
              title: Text(news['title']!),
              subtitle: Text('${news['source']} - ${news['time']}'),
              onTap: () {
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddNews(context),
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddNewsPage extends StatefulWidget {
  final Function(Map<String, String>) onAddNews;

  AddNewsPage({required this.onAddNews});

  @override
  _AddNewsPageState createState() => _AddNewsPageState();
}

class _AddNewsPageState extends State<AddNewsPage> {
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _submitNews() {
    final newNews = {
      'image': _imageController.text,
      'source': _sourceController.text,
      'time': _timeController.text,
      'title': _titleController.text,
      'content': _contentController.text,
    };
    widget.onAddNews(newNews);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add News'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _imageController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            TextField(
              controller: _sourceController,
              decoration: InputDecoration(labelText: 'Source'),
            ),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Time'),
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitNews,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
