import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false; // Untuk pengaturan mode gelap
  bool _notificationsEnabled = true; // Untuk pengaturan notifikasi
  String _selectedUsername = 'Zulfa Ulinnuha'; // Nama pengguna yang dipilih
  String _selectedLanguage = 'English'; // Bahasa yang dipilih

  // Daftar pengguna random
  final List<String> _users = ['Zulfa Ulinnuha', 'Ulin', 'Nuha'];

  // Daftar bahasa yang tersedia
  final List<String> _languages = [
    'English',
    'Bahasa Indonesia',
    'Español',
    'Français',
    'Deutsch'
  ];

  // Fungsi untuk menampilkan bottom sheet untuk memilih pengguna
  void _showUserSelection() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: _users.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(_users[index]),
              onTap: () {
                setState(() {
                  _selectedUsername =
                      _users[index]; // Update nama pengguna yang dipilih
                });
                Navigator.pop(context); // Tutup bottom sheet setelah memilih
              },
            );
          },
        );
      },
    );
  }

  // Fungsi untuk menampilkan bottom sheet untuk memilih bahasa
  void _showLanguageSelection() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: _languages.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(_languages[index]),
              onTap: () {
                setState(() {
                  _selectedLanguage =
                      _languages[index]; // Update bahasa yang dipilih
                });
                Navigator.pop(context); // Tutup bottom sheet setelah memilih
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: const Color.fromARGB(255, 61, 155, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              "Pengaturan Akun",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Pengaturan Nama Pengguna
            ListTile(
              leading: const Icon(Icons.person, color: Colors.blue),
              title: Text("Nama Pengguna: $_selectedUsername"),
              subtitle: const Text("Klik untuk memilih nama pengguna"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap:
                  _showUserSelection, // Panggil fungsi untuk menampilkan list pengguna
            ),
            const SizedBox(height: 20),
            const Text(
              "Pengaturan Aplikasi",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Pengaturan Mode Gelap
            SwitchListTile(
              title: const Text("Mode Gelap"),
              subtitle: const Text("Aktifkan mode gelap untuk aplikasi"),
              value: _isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
              secondary: const Icon(Icons.dark_mode, color: Colors.blue),
            ),
            // Pengaturan Notifikasi
            SwitchListTile(
              title: const Text("Notifikasi"),
              subtitle: const Text("Aktifkan atau nonaktifkan notifikasi"),
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
              secondary: const Icon(Icons.notifications, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            const Text(
              "Pengaturan Umum",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Pengaturan Bahasa
            ListTile(
              leading: const Icon(Icons.language, color: Colors.blue),
              title: Text("Bahasa: $_selectedLanguage"),
              subtitle: const Text("Klik untuk memilih bahasa"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap:
                  _showLanguageSelection, // Panggil fungsi untuk menampilkan list bahasa
            ),
          ],
        ),
      ),
    );
  }
}
