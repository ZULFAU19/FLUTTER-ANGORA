import 'package:flutter/material.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  // Daftar opsi restoran dan gambar
  final List<Map<String, String>> _restaurants = [
    {
      'name': 'Shawarma Express',
      'image': 'images/burger.jpeg',
    },
    {
      'name': 'Sate Madura',
      'image': 'images/sate.jpg',
    },
    {
      'name': 'Soto Khas Lamongan',
      'image': 'images/soto.jpg',
    },
    {
      'name': 'Kebab Malang',
      'image': 'images/kebab.jpg',
    },
  ];

  String? _selectedRestaurant; // Restoran yang dipilih
  List<String> _favoriteRestaurants = []; // To-do list restoran favorit

  @override
  void initState() {
    super.initState();
  }

  // Fungsi untuk menambah restoran ke daftar favorit
  void _addFavoriteRestaurant() {
    if (_selectedRestaurant != null &&
        !_favoriteRestaurants.contains(_selectedRestaurant)) {
      setState(() {
        _favoriteRestaurants.add(_selectedRestaurant!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant"),
        backgroundColor: const Color.fromARGB(255, 0, 242, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.restaurant,
              size: 100,
              color: Color.fromARGB(255, 7, 33, 163),
            ),
            const SizedBox(height: 20),
            const Text(
              "Choose Your Favorite Restaurant",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const SizedBox(height: 20),

            // DropdownButton untuk memilih restoran
            DropdownButton<String>(
              hint: const Text("Select a restaurant"),
              value: _selectedRestaurant,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              underline: Container(
                height: 2,
                color: Colors.blueAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRestaurant = newValue;
                });
              },
              items: _restaurants.map<DropdownMenuItem<String>>((restaurant) {
                return DropdownMenuItem<String>(
                  value: restaurant['name'],
                  child: Row(
                    children: [
                      Image.asset(
                        restaurant['image']!,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 10),
                      Text(restaurant['name']!),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Tombol untuk menambah ke daftar favorit
            ElevatedButton.icon(
              onPressed: _addFavoriteRestaurant,
              icon: const Icon(Icons.favorite),
              label: const Text("Add to Favorite List"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 155, 161, 174),
              ),
            ),
            const SizedBox(height: 20),

            // Menampilkan daftar restoran favorit
            Expanded(
              child: _favoriteRestaurants.isEmpty
                  ? const Center(child: Text('No favorite restaurants yet.'))
                  : ListView.builder(
                      itemCount: _favoriteRestaurants.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            leading: const Icon(Icons.restaurant,
                                color: Color.fromARGB(255, 0, 0, 0)),
                            title: Text(_favoriteRestaurants[index]),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
