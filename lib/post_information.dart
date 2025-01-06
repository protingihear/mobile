import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class PostInformationPage extends StatefulWidget {
  @override
  _PostInformationPageState createState() => _PostInformationPageState();
}

class _PostInformationPageState extends State<PostInformationPage> {
  final _formKey = GlobalKey<FormState>();
  Map<String, String> form = {
    'source': '',
    'uploadDate': '',
    'uploadTime': '',
    'title': '',
    'content': '',
  };
  XFile? _pickedImage;
  Uint8List? _imageBytes;

  /// Fungsi untuk memilih gambar
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _pickedImage = pickedFile;
        _imageBytes = bytes;
      });
    }
  }

  /// Fungsi untuk mengirim data dan gambar ke server
  Future<void> handleSubmit() async {
    if (!_formKey.currentState!.validate() || _pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Harap lengkapi semua data dan pilih gambar!')),
      );
      return;
    }

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://localhost:8000/api/information'),
      );

      // Menambahkan data form
      request.fields.addAll(form);

      // Menambahkan gambar ke request
      if (_pickedImage != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'image',
            _imageBytes!,
            filename: _pickedImage!.name,
          ),
        );
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Berhasil menyimpan data!')),
        );
        Navigator.pop(context);
      } else {
        throw Exception('Gagal menyimpan data');
      }
    } catch (error) {
      print('Error submitting data: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Berita'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Sumber'),
                onChanged: (value) => form['source'] = value,
                validator: (value) => value == null || value.isEmpty
                    ? 'Sumber wajib diisi'
                    : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tanggal Upload'),
                onChanged: (value) => form['uploadDate'] = value,
                validator: (value) => value == null || value.isEmpty
                    ? 'Tanggal wajib diisi'
                    : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Waktu Upload'),
                onChanged: (value) => form['uploadTime'] = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Waktu wajib diisi' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Judul'),
                onChanged: (value) => form['title'] = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Judul wajib diisi' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Isi'),
                onChanged: (value) => form['content'] = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Isi wajib diisi' : null,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: pickImage,
                child: Text('Pilih Gambar'),
              ),
              if (_imageBytes != null) ...[
                SizedBox(height: 16),
                Image.memory(_imageBytes!, height: 150),
              ],
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: handleSubmit,
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
