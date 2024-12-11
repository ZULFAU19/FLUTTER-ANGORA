import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'PeopleScreen.dart';
import 'DestinationDetailScreen.dart';
import 'SettingsScreen.dart';
import 'WelcomeScreen.dart';
import 'BeachScreen.dart';
import 'ForestScreen.dart';
import 'MountainScreen.dart';
import 'DesertScreen.dart';
import 'QiblatScreen.dart';
import 'RestaurantScreen.dart';
import 'NewsScreen.dart';
import 'HotelScreen.dart';
import 'TransportasiScreen.dart';
import 'SupportScreen.dart';
import 'EventScreen.dart';
import 'HalalMarket.dart';

void main() {
  runApp(const TravelApp());
}

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Halal Tourism App',
      theme: ThemeData(
        brightness: Brightness.light, // Ganti ke tema terang
        primaryColor: Colors.blue, // Tetapkan warna utama menjadi biru
        scaffoldBackgroundColor: Colors.white, // Background aplikasi putih
        useMaterial3: true,
      ),

      home:
          const WelcomeScreen(), // Tampilkan WelcomeScreen sebagai layar pertama
      routes: {
        '/destinationDetail': (context) => const DestinationDetailScreen(),
        '/beach': (context) => const BeachScreen(), // Rute untuk waktu sholat
        '/forest': (context) => ForestScreen(), // Rute untuk Forest
        '/mountain': (context) => const MountainScreen(), // Rute untuk Mountain
        '/desert': (context) => DesertScreen(), // Rute untuk Desert
        '/qiblat': (context) => const QiblatScreen(), // Rute untuk Qiblat
        '/restaurant': (context) =>
            const RestaurantScreen(), // Rute untuk Restaurant
        '/news': (context) => const NewsScreen(), // Rute untuk News
        '/hotel': (context) => const HotelScreen(), // Rute untuk Hotel
        '/transportation': (context) => TransportasiScreen(),
        '/support': (context) => const SupportScreen(),
        '/event': (context) => const EventScreen(),
        '/halal_market': (context) => HalalMarketPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Daftar halaman yang akan ditampilkan pada setiap tab
  final List<Widget> _pages = [
    const HomeScreen(), // Halaman Home
    const PeopleScreen(), // Halaman About/People
    const SettingsScreen(), // Halaman Settings baru
  ];

  // Fungsi untuk menangani perubahan tab
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Menampilkan halaman sesuai index
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Index tab yang dipilih
        onTap: _onItemTapped, // Panggil saat tab dipilih
        backgroundColor:
            const Color.fromARGB(255, 61, 155, 255), // Background hitam
        selectedItemColor: Colors.white, // Warna item yang dipilih putih
        unselectedItemColor:
            Colors.grey, // Warna item yang tidak dipilih abu-abu
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
