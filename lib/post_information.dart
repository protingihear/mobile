import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:intl/intl.dart';
import 'package:bisadenger/information.dart';

class PostInformationPage extends StatefulWidget {
  final int selectedIndex;

  const PostInformationPage({super.key, required this.selectedIndex});
  @override
  _PostInformationPageState createState() => _PostInformationPageState();
}

class _PostInformationPageState extends State<PostInformationPage> {
  final _formKey = GlobalKey<FormState>();
  Map<String, String> form = {
    'source': '',
    'upload_date': '',
    'upload_time': '',
    'title': '',
    'content': '',
  };
  bool isLoading = true;

  @override
  initState() {
    super.initState();
    _fetchInformation();
    if (widget.selectedIndex == -1) {
      isLoading = false;
    }
  }

  Future<void> _fetchInformation() async {
    final url = Uri.parse(
        'http://localhost:8000/api/information/${widget.selectedIndex}');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          form['source'] = data['source'] ?? '';
          form['upload_date'] = data['upload_date'] ?? '';
          form['upload_time'] = data['upload_time'] ?? '';
          form['title'] = data['title'] ?? '';
          form['content'] = data['content'] ?? '';
          isLoading = false;
        });
      } else {
        print(
            'Failed to fetch information. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  // For Date

  String? _selected_date = "Tanggal Upload Kosong";

  void _openDatePicker(BuildContext context) {
    BottomPicker.date(
      pickerTitle: Text(
        'Pilih Tanggal Upload',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.blue,
        ),
      ),
      dateOrder: DatePickerDateOrder.dmy,
      initialDateTime: DateTime.now(),
      pickerTextStyle: TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      onSubmit: (index) {
        setState(() {
          DateTime selectedDate = DateTime(index.year, index.month, index.day);

          _selected_date = DateFormat('dd-MMM-yyyy').format(selectedDate);
          form['upload_date'] = _selected_date!;
        });
      },
      bottomPickerTheme: BottomPickerTheme.plumPlate,
      buttonStyle: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.blue[200]!,
        ),
      ),
      buttonWidth: 200,
      buttonContent: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Simpan',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 15,
            ),
          ],
        ),
      ),
    ).show(context);
  }

  // For time
  String? _selected_time = "Waktu Upload Kosong";
  void _openTimePicker(BuildContext context) {
    BottomPicker.time(
      pickerTitle: Text(
        'Pilih Waktu Upload',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.blue,
        ),
      ),
      onSubmit: (index) {
        setState(() {
          String timeString = DateFormat('HH:mm').format(index);
          _selected_time = timeString;
          form['upload_time'] = _selected_time!;
        });
      },
      bottomPickerTheme: BottomPickerTheme.plumPlate,
      use24hFormat: true,
      initialTime: Time.now(),
      buttonStyle: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.blue[200]!,
        ),
      ),
      buttonWidth: 200,
      buttonContent: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Simpan',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 15,
            ),
          ],
        ),
      ),
    ).show(context);
  }

  /// Fungsi untuk mengirim data dan gambar ke server
  Future<void> handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Harap lengkapi semua data')),
      );
      return;
    } else {
      print(form);
      try {
        final url = Uri.parse('http://localhost:8000/api/information');
        final formattedDate =
            DateFormat('dd-MMM-yyyy').parse(form['upload_date']!);
        final formattedTime = form['upload_time']! + ":00";

        print("${formattedDate}  aaaa $formattedTime");
        final Map<String, dynamic> requestData = {
          'source': form['source'],
          'upload_date': formattedDate.toIso8601String().split('T').first,
          'upload_time': formattedTime,
          'title': form['title'],
          'content': form['content'],
        };

        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: json.encode(requestData),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Berhasil menyimpan data!')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => InformationPage()),
          );
        } else {
          throw Exception(
              "status code:${response.statusCode} response headers: ${response.headers}, response body:${response.body}");
        }
      } catch (error) {
        print('Error submitting data: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan: $error')),
        );
      }

      // end try
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
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
                initialValue: (form['source']?.isEmpty ?? true)
                    ? ''
                    : '${form['source']}',
                decoration: InputDecoration(
                  labelText: 'Sumber',
                ),
                onChanged: (value) => form['source'] = value,
              ),
              Text(
                'Tanggal Upload',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      _openDatePicker(context);
                    },
                    child: const Text(
                      'Pilih Tanggal',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                  Text(
                    (form['upload_date']?.isEmpty ?? true)
                        ? '${_selected_date}'
                        : '${form['upload_date']}',
                  ),
                ],
              ),
              Text(
                'Waktu Upload',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      _openTimePicker(context);
                    },
                    child: const Text(
                      'Pilih Waktu',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                  Text(
                    (form['upload_time']?.isEmpty ?? true)
                        ? '${_selected_time}'
                        : '${form['upload_time']}',
                  ),
                ],
              ),
              TextFormField(
                initialValue:
                    (form['title']?.isEmpty ?? true) ? '' : '${form['title']}',
                decoration: InputDecoration(
                  labelText: 'Judul',
                ),
                onChanged: (value) => form['title'] = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Judul wajib diisi' : null,
              ),
              TextFormField(
                initialValue: (form['content']?.isEmpty ?? true)
                    ? ''
                    : '${form['content']}',
                decoration: InputDecoration(
                  labelText: 'Isi',
                ),
                onChanged: (value) => form['content'] = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Isi wajib diisi' : null,
              ),
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
