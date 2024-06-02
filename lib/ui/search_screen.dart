import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final String query;

  const SearchScreen({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Simulasikan hasil pencarian berdasarkan query
    final List<String> searchResults = [
      'Result for "$query" 1',
      'Result for "$query" 2',
      'Result for "$query" 3',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Pencarian'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(searchResults[index]),
            );
          },
        ),
      ),
    );
  }
}
