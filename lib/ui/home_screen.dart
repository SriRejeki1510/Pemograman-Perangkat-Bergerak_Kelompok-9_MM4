import 'package:flutter/material.dart';
import 'package:praktikum06/utils/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: Colors.red),
          ),
        ),
        title: Text("Hai, Gaga"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, rNotification);
            },
          ),
        ],
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
              onSubmitted: (query) {
                Navigator.pushNamed(
                  context,
                  rSearch,
                  arguments: query,
                );
              },
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Image.asset('assets/images/web_design.jpg', height: 150),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Image.asset('assets/images/biology.jpg', height: 150),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Image.asset('assets/images/php.jpg', height: 150),
                ),
              ],
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
                  Image.asset('assets/images/plant_biology.jpg', height: 150),
                  SizedBox(width: 10),
                  Image.asset('assets/images/web_design.jpg', height: 150),
                  SizedBox(width: 10),
                  Image.asset('assets/images/biology.jpg', height: 150),
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
                  Image.asset('assets/images/plant_biology.jpg', height: 150),
                  SizedBox(width: 10),
                  Image.asset('assets/images/web_design.jpg', height: 150),
                  SizedBox(width: 10),
                  Image.asset('assets/images/biology.jpg', height: 150),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
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
              Navigator.pushNamed(context, rGenre);
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
