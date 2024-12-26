import 'package:flutter/material.dart';

void main() {
  runApp(const CommunityPostApp());
}

class CommunityPostApp extends StatelessWidget {
  const CommunityPostApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CommunityPostPage(),
    );
  }
}

class CommunityPostPage extends StatefulWidget {
  @override
  _CommunityPostPageState createState() => _CommunityPostPageState();
}

class _CommunityPostPageState extends State<CommunityPostPage> {
  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () {
            // Fungsi tombol back
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Community/Post',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Fungsi ketika tombol "Post" ditekan
              print("Posting: ${_textController.text}");
            },
            child: const Text(
              'Post',
              style: TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/profile_pic.png'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'What are you worried about?',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.photo, color: Colors.green),
                  onPressed: () {
                    // Fungsi ketika tombol gambar ditekan
                    print("Open gallery");
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.tag, color: Colors.green),
                  onPressed: () {
                    // Fungsi ketika tombol tagar ditekan
                    print("Add hashtag");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
