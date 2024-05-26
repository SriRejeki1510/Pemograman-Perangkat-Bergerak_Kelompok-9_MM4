import 'package:flutter/material.dart';
import 'package:praktikum06/utils/routes.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorit'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Disukai'),
            Tab(text: 'Telah dibaca'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          LikedBooks(),
          ReadBooks(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: const [
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
              // Sudah berada di halaman favorit, tidak perlu navigasi ulang
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

class LikedBooks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset('assets/images/web_design.jpg', height: 150),
    );
  }
}

class ReadBooks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Belum ada buku yang telah dibaca.'),
    );
  }
}
