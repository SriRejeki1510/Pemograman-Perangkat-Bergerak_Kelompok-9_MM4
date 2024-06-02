import 'package:flutter/material.dart';
import 'package:praktikum06/utils/routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
              padding: EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Colors.red),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fasha Agatha',
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
                    onPressed: () {
                      // Implementasi edit profil
                    },
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
              onPressed: () {
                // Navigasi ke halaman login
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  rLogin,
                  (Route<dynamic> route) => false,
                );
              },
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
