import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:praktikum06/utils/routes.dart'; // Pastikan routes.dart diimpor
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? Key}) : super(key: Key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _listdata = [];
  PageController _pageController =
      PageController(viewportFraction: 0.4, initialPage: 1);
  int _currentPage = 1;
  String _username = '';

  Future _getdata() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.18.24/flutterapi/read.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data;
        });
      }
    } catch (e) {
      // Handle error
    }
  }

  // Fungsi untuk mengambil username dari Firestore
  Future<void> _getUsername() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      if (doc.exists) {
        setState(() {
          _username = doc['username'];
        });
      }
    }
  }

  @override
  void initState() {
    _getdata();
    _getUsername();
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(236, 36, 37, 1.0),
            borderRadius: BorderRadius.only(
              bottomLeft:
                  Radius.circular(30.0), // Sesuaikan radius sesuai kebutuhan
              bottomRight:
                  Radius.circular(30.0), // Sesuaikan radius sesuai kebutuhan
            ),
          ),
          child: AppBar(
            backgroundColor:
                Colors.transparent, // Set backgroundColor to transparent
            elevation: 0, // Remove shadow
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child:
                    Icon(Icons.person, color: Color.fromRGBO(236, 36, 37, 1.0)),
              ),
            ),
            title: Text(
              "Hai, $_username",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.pushNamed(context, rNotification);
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari Buku...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 300, // Sesuaikan tinggi container sesuai kebutuhan
              child: PageView.builder(
                controller: _pageController,
                itemCount: 4, // Jumlah item yang ditampilkan
                itemBuilder: (context, index) {
                  double scale = index == _currentPage
                      ? 2.0
                      : 1.0; // Skala item di posisi tengah dua kali lebih besar
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 30.0), // Tambahkan jarak horizontal
                    child: Transform.scale(
                      scale: scale,
                      child: Container(
                        child: Image.asset(
                          _getImageAsset(
                              index), // Ganti dengan fungsi untuk mendapatkan path gambar
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Rekomendasi",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Image.asset('assets/images/plant-biology.png', height: 150),
                  SizedBox(width: 10),
                  Image.asset('assets/images/web-design.png', height: 150),
                  SizedBox(width: 10),
                  Image.asset('assets/images/biology.png', height: 150),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Untuk Kamu",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Image.asset('assets/images/plant-biology.png', height: 150),
                  SizedBox(width: 10),
                  Image.asset('assets/images/web-design.png', height: 150),
                  SizedBox(width: 10),
                  Image.asset('assets/images/biology.png', height: 150),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromRGBO(236, 36, 37, 1.0),
        items: [
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

  String _getImageAsset(int index) {
    List<String> images = [
      'assets/images/web-design.png',
      'assets/images/biology.png',
      'assets/images/php-mysql-javascript-html.png',
      'assets/images/plant-biology.png'
    ];
    return images[index % images.length];
  }
}
