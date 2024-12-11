import 'package:flutter/material.dart';

class DynamicPage extends StatelessWidget {
  final String title;
  final String content;

  const DynamicPage({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title), // Menampilkan judul halaman yang diinput pengguna
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title, // Tampilkan judul
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              content, // Tampilkan konten
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
