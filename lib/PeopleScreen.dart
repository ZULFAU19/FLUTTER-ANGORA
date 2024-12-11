import 'package:flutter/material.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({super.key});

  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  final List<Map<String, String>> _travelers = []; // Daftar travelers/guide
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  // Fungsi untuk menambah traveler baru
  void _addTraveler() {
    if (_nameController.text.isNotEmpty && _reviewController.text.isNotEmpty) {
      setState(() {
        _travelers.add({
          'name': _nameController.text,
          'review': _reviewController.text,
        });
        _nameController.clear();
        _reviewController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both name and review!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("People & Testimonial"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Add Traveler/Testimonial",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Input field untuk nama traveler
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Traveler/Guide Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Input field untuk testimoni
            TextField(
              controller: _reviewController,
              decoration: const InputDecoration(
                labelText: 'Testimonial/Review',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addTraveler,
              child: const Text('Add Traveler/Review'),
            ),
            const SizedBox(height: 20),
            // Menampilkan daftar traveler dan review
            const Text(
              "Traveler/Guide List",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _travelers.isEmpty
                  ? const Center(child: Text('No travelers added yet.'))
                  : ListView.builder(
                      itemCount: _travelers.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text(
                                _travelers[index]['name']![0].toUpperCase(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(_travelers[index]['name']!),
                            subtitle: Text(_travelers[index]['review']!),
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
