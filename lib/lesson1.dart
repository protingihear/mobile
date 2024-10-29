import 'package:flutter/material.dart';

class Lesson1Page extends StatelessWidget {
  // Data pelajaran yang akan ditampilkan
  final List<Map<String, dynamic>> lessons = [
    {'title': 'Perkenalan', 'words': '25 Kata', 'progress': 0.8, 'icon': Icons.person},
    {'title': 'Sapaan', 'words': '15 Kata', 'progress': 0.5, 'icon': Icons.handshake},
    {'title': 'Pertanyaan', 'words': '20 Kata', 'progress': 0.7, 'icon': Icons.question_answer},
    {'title': 'Emosional', 'words': '10 Kata', 'progress': 0.3, 'icon': Icons.mood},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'MY LESSON',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.green),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Card utama di atas
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://via.placeholder.com/400x200'), // Ganti dengan URL gambar yang sesuai
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        '20 Points',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Sign Language Learning',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Learn more',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ListView.builder untuk daftar pelajaran
            ListView.builder(
              shrinkWrap: true, // Agar tidak mengambil seluruh tinggi layar
              physics: const NeverScrollableScrollPhysics(), // Nonaktifkan scroll internal
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                final lesson = lessons[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(0xFFEFF4F9),
                        child: Icon(lesson['icon'], color: Colors.blue),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lesson['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              lesson['words'],
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: lesson['progress'],
                              backgroundColor: Colors.grey[300],
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
