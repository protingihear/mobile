// profile.dart

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProfile {
  String name;
  String bio;
  String imageUrl;
  List<String> emails;
  String gender;

  UserProfile({
    required this.name,
    required this.bio,
    required this.imageUrl,
    required this.emails,
    required this.gender,
  });
}

Future<UserProfile> fetchUserProfile() async {
  // Simulate network delay
  await Future.delayed(const Duration(seconds: 2));
  // Mock data that will be replaced with database logic later
  return UserProfile(
    name: 'Naraya Anggraini',
    bio: '"Tetap Semangat"',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQo3Tluvszvh74irLX8BNvpIWXCdrPk5cjZ2Q&s',
    emails: ['naraya@gmail.com', 'naraya2@gmail.com'],
    gender: 'Perempuan',
  );
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<UserProfile> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = fetchUserProfile();
  }

  void _updateProfile(UserProfile updatedProfile) {
    setState(() {
      _profileFuture =
          Future.value(updatedProfile); // Update profile with new data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<UserProfile>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading profile'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          }

          final profile = snapshot.data!;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileHeader(
                      profile: profile, onUpdateProfile: _updateProfile),
                  const SizedBox(height: 15),
                  AccountSettings(emails: profile.emails),
                  const SizedBox(height: 8),
                  const FAQAndLogoutButtons(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final UserProfile profile;
  final Function(UserProfile) onUpdateProfile;

  const ProfileHeader(
      {Key? key, required this.profile, required this.onUpdateProfile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(profile.imageUrl),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.name,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 4),
                Text(
                  profile.bio,
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Text(
                  'Gender: ${profile.gender}',
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () async {
                    final updatedProfile = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(profile: profile),
                      ),
                    );
                    if (updatedProfile != null) {
                      onUpdateProfile(updatedProfile); // Update profile
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                  child: const Center(
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AccountSettings extends StatefulWidget {
  final List<String> emails;

  const AccountSettings({Key? key, required this.emails}) : super(key: key);

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.settings, color: Colors.green),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Pengaturan Akun',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  _isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: Colors.green,
                ),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
              ),
            ],
          ),
          if (_isExpanded)
            Column(
              children:
                  widget.emails.map((email) => EmailRow(email: email)).toList(),
            ),
        ],
      ),
    );
  }
}

class EmailRow extends StatelessWidget {
  final String email;

  const EmailRow({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              email,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.green),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class FAQAndLogoutButtons extends StatelessWidget {
  const FAQAndLogoutButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          tileColor: Colors.green.shade100,
          leading: const Icon(Icons.help, color: Colors.green),
          title: const Text(
            'FAQ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 8),
        ListTile(
          tileColor: Colors.green.shade100,
          leading:
              const Icon(Icons.logout, color: Color.fromARGB(255, 239, 0, 0)),
          title: const Text(
            'Log Out',
            style: TextStyle(
              color: Color.fromARGB(255, 255, 17, 0),
              fontWeight: FontWeight.bold,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onTap: () {},
        ),
      ],
    );
  }
}

class EditProfilePage extends StatefulWidget {
  final UserProfile profile;

  const EditProfilePage({Key? key, required this.profile}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController bioController;
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.profile.name);
    bioController = TextEditingController(text: widget.profile.bio);
    selectedGender = widget.profile.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  labelText: 'Name', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: bioController,
              decoration: const InputDecoration(
                  labelText: 'Bio', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text("Gender: "),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Perempuan'),
                    value: 'Perempuan',
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Laki-Laki'),
                    value: 'Laki-Laki',
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  UserProfile(
                    name: nameController.text,
                    bio: bioController.text,
                    imageUrl: widget.profile.imageUrl,
                    emails: widget.profile.emails,
                    gender: selectedGender ?? widget.profile.gender,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
