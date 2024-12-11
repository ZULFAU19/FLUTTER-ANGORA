import 'package:flutter/material.dart';

class DestinationDetailScreen extends StatelessWidget {
  const DestinationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil argumen yang diteruskan dari halaman sebelumnya
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final String imagePath = args['imagePath']; // Gambar destinasi
    final String location = args['location']; // Nama lokasi
    final String message = args['message']; // Pesan selamat datang

    return Scaffold(
      appBar: AppBar(
        title: Text(location),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Gambar destinasi
            Image.asset(
              imagePath,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            // Informasi lokasi dan pesan
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            // Tombol kembali ke halaman sebelumnya
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Kembali ke halaman sebelumnya
                },
                child: const Text('Back'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
