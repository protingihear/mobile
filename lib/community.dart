import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Back button dan teks 'Relations'
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.green[100],
                      radius: 20,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          // Add functionality here
                        },
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      "Relations",
                      style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),

              // Serch Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.87,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                      prefixIcon: Icon(Icons.search, color: Colors.blue),
                      border: InputBorder.none,
                      // contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ),

              // Teks Community
              const Padding(
                padding: EdgeInsets.only(left: 30, top: 10),
                child: Row(
                  children: [
                    Text(
                      "Community",
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 17),
                    ),
                  ],
                ),
              ),

              // Menu Community dengan mode scroll Horizontal
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 26),
                child: SizedBox(
                  height: 150, // Set a fixed height for the row
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildCommunityCard(
                          'Komunitas Harmoni', 'images/ilustrasi1.png'),
                      _buildCommunityCard(
                          'Komunitas Isyarat Kita', 'images/ilustrasi2.png'),
                      _buildCommunityCard(
                          'Komunitas Kita Isyarat', 'images/ilustrasi1.png'),
                    ],
                  ),
                ),
              ),

              // Button Community dan Menu MyActivity
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonRelations(
                        icon: Icons.group,
                        label: 'Community',
                        color: Color(0xFF499CB1),
                        iconColor: Colors.white,
                        BgColor: Color(0xFF195728),
                      ),
                      SizedBox(width: 20),
                      ButtonRelations(
                        icon: Icons.person,
                        label: 'My Activity',
                        color: Color(0xFF8EC5D2),
                        iconColor: Color(0xFF195728),
                        BgColor: Color(0xFFBAE1C4),
                      ),
                    ],
                  ),
                ),
              ),

              // Garis pemisah laman menu Button Community dan Menu MyActivity
              const Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 1,
                endIndent: 1,
              ),

              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    color: Colors.red,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 152,
                      decoration: BoxDecoration(
                        color: Color(0xFFDEF5E4),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20),
                            child: CircleAvatar(
                              backgroundColor: Color(0xFFED9A82),
                              radius: 20,
                              child: IconButton(
                                icon: const Icon(Icons.person),
                                onPressed: () {
                                  // Add functionality here
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Menu Community
  Widget _buildCommunityCard(String judul, String imagePath) {
    return Container(
      width: 135,
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xFFDEF5E4), // Greenish background
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFFCCEBD4), // Red inner container
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              child: Image.asset(imagePath),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              judul,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonRelations extends StatelessWidget {
  // const ButtonRelations({super.key});
  final IconData icon;
  final String label;
  final Color color;
  final Color? iconColor;
  final Color BgColor;

  ButtonRelations(
      {required this.icon,
      required this.label,
      required this.color,
      this.iconColor,
      required this.BgColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        // Container untuk button utama
        Container(
          padding: EdgeInsets.symmetric(horizontal: 37, vertical: 21),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(label,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        Positioned(
          top: -13,
          left: 20,
          child: CircleAvatar(
            backgroundColor: BgColor,
            radius: 14,
            child: Icon(icon, color: iconColor, size: 16),
          ),
        )
      ],
    );
  }
}

//         child: SingleChildScrollView(
//           child: Column(
//             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // Untuk Per elemen desainnya
//               Column(
//                 children: [
//                   // Untuk back button dan teks Relations
//                   // Belum responsive di tengah
//                   Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 20, left: 20),
//                         child: CircleAvatar(
//                           backgroundColor: Colors
//                               .green[100], // Warna latar belakang hijau muda
//                           radius: 20,
//                           child: IconButton(
//                             icon: Icon(Icons.arrow_back), // Ikon panah kiri
//                             onPressed: () {
//                               // Tambahkan fungsionalitas saat tombol ditekan di sini
//                             },
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 17, left: 100),
//                         child: Text(
//                           "Relations",
//                           style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
//                         ),
//                       )
//                     ],
//                   ),
//                   // Button search
//                   Row(
//                     children: [
//                       Container(
//                         margin: const EdgeInsets.symmetric(vertical: 20),
//                         width: MediaQuery.of(context).size.width,
//                         height: 35,
//                         child: Center(
//                           child: Container(
//                             width: 350,
//                             height: 35,
//                             decoration: BoxDecoration(
//                               color: Colors.white, // warna background
//                               borderRadius:
//                                   BorderRadius.circular(20), // bentuk rounded
//                               border: Border.all(
//                                   color: Colors
//                                       .blueAccent), // border dengan warna biru
//                             ),
//                             child: const TextField(
//                               decoration: InputDecoration(
//                                 hintText: 'Search',
//                                 hintStyle:
//                                     TextStyle(color: Colors.grey, fontSize: 18),
//                                 prefixIcon:
//                                     Icon(Icons.search, color: Colors.blue),
//                                 border: InputBorder.none,
//                                 contentPadding:
//                                     EdgeInsets.symmetric(vertical: 10),
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   // Text Community
//                   Row(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(left: 20),
//                         child: Text(
//                           "Community",
//                           style: TextStyle(fontFamily: 'Poppins', fontSize: 17),
//                         ),
//                       ),
//                     ],
//                   ),
//                   // Menu Community
//                   Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 15, left: 15),
//                         child: SizedBox(
//                           height: 100, // Set a fixed height for the row
//                           child: ListView(
//                             scrollDirection: Axis.horizontal,
//                             children: [
//                               _buildCommunityCard(),
//                               _buildCommunityCard(),
//                               _buildCommunityCard(),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 15, left: 15),
//                     child: SizedBox(
//                       height: 100, // Set a fixed height for the row
//                       child: ListView(
//                         scrollDirection: Axis.horizontal,
//                         children: [
//                           _buildCommunityCard(),
//                           _buildCommunityCard(),
//                           _buildCommunityCard(),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Column(
//                 children: [],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCommunityCard() {
//     return Container(
//       width: 127,
//       height: 86,
//       margin: const EdgeInsets.only(right: 15),
//       decoration: BoxDecoration(
//         color: Color(0xFFCCEBD4),
//         borderRadius: BorderRadius.circular(16),
//       ),
//     );
//   }
// }
