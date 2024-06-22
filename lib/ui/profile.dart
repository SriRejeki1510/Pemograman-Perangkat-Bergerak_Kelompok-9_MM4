import 'dart:io';
import 'package:flutter/material.dart';
import 'package:praktikum06/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = 'User';
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _getUsername();
  }

  Future<void> _getUsername() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        _username = userDoc['username'] ?? 'User';
      });
    }
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(
        context, rLogin); // Navigasi ke halaman login setelah logout
  }

  Future<void> _editProfile() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo),
                  title: Text('Edit Gambar'),
                  onTap: () {
                    Navigator.pop(context);
                    _selectImage();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit Username'),
                  onTap: () {
                    Navigator.pop(context);
                    _editUsername();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final originalImage = img.decodeImage(await pickedFile.readAsBytes());
      if (originalImage != null) {
        final resizedImage =
            img.copyResize(originalImage, width: 50, height: 50);
        final resizedImageFile = File(pickedFile.path)
          ..writeAsBytesSync(img.encodeJpg(resizedImage));

        setState(() {
          _imageFile = resizedImageFile;
        });
      }
    }
  }

  Future<void> _editUsername() async {
    String newUsername = _username;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Username'),
          content: TextField(
            onChanged: (value) {
              newUsername = value;
            },
            controller: TextEditingController(text: _username),
            decoration: InputDecoration(hintText: "Enter new username"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () async {
                Navigator.of(context).pop();
                if (newUsername.isNotEmpty) {
                  User? user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.uid)
                        .update({'username': newUsername});
                    setState(() {
                      _username = newUsername;
                    });
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              padding:
                  EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : AssetImage('assets/images/icon_default_profil.png')
                            as ImageProvider,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _username,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Lihat Akun',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.white),
                    onPressed: _editProfile,
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ProfileMenuItem(
                    icon: Icons.history,
                    text: 'Bacaan Terakhir',
                    onTap: () {
                      // Implementasi navigasi
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.help,
                    text: 'Bantuan',
                    onTap: () {
                      // Implementasi navigasi
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.info,
                    text: 'Tentang Kami',
                    onTap: () {
                      // Implementasi navigasi
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.contact_mail,
                    text: 'Kontak Masuk',
                    onTap: () {
                      // Implementasi navigasi
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.settings,
                    text: 'Pengaturan',
                    onTap: () {
                      // Implementasi navigasi
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signOut,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffEC2425),
                minimumSize: Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                side: BorderSide(color: Colors.red),
              ),
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Genre',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: 3, // Set index sesuai dengan halaman saat ini
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, rHome);
              break;
            case 1:
              // Tambahkan logika untuk halaman genre
              break;
            case 2:
              Navigator.pushNamed(context, rFavorite);
              break;
            case 3:
              Navigator.pushNamed(context, rProfile);
              break;
          }
        },
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const ProfileMenuItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[200],
        child: Icon(icon, color: Colors.grey),
      ),
      title: Text(text),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
