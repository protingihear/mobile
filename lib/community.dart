import 'package:bisadenger/chatRelasi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  int selectedIndex = 0; // index utk subPage

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

              // Iseng We
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
                      // kontenPostinganPadding: EdgeInsets.symmetric(vertical: 10),
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
                      _buildCommunityCard('Komunitas Harmoni',
                          'assets/imagesComm/ilustrasi1.png'),
                      _buildCommunityCard('Komunitas Isyarat Kita',
                          'assets/imagesComm/ilustrasi2.png'),
                      _buildCommunityCard('Komunitas Kita Isyarat',
                          'assets/imagesComm/ilustrasi1.png'),
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
                      InkWell(
                        child: ButtonRelations(
                          icon: Icons.group,
                          label: 'Community',
                          color: selectedIndex == 0
                              ? Color(0xFF499CB1) // Warna saat dipilih
                              : Color(0xFF8EC5D2), // Warna default
                          iconColor: Colors.white,
                          BgColor: Color(0xFF195728),
                        ),
                        onTap: () {
                          setState(() {
                            selectedIndex = 0;
                          });
                        },
                      ),
                      const SizedBox(width: 20),
                      InkWell(
                        child: ButtonRelations(
                          icon: Icons.person,
                          label: 'My Activity',
                          color: selectedIndex == 1
                              ? Color(0xFF499CB1) // Warna saat dipilih
                              : Color(0xFF8EC5D2), // Warna default
                          iconColor: Color(0xFF195728),
                          BgColor: Color(0xFFBAE1C4),
                        ),
                        onTap: () {
                          setState(() {
                            selectedIndex = 1;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.6, // Atur ukuran sesuai kebutuhan
                child: IndexedStack(
                  index: selectedIndex,
                  children: [
                    PostList(),
                    SubPageRelasi(),
                  ],
                ),
              ),
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

// MENU RELATIONS
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
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15)),
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

// LikeButton
class LikeButton extends StatefulWidget {
  const LikeButton({super.key});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Color(0xFF175260),
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
  }
}

List<Map<String, dynamic>> posts = [];

// SUB PAGE COMMUNITY
class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    final url = Uri.parse('http://localhost:8000/api/postingan');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          posts = data.map((e) => e as Map<String, dynamic>).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              const SizedBox(height: 5),
              const Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 1,
                endIndent: 1,
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    final String imageUrl =
                        'http://localhost:8000/storage/${post["image"]}';

                    print('Loading image: $imageUrl'); // Debug log
                    return Column(
                      children: [
                        Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          color: const Color(0xFFDEF5E4),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: Color(0xFFED9A82),
                                      radius: 20,
                                      child: Icon(Icons.person,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      post["username"] ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(post["kontenPostingan"] ?? ''),
                                const SizedBox(height: 10),
                                post["image"] != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          post['image'] != null
                                              ? 'http://localhost:8000/storage/${post["image"]}'
                                              : 'https://via.placeholder.com/150', // Gambar placeholder jika field kosong
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Text(
                                              'Image not available',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            );
                                          },
                                        ),
                                      )
                                    : const SizedBox(),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.favorite,
                                        color: Colors.green),
                                    const SizedBox(width: 5),
                                    Text(post["likes"]?.toString() ?? '0'),
                                    const SizedBox(width: 20),
                                    const Icon(Icons.comment,
                                        color: Colors.green),
                                    const SizedBox(width: 5),
                                    Text(post["comments"]?.toString() ?? '0'),
                                    const SizedBox(width: 20),
                                    const Icon(Icons.share,
                                        color: Colors.green),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
  }
}

// BELUM FIX
class pilihanMenu extends StatelessWidget {
  final String choose;

  pilihanMenu({required this.choose});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            const SizedBox(width: 20),
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
    );
  }
}

// SUB PAGE RELASI / CHAT (BELUM FIX)
class SubPageRelasi extends StatefulWidget {
  const SubPageRelasi({super.key});

  @override
  State<SubPageRelasi> createState() => _SubPageRelasiState();
}

