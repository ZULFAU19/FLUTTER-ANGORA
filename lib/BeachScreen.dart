import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Untuk konversi data JSON

class BeachScreen extends StatefulWidget {
  const BeachScreen({Key? key}) : super(key: key);

  @override
  _BeachScreenState createState() => _BeachScreenState();
}

class _BeachScreenState extends State<BeachScreen> {
  List<dynamic> dataKota = []; // Untuk menyimpan hasil dari API
  bool isLoading = false;
  String searchQuery = ''; // Menyimpan query pencarian

  // Fungsi untuk mengambil data kota dari API berdasarkan keyword
  Future<void> fetchDataKota(String keyword) async {
    final url =
        'https://api.myquran.com/v2/sholat/kota/cari/$keyword'; // URL API untuk pencarian

    try {
      setState(() {
        isLoading = true; // Tampilkan loading saat mengambil data
      });
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          dataKota =
              json.decode(response.body)['data']; // Parsing JSON sebagai List
          isLoading = false;
        });
      } else {
        throw Exception('Gagal mengambil data');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Jadwal Sholat Kota Anda Saat ini '),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Cari Kota',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search),
                fillColor: const Color.fromARGB(
                    255, 255, 255, 255), // Background input field
                filled: true,
              ),
              onChanged: (query) {
                setState(() {
                  searchQuery = query; // Menyimpan query dari input
                });
              },
              onSubmitted: (query) {
                if (query.isNotEmpty) {
                  fetchDataKota(
                      query); // Memanggil API saat pencarian dilakukan
                }
              },
            ),
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    itemCount:
                        dataKota.length, // Menggunakan panjang list dari API
                    itemBuilder: (context, index) {
                      final kota = dataKota[index]; // Ambil data dari List
                      final id = kota['id'];
                      final namaKota = kota['lokasi'];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        elevation: 5,
                        child: ListTile(
                          leading: const Icon(Icons.location_city,
                              color: Colors.blue),
                          title: Text('Kota: $namaKota (ID: $id)',
                              style: TextStyle(fontSize: 18)),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Navigasi ke halaman detail jadwal sholat berdasarkan ID kota
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    JadwalSholatDetailScreen(kotaId: id),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

// Halaman untuk menampilkan detail jadwal sholat
class JadwalSholatDetailScreen extends StatefulWidget {
  final String kotaId; // Terima ID kota dari halaman sebelumnya

  const JadwalSholatDetailScreen({required this.kotaId, Key? key})
      : super(key: key);

  @override
  _JadwalSholatDetailScreenState createState() =>
      _JadwalSholatDetailScreenState();
}

class _JadwalSholatDetailScreenState extends State<JadwalSholatDetailScreen> {
  Map<String, dynamic>? jadwalSholat;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchJadwalSholat();
  }

  // Fungsi untuk mengambil data jadwal sholat berdasarkan ID kota
  Future<void> fetchJadwalSholat() async {
    final url =
        'https://api.myquran.com/v2/sholat/jadwal/${widget.kotaId}/2024/10/14'; // Sesuaikan tanggal
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          jadwalSholat = json.decode(response.body)['data']['jadwal'];
          isLoading = false;
        });
      } else {
        throw Exception('Gagal mengambil jadwal sholat');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Sholat Kota ID: ${widget.kotaId}'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : jadwalSholat != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Subuh: ${jadwalSholat!['subuh']}',
                          style: TextStyle(fontSize: 20)),
                      Text('Dzuhur: ${jadwalSholat!['dzuhur']}',
                          style: TextStyle(fontSize: 20)),
                      Text('Ashar: ${jadwalSholat!['ashar']}',
                          style: TextStyle(fontSize: 20)),
                      Text('Maghrib: ${jadwalSholat!['maghrib']}',
                          style: TextStyle(fontSize: 20)),
                      Text('Isya: ${jadwalSholat!['isya']}',
                          style: TextStyle(fontSize: 20)),
                    ],
                  ),
                )
              : const Center(child: Text('Jadwal sholat tidak ditemukan')),
    );
  }
}
