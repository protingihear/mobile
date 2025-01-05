import 'package:bisadenger/community.dart';
import 'package:bisadenger/information.dart';
import 'package:bisadenger/lesson1.dart';
import 'package:bisadenger/profile.dart';
import 'package:bisadenger/scanToText.dart';
import 'package:bisadenger/voice_to_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePageContent(),
    const CommunityPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.language), label: "Relations"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}

// TOP SECTION//
class HomePageContent extends StatelessWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 170,
                  width: double.infinity,
                  color: const Color(0xFFDDFCED),
                ),
                Column(
                  children: [
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              // Mengganti gambar kiri dengan "pp.png"
                              _buildProfileAvatar(
                                "assets/images/pp.png", // Ganti dengan gambar lokal
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "Naraya, 20",
                                style: GoogleFonts.montserrat(
                                  color: const Color(0xFF062C07),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          // Mengganti gambar kanan dengan "logo.png"
                          _buildProfileAvatar(
                            "assets/images/logo.png", // Ganti dengan gambar lokal
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      child: Text(
                        "Selamat Datang Naraya\nYuk Jelajahi Dunia Tuli Bersama!",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montserrat(
                          color: const Color(0xFF062C07),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    // TOP SECTION//

//SCAN AND LESSON SECTION//
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical:
                              25.0), // Tambahkan padding vertikal dan horizontal
                      child: SingleChildScrollView(
                        scrollDirection:
                            Axis.horizontal, // Membuat scroll horizontal
                        child: Row(
                          children: [
                            FeatureButton(
                              iconPath: "assets/images/ImageScan.png",
                              label: "Scan to Text",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CameraScreen(),
                                  ),
                                );
                              },
                            ),
                            FeatureButton(
                              iconPath: "assets/images/VoiceToText.png",
                              label: "Voice to Text",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VoiceToTextScreen(),
                                  ),
                                );
                              },
                            ),
                            FeatureButton(
                              iconPath: "assets/images/Lesson.png",
                              label: "Lesson",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Lesson1Page(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
//SCAN AND LESSON SECTION//

                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Text(
                        "Information",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montserrat(
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 180, // Tinggi container keseluruhan
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        children: [
                          InfoCard(
                            imagePath: "assets/images/Informan1.png",
                            title:
                                "Cerita Inspiratif Nadya, Wisudawan Teman Tuli yang Lulus Cepat dan Cum Laude dari ITS",
                          ),
                          InfoCard(
                            imagePath: "assets/images/Informan2.png",
                            title:
                                "Kisah Hanif, Teman Tuli yang Mendapat Beasiswa LPDP-Dirikan Yayasan Difabel",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileAvatar(String imageUrl) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        border: Border.all(
          color: Colors.black,
          style: BorderStyle.solid,
          width: 2,
        ),
      ),
    );
  }
}

//ICON PATH//
class FeatureButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback onTap;

  const FeatureButton({
    Key? key,
    required this.iconPath,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 135,
        height: 160, // Tinggi container disesuaikan
        margin:
            const EdgeInsets.symmetric(horizontal: 10), // Gap antar container
        decoration: BoxDecoration(
          color: const Color(0xFF1F6D80),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 60, // Ukuran gambar diperbesar
              height: 60, // Tinggi gambar diperbesar
            ),
            const SizedBox(height: 12), // Jarak antara gambar dan teks
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//ICON PATH//

//NEWS PATH//
class InfoCard extends StatelessWidget {
  final String imagePath;
  final String title;

  const InfoCard({
    Key? key,
    required this.imagePath,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman Information dengan parameter title dan imagePath
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InformationPage(),
          ),
        );
      },
      child: Container(
        width: 300, // Lebar kartu agar seragam
        margin: const EdgeInsets.only(right: 15), // Jarak antar kartu
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 204, 233, 246),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color:
                  Colors.grey.withOpacity(0.3), // Bayangan agar terlihat elegan
              blurRadius: 5,
              offset: const Offset(0, 3), // Arah bayangan
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                imagePath,
                height: 120, // Tinggi gambar proporsional
                width: double.infinity,
                fit: BoxFit.cover, // Menyesuaikan gambar dengan area
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                maxLines: 2, // Maksimal 2 baris
                overflow: TextOverflow
                    .ellipsis, // Tambahkan "..." jika teks terlalu panjang
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//NEWS PATH//