class _SubPageRelasiState extends State<SubPageRelasi> {
  int selectedIndexSubPage = 0; // index utk subPage MyActivity

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 400,
      child: Column(
        children: [
          // ACTION BUTTON SUB PAGE
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndexSubPage = 0;
                    });
                  },
                  child: Icon(
                    Icons.chat,
                    size: 30,
                    color: selectedIndexSubPage == 0
                        ? Colors.blue // Warna saat dipilih
                        : Colors.grey, // Warna default
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndexSubPage = 1;
                    });
                  },
                  child: Icon(
                    Icons.add,
                    size: 30,
                    color: selectedIndexSubPage == 1
                        ? Colors.blue // Warna saat dipilih
                        : Colors.grey, // Warna default
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndexSubPage = 2;
                    });
                  },
                  child: Icon(
                    Icons.notification_add,
                    size: 30,
                    color: selectedIndexSubPage == 2
                        ? Colors.blue // Warna saat dipilih
                        : Colors.grey, // Warna default
                  ),
                )
              ],
            ),
          ),
          // Garis pemisah laman menu Button Community dan Menu MyActivity
          const SizedBox(
            height: 5,
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 1,
            endIndent: 1,
          ),
          const SizedBox(height: 25),

          Expanded(
              child: IndexedStack(
            index: selectedIndexSubPage,
            children: [
              BaganRelasiStart(),
              BaganAktivitas(),
              SubPageNotification()
            ],
          ))
        ],
      ),
    );
  }
}

// SUB PAGE AKTIVITAS (BELUM FIX)
class BaganAktivitas extends StatelessWidget {
  const BaganAktivitas({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: Column(
        children: [
          SizedBox(height: 40),
          const Text(
            "Bagi Aktivitas Kamu",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Poppins'),
          ),
          SizedBox(height: 25),
          const Text(
              "Saat anda membagikan postingan, akan muncul di aktivitas anda",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  color: Color(0xFFBABABA)))
        ],
      ),
    );
  }
}

// class BaganRelasiStart extends StatefulWidget {
//   const BaganRelasiStart({super.key});

//   @override
//   State<BaganRelasiStart> createState() => _BaganRelasiStartState();
// }

// class _BaganRelasiStartState extends State<BaganRelasiStart> {
//   // Fungsi untuk menangani navigasi ke laman ChatRelasi
//   void _navigateToChat(BuildContext context, String name) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => CommunityPostPage(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.only(top: 20),
//         child: ListView(
//           children: [
//             GestureDetector(
//               onTap: () => _navigateToChat(context, "Puri Lalita Anagata"),
//               child: const ActivityItem(
//                 name: "Puri Lalita Anagata",
//                 message: "Hai Naraya",
//                 time: "09.00",
//                 isOnline: true,
//                 imagePath: "assets/images/avatar1.png",
//                 unreadCount: 1,
//               ),
//             ),
//             GestureDetector(
//               onTap: () => _navigateToChat(context, "Fajar Mufid"),
//               child: const ActivityItem(
//                 name: "Fajar Mufid",
//                 message: "Kabarku baik",
//                 time: "10.00",
//                 isOnline: true,
//                 imagePath: "assets/images/avatar2.png",
//               ),
//             ),
//             GestureDetector(
//               onTap: () => _navigateToChat(context, "Arga Adolf"),
//               child: const ActivityItem(
//                 name: "Arga Adolf",
//                 message: "Aku distasiun",
//                 time: "10.00",
//                 isOnline: false,
//                 imagePath: "assets/images/avatar3.png",
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class BaganRelasiStart extends StatefulWidget {
  const BaganRelasiStart({super.key});

  @override
  State<BaganRelasiStart> createState() => _BaganRelasiStartState();
}

class _BaganRelasiStartState extends State<BaganRelasiStart> {
  List<dynamic> chatItems = [];

  @override
  void initState() {
    super.initState();
    fetchChats();
  }

