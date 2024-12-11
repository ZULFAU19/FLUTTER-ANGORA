import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Untuk konversi data JSON

class DesertScreen extends StatefulWidget {
  const DesertScreen({Key? key}) : super(key: key);

  @override
  _DesertScreenState createState() => _DesertScreenState();
}

class _DesertScreenState extends State<DesertScreen> {
  List<dynamic> suratList = []; // Untuk menyimpan hasil dari API
  bool isLoading = false;

  // Fungsi untuk mengambil data surat dari API
  Future<void> fetchDataSurat() async {
    final url =
        'https://api.npoint.io/99c279bb173a6e28359c/data'; // URL API Surat

    try {
      setState(() {
        isLoading = true; // Tampilkan loading saat mengambil data
      });
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          suratList = json.decode(response.body); // Parsing JSON sebagai List
          isLoading = false;
        });
      } else {
        throw Exception('Gagal mengambil data surat');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataSurat(); // Memanggil fetchDataSurat saat halaman pertama kali dimuat
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Surat Al-Quran'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg.png'), // Background Gambar
            fit: BoxFit.cover, // Menyesuaikan gambar agar memenuhi layar
            opacity: 0.5, // Menambahkan efek transparansi
          ),
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : suratList.isEmpty
                ? const Center(child: Text('Data surat tidak ditemukan'))
                : ListView.builder(
                    itemCount: suratList.length,
                    itemBuilder: (context, index) {
                      final surat = suratList[index]; // Ambil data dari List
                      final namaSurat = surat['nama'];
                      final arti = surat['arti'];
                      final jumlahAyat = surat['ayat'];
                      final nomorSurat = surat['nomor'];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        elevation: 5,
                        child: ListTile(
                          leading: const Icon(Icons.library_books,
                              color: Colors.blue),
                          title: Text('$namaSurat ($arti)',
                              style: TextStyle(fontSize: 18)),
                          subtitle: Text('Jumlah Ayat: $jumlahAyat'),
                          trailing: const Icon(Icons.arrow_forward),
                          onTap: () {
                            // Navigasi ke halaman detail surat berdasarkan nomor surat
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SuratDetailScreen(nomorSurat: nomorSurat),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}

// Halaman untuk menampilkan detail surat
class SuratDetailScreen extends StatefulWidget {
  final String nomorSurat;

  const SuratDetailScreen({required this.nomorSurat, Key? key})
      : super(key: key);

  @override
  _SuratDetailScreenState createState() => _SuratDetailScreenState();
}

class _SuratDetailScreenState extends State<SuratDetailScreen> {
  List<dynamic> ayatList = [];
  bool isLoading = true;

  // Fungsi untuk mengambil data ayat dari API berdasarkan nomor surat
  Future<void> fetchAyatData() async {
    final url =
        'https://api.npoint.io/99c279bb173a6e28359c/surat/${widget.nomorSurat}'; // URL API Ayat

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          ayatList = json.decode(response.body); // Parsing JSON sebagai List
          isLoading = false;
        });
      } else {
        throw Exception('Gagal mengambil data ayat');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAyatData(); // Memanggil fetchAyatData saat halaman pertama kali dimuat
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Surat ${widget.nomorSurat} Detail'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ayatList.isEmpty
              ? const Center(child: Text('Ayat tidak ditemukan'))
              : ListView.builder(
                  itemCount: ayatList.length,
                  itemBuilder: (context, index) {
                    final ayat = ayatList[index]; // Ambil data dari List
                    final nomorAyat = ayat['nomor'];
                    final arabicText = ayat['ar'];
                    final terjemahan = ayat['id'];
                    final transliterasi = ayat['tr'];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      elevation: 5,
                      child: ListTile(
                        leading: const Icon(Icons.book, color: Colors.green),
                        title: Text('Ayat $nomorAyat',
                            style: TextStyle(fontSize: 18)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(arabicText,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'ScheherazadeNew')),
                            Text(terjemahan,
                                style: TextStyle(
                                    fontSize: 14, fontStyle: FontStyle.italic)),
                            Text(transliterasi,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
