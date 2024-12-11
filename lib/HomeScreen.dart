import 'package:flutter/material.dart';
import 'PeopleScreen.dart'; // Halaman People
import 'SettingsScreen.dart'; // Halaman Settings
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Tambahan icon

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;
  String _searchQuery = '';

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(), // Konten HomePage
    const PeopleScreen(), // Halaman About/People
    const SettingsScreen(), // Halaman Settings
  ];

  // Fungsi untuk menangani navigasi BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigasi langsung ke PeopleScreen dan SettingsScreen berdasarkan index
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PeopleScreen()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white, // Latar belakang putih
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), // Sudut melengkung kiri atas
            topRight: Radius.circular(30), // Sudut melengkung kanan atas
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey, // Bayangan
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, -2), // Posisi bayangan
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            backgroundColor: Colors.blue, // Background biru
            selectedItemColor: Colors.white, // Item yang dipilih putih
            unselectedItemColor: const Color.fromARGB(
                255, 22, 20, 82), // Item tidak dipilih abu-abu
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
        ),
      ),
      body: Stack(
        children: [
          // Background gradient biru
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.lightBlue,
                  Color.fromARGB(255, 24, 57, 147)
                ], // Gradien biru
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            height: MediaQuery.of(context)
                .size
                .height, // Latar gradien sampai bawah
          ),
          // Konten utama dengan background putih melengkung di atasnya
          SingleChildScrollView(
            child: Column(
              children: [
                // Bagian atas mirip dengan AppBar
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Welcome Mr. Rudi", // Ubah teks salam
                            style: TextStyle(
                              color: Colors.white, // Warna putih seperti contoh
                              fontSize: 24, // Ukuran font besar
                              fontWeight: FontWeight.bold, // Teks tebal
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Smart Way in Malang", // Subjudul di bawah salam
                            style: TextStyle(
                              color: Colors.white70, // Warna abu-abu muda
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      // Ikon profil di sebelah kanan
                      const CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage(
                            'images/driver_profile.png'), // Ganti dengan gambar profil
                      ),
                    ],
                  ),
                ),

                // Container utama dengan sudut melengkung atas (tampilkan konten di sini)
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white, // Background putih
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ), // Sudut melengkung hanya di bagian atas
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container pencarian dengan sudut melengkung
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Background putih
                          borderRadius:
                              BorderRadius.circular(50), // Sudut melengkung
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 158, 158, 158)
                                  .withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 9), // Bayangan
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Search Destinations',
                            border: InputBorder.none,
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.grey),
                            suffixIcon:
                                const Icon(Icons.mic, color: Colors.grey),
                          ),
                          onChanged: (query) {
                            setState(() {
                              _searchQuery = query; // Update query search
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Kategori berbentuk bulat dengan scroll horizontal
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Baris pertama: gulir horizontal
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  buildCategoryButton('Waktu Sholat',
                                      Icons.access_time, '/beach'),
                                  const SizedBox(
                                      width: 16), // Jarak antar elemen
                                  buildCategoryButton(
                                      'Halal Food', Icons.food_bank, '/forest'),
                                  const SizedBox(width: 16),
                                  buildCategoryButton(
                                      'Mountain', Icons.landscape, '/mountain'),
                                  const SizedBox(width: 16),
                                  buildCategoryButton(
                                      'Al Quran', Icons.book, '/desert'),
                                  const SizedBox(width: 16),
                                  buildCategoryButton('Qiblat',
                                      FontAwesomeIcons.compass, '/qiblat'),
                                  const SizedBox(width: 16),
                                  buildCategoryButton('Restaurant',
                                      FontAwesomeIcons.utensils, '/restaurant'),
                                  const SizedBox(width: 16),
                                  buildCategoryButton('Berita',
                                      FontAwesomeIcons.newspaper, '/news'),
                                ],
                              ),
                            ),
                            const SizedBox(
                                height:
                                    16), // Jarak antara baris atas dan bawah
                            // Baris kedua: gulir horizontal
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  buildCategoryButton('Hotel',
                                      FontAwesomeIcons.hotel, '/hotel'),
                                  const SizedBox(width: 10),
                                  buildCategoryButton('Destination',
                                      Icons.location_pin, '/destination'),
                                  const SizedBox(width: 10),
                                  buildCategoryButton('Transportation',
                                      Icons.directions_bus, '/transportation'),
                                  const SizedBox(width: 10),
                                  buildCategoryButton(
                                      'Event', Icons.event, '/event'),
                                  const SizedBox(width: 10),
                                  buildCategoryButton('Support Malang',
                                      Icons.support, '/support'),
                                  const SizedBox(width: 10),
                                  buildCategoryButton('Halal Market',
                                      Icons.store, '/halal_market'),
                                  const SizedBox(width: 10),
                                  buildCategoryButton(
                                      'Community', Icons.people, '/community'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Select your next trip",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),

                      // List destinasi
                      SizedBox(
                        height: 300,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _filterDestinations().length,
                          itemBuilder: (context, index) {
                            var destination = _filterDestinations()[index];
                            return DestinationCard(
                              imagePath: destination['imagePath'],
                              location: destination['location'],
                              reviews: destination['reviews'],
                              rating: destination['rating'],
                            );
                          },
                        ),
                      ),

                      // Kategori filter makanan halal
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Select Halal Foods",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Wrap(
                          spacing: 12.0, // Jarak horizontal antar FilterChip
                          runSpacing:
                              8.0, // Jarak vertikal antar baris FilterChip
                          children: [
                            FilterChip(
                              label: const Text('Malang'),
                              onSelected: (value) {},
                            ),
                            FilterChip(
                              label: const Text('Batu'),
                              onSelected: (value) {},
                            ),
                            FilterChip(
                              label: const Text('Singosari'),
                              onSelected: (value) {},
                            ),
                            FilterChip(
                              label: const Text('Lawang'),
                              onSelected: (value) {},
                            ),
                          ],
                        ),
                      ),

                      // List makanan halal
                      SizedBox(
                        height: 300,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: const [
                            DestinationCard(
                              imagePath: 'images/burger.jpeg',
                              location: 'Shawarma, Batu',
                              reviews: 230,
                              rating: 4.9,
                            ),
                            DestinationCard(
                              imagePath: 'images/sate.jpg',
                              location: 'Sate, Madura',
                              reviews: 150,
                              rating: 4.7,
                            ),
                            DestinationCard(
                              imagePath: 'images/soto.jpg',
                              location: 'Soto, Malang',
                              reviews: 180,
                              rating: 4.8,
                            ),
                            DestinationCard(
                              imagePath: 'images/kebab.jpg',
                              location: 'Kebab, Bandung',
                              reviews: 180,
                              rating: 4.8,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk membuat kategori berbentuk bulat
  Widget buildCategoryButton(String label, IconData icon, String route) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman yang sesuai
        Navigator.pushNamed(context, route);
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  Colors.blueAccent.withOpacity(0.2), // Warna transparan biru
            ),
            child: Icon(
              icon,
              size: 30,
              color: Colors.blueAccent, // Warna ikon biru
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color.fromARGB(255, 27, 81, 174), // Warna teks biru
            ),
          ),
        ],
      ),
    );
  }

  // Daftar destinasi
  final List<Map<String, dynamic>> _destinations = [
    {
      'imagePath': 'images/agungmalang.jpg',
      'location': 'Masjid Agung Kota Malang',
      'reviews': 1433,
      'rating': 5.0,
    },
    {
      'imagePath': 'images/selecta.jpg',
      'location': 'Wisata Selecta',
      'reviews': 12000,
      'rating': 4.8,
    },
    {
      'imagePath': 'images/bunga.jpg',
      'location': 'Taman Kemesraan',
      'reviews': 899,
      'rating': 4.9,
    },
  ];

  // Filter destinasi berdasarkan pencarian
  List<Map<String, dynamic>> _filterDestinations() {
    if (_searchQuery.isEmpty) {
      return _destinations;
    } else {
      return _destinations
          .where((destination) => destination['location']
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()))
          .toList();
    }
  }
}

