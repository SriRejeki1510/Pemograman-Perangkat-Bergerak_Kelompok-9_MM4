import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BookDetailScreen(),
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}

class BookDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Buku'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/web-design.png',
                    height: 250,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Web Desain with HTML and CSS',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () async {
                          },
                          child: Text('Baca'),
                          style: ElevatedButton.styleFrom(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Container(
                color: Colors.red,
                padding: EdgeInsets.all(16),
                child: Text(
                  'Web Design with HTML and CSS Digital Classroom\n'
                  'Published by\n'
                  'Wiley Publishing, Inc.\n'
                  '10475 Crosspoint Boulevard Indianapolis, IN 46256\n'
                  'Copyright © 2011 by Wiley Publishing, Inc., Indianapolis, Indiana\n'
                  'Published by Wiley Publishing, Inc., Indianapolis, Indiana\n'
                  'Published simultaneously in Canada\n'
                  'ISBN: 978-0-470-58360-9\n'
                  'Manufactured in the United States of America\n'
                  '10987654321',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        selectedItemColor: Colors.red,
      ),
    );
  }
}
