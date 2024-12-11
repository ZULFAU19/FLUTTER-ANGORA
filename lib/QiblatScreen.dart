import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QiblatScreen extends StatefulWidget {
  const QiblatScreen({super.key});

  @override
  _QiblatScreenState createState() => _QiblatScreenState();
}

class _QiblatScreenState extends State<QiblatScreen> {
  double? degrees; // Untuk menyimpan derajat arah Qiblat
  String? timezoneRequest;
  String? timezoneKaaba;
  double? latitude;
  double? longitude;

  // Fungsi untuk melakukan request API
  Future<void> fetchQiblatData() async {
    const String apiUrl =
        'https://islamic-developers-api.p.rapidapi.com/qibla?latitude=24.470901&longitude=39.612236';
    const Map<String, String> headers = {
      'x-rapidapi-host': 'islamic-developers-api.p.rapidapi.com',
      'x-rapidapi-key': 'fbb435a4e5msh7e4c9fe990f94d3p10f805jsna6d0eaf026ca',
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          degrees = data['degrees'];
          timezoneRequest = data['timezone']['request'];
          timezoneKaaba = data['timezone']['kaaba'];
          latitude = data['coordinates']['kaaba']['latitude'];
          longitude = data['coordinates']['kaaba']['longitude'];
        });
      } else {
        print('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchQiblatData(); // Panggil API ketika layar dibuka
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Qiblat"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: degrees == null
              ? const CircularProgressIndicator() // Jika data belum ada, tampilkan loading
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon untuk menggambarkan arah Qiblat
                    Icon(
                      Icons.explore, // Compass icon
                      size: 100,
                      color: Colors.blueAccent,
                    ),
                    const SizedBox(height: 20),
                    Card(
                      elevation: 4, // Memberikan bayangan pada card
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Text(
                              'Arah Qiblat',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Derajat: ${degrees!.toStringAsFixed(2)}°',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Divider(),
                            Text(
                              'Zona Waktu Request: $timezoneRequest',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Zona Waktu Kaaba: $timezoneKaaba',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Koordinat Kaaba:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Latitude: $latitude, Longitude: $longitude',
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Button untuk refresh data
                    ElevatedButton.icon(
                      onPressed: fetchQiblatData,
                      icon: const Icon(Icons.refresh),
                      label: const Text("Refresh Data"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
