import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home" ),
        BottomNavigationBarItem(icon: Icon(Icons.language), label: "Relations" ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile" )
      ]),
      body: SafeArea(
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
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 45, 
                                width: 45,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,  // Make it circular
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTkPwUQk15VrAYIItf6cQTxmZ0ofEXVeCFRg&s"
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(
                                    color: Colors.black, 
                                    style: BorderStyle.solid, 
                                    width: 2
                                  ),
                                ),
                              ),
                              SizedBox(width: 10), // Spacing between image and text
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
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTA9yhXLKfPd6GXromxPQ2-2GgtJ-4TjyYSrHFVX84VH_N2AXsP"
                                ),
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
                       padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10), // Tambahkan padding kiri
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
                    Row(
                      children: [
                         Card(
                          child: Container(
                          width: 150,
                          height: 200,
                          color: Colors.blue,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcRW5y-v4s78hvzRu84ZOzYpQQai4EhzdNzYaSbdIchbeDYRaGoZ",
                                width: 100,
                                height: 100, 
                                fit: BoxFit.cover, 
                              ),
                            ],
                           ),
                          ),
                        ),
                         Card(
                          child: Container(
                          width: 150,
                          height: 200,
                          color: Colors.blue,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcRQQwAWE_WeHcrXdcl8IXtl8QrYap3ttMJZn_CCrraesoLpx2-S",
                                width: 100,
                                height: 100, 
                                fit: BoxFit.cover, 
                              ),
                            ],
                           ),
                          ),
                        ),
                         Card(
                          child: Container(
                          width: 150,
                          height: 200,
                          color: Colors.blue,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcRZHtj9-EVnSz4Im3Cpyks3ZBl5NwOVTm0l5lbcjzvdnjAFwYop",
                                width: 100,
                                height: 100, 
                                fit: BoxFit.cover, 
                              ),
                            ],
                           ),
                          ),
                        ),
                      ],
                    ),
                     Container(
                       width: double.infinity,
                       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15), // Tambahkan padding kiri
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
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
