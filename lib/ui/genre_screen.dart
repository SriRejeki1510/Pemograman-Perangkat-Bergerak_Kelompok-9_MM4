import 'package:flutter/material.dart';
import 'package:praktikum06/utils/routes.dart';

class GenreScreen extends StatelessWidget {
  const GenreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genre'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ChoiceChip(
                  label: Text('Genre 1'),
                  selected: true,
                  onSelected: (selected) {},
                  backgroundColor: Colors.red,
                  selectedColor: Colors.red,
                  labelStyle: TextStyle(color: Colors.white),
                ),
                SizedBox(width: 10),
                ChoiceChip(
                  label: Text('Genre 2'),
                  selected: false,
                  onSelected: (selected) {},
                ),
                SizedBox(width: 10),
                ChoiceChip(
                  label: Text('Lainnya'),
                  selected: false,
                  onSelected: (selected) {},
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Image.asset('assets/images/web_design.jpg', height: 150),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Image.asset('assets/images/php.jpg', height: 150),
                ),
              ],
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
