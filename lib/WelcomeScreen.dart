import 'package:flutter/material.dart';
import 'HomeScreen.dart'; // Import HomeScreen untuk navigasi setelah klik "Go"

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  // Daftar halaman untuk PageView
  final List<Widget> _pages = [
    WelcomePage(
      title: "",
      subtitle: "",
      imagePath: 'images/dpn1.png', // Ganti dengan gambar Anda
    ),
    WelcomePage(
      title: "Discover New Places",
      subtitle: "Start your journey to beautiful destinations",
      imagePath: 'images/gunung.jpg', // Ganti dengan gambar Anda
    ),
    WelcomePage(
      title: "Make Memories",
      subtitle: "Capture every moment of your travel experience",
      imagePath: 'images/kudus.jpg', // Ganti dengan gambar Anda
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView untuk halaman geser
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _pages.length,
            itemBuilder: (context, index) => _pages[index],
          ),
          // Indikator halaman (dots)
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          // Tampilkan tombol "Go" hanya di halaman terakhir
          if (_currentPage == _pages.length - 1)
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // Navigasi ke HomeScreen setelah tombol Go diklik
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                child: Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_upward,
                        size: 36,
                        color: Color.fromARGB(255, 61, 155, 255),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun indikator halaman (dots)
  Widget buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.white : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

// Komponen untuk setiap halaman geser
class WelcomePage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const WelcomePage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image
        Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
        // Content (Title, Subtitle)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