class DestinationCard extends StatelessWidget {
  final String imagePath;
  final String location;
  final int reviews;
  final double rating;

  const DestinationCard({
    super.key,
    required this.imagePath,
    required this.location,
    required this.reviews,
    required this.rating,
  });

  // Aksi ketika card diklik
  void _navigateToDetail(BuildContext context) {
    // Kirim data dinamis berdasarkan lokasi yang diklik

    Navigator.pushNamed(
      context,
      '/destinationDetail',
      arguments: {
        'imagePath': imagePath,
        'location': location, // Mengirimkan nama lokasi yang diklik
        'message':
            'Welcome to $location! ebuah kota di Jawa Timur, menawarkan beragam destinasi wisata menarik, mulai dari keindahan alam hingga tempat-tempat religi. Masjid Agung Kota Malang, merupakan salah satu destinasi halal yang wajib dikunjungi, dengan arsitektur megah dan nuansa religius yang khas, merupakan destinasi utama bagi wisatawan yang mencari ketenangan. Masjid ini memiliki desain yang indah dengan kombinasi gaya arsitektur tradisional dan modern, serta taman yang luas di sekelilingnya, menjadikannya tempat yang sempurna untuk beribadah dan beristirahat. Wisata Selecta menawarkan pemandangan luar biasa dari taman bunga yang asri, cocok untuk berlibur bersama keluarga. Selain itu, Taman Kemesraan memberikan suasana romantis dengan berbagai spot foto yang instagramable. Bagi pecinta kuliner, Batu menawarkan wisata makanan halal yang lezat, seperti sate, kebab, dan berbagai hidangan lokal lainnya. Jangan lewatkan wisata alam yang menakjubkan di Gunung Bromo yang hanya beberapa jam dari Malang.',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context), // Navigasi ke detail saat diklik
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.black.withOpacity(0.5),
                ),
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 16,
                            ),
                            Text(
                              "$rating",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Text(
                          "$reviews reviews",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
