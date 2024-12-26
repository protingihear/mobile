import 'package:bisadenger/lesson1.dart';
import 'package:bisadenger/scanToText.dart';
import 'package:bisadenger/voice_to_text.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          // Fungsi perubahan index bisa ditambahkan di sini
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.language), label: "Relations"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 140,
                    width: double.infinity,
                    color: Colors.green.shade100,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                "https://via.placeholder.com/150",
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Naraya, 20",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage(
                            "https://via.placeholder.com/150",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Selamat Datang Naraya\nYuk Jelajahi Dunia Tuli Bersama!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFeatureCard(
                      context,
                      "Image Scan",
                      Icons.image,
                      Colors.blue,
                      () {
                        // Navigator.push() pindah ke file terpisah
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CameraScreen()),
                        );
                        debugPrint("Navigasi ke Image Scan");
                      },
                    ),
                    _buildFeatureCard(
                      context,
                      "Voice to Text",
                      Icons.mic,
                      Colors.orange,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VoiceToTextScreen()),
                        );
                        debugPrint("Navigasi ke Voice to Text");
                      },
                    ),
                    _buildFeatureCard(
                      context,
                      "Lesson",
                      Icons.book,
                      Colors.purple,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Lesson1Page()),
                        );
                        debugPrint("Navigasi ke Lesson");
                      },
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Information",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              ),
              _buildInfoCard("assets/images/Informan1.png"),
              _buildInfoCard("assets/images/Informan2.png"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, IconData icon,
      Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: color),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String imagePath) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 150,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