  Future<void> fetchChats() async {
    final url = Uri.parse(
        'http://localhost:8000/api/chat'); // Sesuaikan dengan URL API Anda
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          chatItems = json.decode(response.body);
        });
      } else {
        print('Failed to load chats');
      }
    } catch (error) {
      print('Error fetching chats: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
      ),
      body: chatItems.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: chatItems.length,
              itemBuilder: (context, index) {
                final chat = chatItems[index];
                return FutureBuilder(
                  future: fetchLastMessage(chat['id']),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListTile(
                        title: Text("Loading..."),
                      );
                    }

                    final lastMessage = snapshot.data as Map<String, dynamic>;

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.purple.shade100,
                        child: Text(
                          chat['user1_id']
                              .toString(), // Bisa diganti sesuai data
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        "${chat['username']}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle:
                          Text(lastMessage['content'] ?? "No messages yet"),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            lastMessage['sent_at']?.toString() ??
                                "Unknown time",
                            style: TextStyle(color: Colors.grey),
                          ),
                          if (lastMessage['status'] == 'unread')
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                "1",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                      onTap: () {
                        // Navigate to chatRelasi.dart
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommunityPostPage()),
                        );
                      },
                    );
                  },
                );
              },
            ),
    );
  }

  Future<Map<String, dynamic>> fetchLastMessage(int chatId) async {
    // final url = Uri.parse('http://localhost:8000/api/message?chat_id=$chatId');
    final url = Uri.parse('http://localhost:8000/api/message?chat_id=$chatId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final messages = json.decode(response.body) as List;
        if (messages.isNotEmpty) {
          return messages.last;
        }
      }
    } catch (error) {
      print('Error fetching last message: $error');
    }
    return {};
  }
}

class ActivityItem extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final bool isOnline;
  final String imagePath;
  final int unreadCount;

  const ActivityItem({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    this.isOnline = false,
    required this.imagePath,
    this.unreadCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(imagePath),
      ),
      title: Text(name),
      subtitle: Text(message),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time),
          if (unreadCount > 0)
            Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                unreadCount.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}

// SUB PAGE AKTIVITAS (kalau kosong no chatan)
// class BaganRelasiStart extends StatelessWidget {
//   const BaganRelasiStart({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: 300,
//       child: Column(
//         children: [
//           SizedBox(height: 40),
//           const Text(
//             "Tambah Relasi Kamu!",
//             style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//                 fontFamily: 'Poppins'),
//           ),
//           SizedBox(height: 25),
//           SizedBox(
//             width: 300,
//             height: 200,
//             child: const Text(
//                 "Saat anda bertukar pesan, akan muncul di aktivitas pesan anda",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontFamily: 'Poppins',
//                     color: Color(0xFFBABABA))),
//           )
//         ],
//       ),
//     );
//   }
// }

// SUB PAGE NOTIFIKASI (KALAU LAGI GADA NOTIFIKASI)
// class SubPageNotification extends StatelessWidget {
//   const SubPageNotification({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: 300,
//       child: Column(
//         children: [
//           SizedBox(height: 40),
//           SizedBox(
//             width: 250,
//             height: 100,
//             child: const Text(
//               "Belum ada notifikasi untuk kamu!",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                   fontFamily: 'Poppins'),
//             ),
//           ),
//           SizedBox(height: 25),
//         ],
//       ),
//     );
//   }
// }

class SubPageNotification extends StatelessWidget {
  const SubPageNotification({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data notifikasi
    final notifications = [
      {
        'name': 'Puri Lalita Anagata',
        'action': 'Send your message.',
        'time': '1h',
        'section': 'Today'
      },
      {
        'name': 'Fajar Mufid',
        'action': 'Like your post.',
        'time': '2h',
        'section': 'Today'
      },
      {
        'name': 'Puri Lalita Anagata',
        'action': 'Comment your post.',
        'time': '1h',
        'section': 'Yesterday'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: ListView(
        children: [
          // Membagi notifikasi menjadi berdasarkan "section"
          ...['Today', 'Yesterday'].map((section) {
            final sectionNotifications =
                notifications.where((n) => n['section'] == section).toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    section,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Column(
                  children: sectionNotifications.map((notification) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(notification['name'] ?? ""),
                      subtitle: Text(notification['action'] ?? ""),
                      trailing: Text(notification['time'] ?? ""),
                    );
                  }).toList(),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
