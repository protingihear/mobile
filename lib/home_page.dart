import 'package:bisadenger/image_to_text.dart';
import 'package:bisadenger/lesson1.dart';
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 140,
                    width: double.infinity,
                    color: const Color.fromARGB(255, 222, 252, 223),
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
                                Container(
                                  height: 35,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTkPwUQk15VrAYIItf6cQTxmZ0ofEXVeCFRg&s"),
                                      fit: BoxFit.cover,
                                    ),
                                    border: Border.all(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Naraya, 20",
                                  style: GoogleFonts.montserrat(
                                    color: const Color.fromARGB(255, 6, 44, 7),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: const DecorationImage(
                                  image: NetworkImage(
                                      "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTA9yhXLKfPd6GXromxPQ2-2GgtJ-4TjyYSrHFVX84VH_N2AXsP"),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Text Section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Text(
                          "Selamat Datang Naraya\nYuk Jelajahi Dunia Tuli Bersama!",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.montserrat(
                            color: const Color.fromARGB(255, 6, 44, 7),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  // Aksi ketika container ini ditekan
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => IMGtoText(),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Container(
                                    width: 150,
                                    height: 200,
                                    color: Colors.blue,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/ImageScan.png",
                                          width: 100,
                                          height: 100,
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VoiceToTextScreen(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Container(
                                  width: 150,
                                  height: 200,
                                  color: Colors.blue,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/VoiceToText.png",
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Lesson1Page(),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Container(
                                    width: 150,
                                    height: 200,
                                    color: Colors.blue,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/Lesson.png",
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Text(
                          "Information",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.montserrat(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      SizedBox(
                          width: double.infinity,
                          height: 240,
                          child: Stack(
                            children: [
                              Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        height: 150,
                                        child: Image.asset(
                                          "assets/image/Informan1.png",
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    ],
                                  ))
                            ],
                          )),
                      SizedBox(
                          width: double.infinity,
                          height: 240,
                          child: Stack(
                            children: [
                              Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        height: 150,
                                        child: Image.asset(
                                          "assets/image/Informan1.png",
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    ],
                                  ))
                            ],
                          ))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
