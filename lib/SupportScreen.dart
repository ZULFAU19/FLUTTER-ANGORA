import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        title: const Text(
          'Support Malang',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              height: 200, // Tinggi header
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/balai.jpg'), // Path gambar
                  fit: BoxFit.cover, // Gambar memenuhi kotak
                ),
              ),
              child: Container(
                // Overlay warna biru transparan
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end, // Teks di bawah
                  children: const [
                    Text(
                      "Support Malang",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Bersama Membangun Pariwisata Halal yang Berkelanjutan",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Pentahelix Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "YUK SUPPORT BERSAMA!",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap:
                        true, // Penting agar tidak mengambil tinggi penuh
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _buildPentahelixCard(
                        context,
                        title: "Pemerintah",
                        description: "Kebijakan.",
                        icon: FontAwesomeIcons.building,
                        color: Colors.blueAccent,
                      ),
                      _buildPentahelixCard(
                        context,
                        title: "Akademisi",
                        description: "Inovasi halal.",
                        icon: FontAwesomeIcons.graduationCap,
                        color: Colors.deepPurpleAccent,
                      ),
                      _buildPentahelixCard(
                        context,
                        title: "Komunitas",
                        description: "Dukung Rakyat",
                        icon: FontAwesomeIcons.users,
                        color: Colors.orangeAccent,
                      ),
                      _buildPentahelixCard(
                        context,
                        title: "Bisnis",
                        description: "Kolaborasi UMKM.",
                        icon: FontAwesomeIcons.briefcase,
                        color: Colors.teal,
                      ),
                      _buildPentahelixCard(
                        context,
                        title: "Media",
                        description: "Promosi",
                        icon: FontAwesomeIcons.newspaper,
                        color: Colors.redAccent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Call to Action Section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    "Ayo Bersama Kita Majukan Malang!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.phone),
                        label: const Text("Hubungi Kami"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blueAccent,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.info),
                        label: const Text("Lihat Program"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPentahelixCard(BuildContext context,
      {required String title,
      required String description,
      required IconData icon,
      required Color color}) {
    return GestureDetector(
      onTap: () {
        // Tambahkan aksi navigasi jika diperlukan
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
