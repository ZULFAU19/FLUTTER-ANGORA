import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Untuk konversi data JSON

// Model Mountain
class Mountain {
  final String name;
  final String description;
  final String altitude;
  final bool hasDeathZone;
  final String location;
  final String firstClimber;
  final String firstClimbedDate;
  final String mountainImage;
  final String countryFlagImage;

  // Konstruktor dengan `required`
  Mountain({
    required this.name,
    required this.description,
    required this.altitude,
    required this.hasDeathZone,
    required this.location,
    required this.firstClimber,
    required this.firstClimbedDate,
    required this.mountainImage,
    required this.countryFlagImage,
  });

  // Factory untuk mengubah JSON menjadi objek Mountain
  factory Mountain.fromJson(dynamic json) {
    return Mountain(
      name: json['name'] as String,
      description: json['description'] as String,
      altitude: json['altitude'] as String,
      hasDeathZone: json['has_death_zone'] as bool,
      location: json['location'] as String,
      firstClimber: json['first_climber'] as String,
      firstClimbedDate: json['first_climbed_date'] as String,
      mountainImage: json['mountain_img'] as String,
      countryFlagImage: json['country_flag_img'] as String,
    );
  }

  // Mengubah list snapshot dari JSON menjadi List<Mountain>
  static List<Mountain> mountainsFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Mountain.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Mountain {name: $name, altitude: $altitude, location: $location}';
  }
}

// API Call untuk mendapatkan data gunung berdasarkan nama
class MountainApi {
  static Future<Mountain> getMountain(String name) async {
    var uri = Uri.https('mountain-api1.p.rapidapi.com', '/api/mountains', {
      'name': name, // Gunakan parameter nama
    });

    final response = await http.get(uri, headers: {
      'x-rapidapi-host': 'mountain-api1.p.rapidapi.com',
      'x-rapidapi-key':
          'fbb435a4e5msh7e4c9fe990f94d3p10f805jsna6d0eaf026ca', // Ganti dengan API key Anda
    });

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      return Mountain.fromJson(data);
    } else {
      throw Exception('Failed to load mountain: ${response.statusCode}');
    }
  }
}

// Widget untuk menampilkan informasi gunung dalam bentuk kartu
class MountainCard extends StatelessWidget {
  final String name;
  final String description;
  final String altitude;
  final String location;
  final String mountainImage;
  final String countryFlagImage;

  MountainCard({
    required this.name,
    required this.description,
    required this.altitude,
    required this.location,
    required this.mountainImage,
    required this.countryFlagImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 350,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            offset: Offset(
              0.0,
              10.0,
            ),
            blurRadius: 10.0,
            spreadRadius: -6.0,
          ),
        ],
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.35),
            BlendMode.multiply,
          ),
          image: NetworkImage(mountainImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Align(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            alignment: Alignment.topCenter,
          ),
          Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Altitude: $altitude',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Location: $location',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Image.network(
                        countryFlagImage,
                        width: 50,
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            alignment: Alignment.bottomLeft,
          ),
        ],
      ),
    );
  }
}

// MountainScreen Widget
class MountainScreen extends StatefulWidget {
  const MountainScreen({Key? key}) : super(key: key);

  @override
  _MountainScreenState createState() => _MountainScreenState();
}

class _MountainScreenState extends State<MountainScreen> {
  Mountain? _mountain;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    getMountainData();
  }

  Future<void> getMountainData() async {
    try {
      _mountain = await MountainApi.getMountain('Mount Everest');
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.terrain),
            SizedBox(width: 10),
            Text('Explore Mountain'),
          ],
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : _mountain != null
                  ? MountainCard(
                      name: _mountain!.name,
                      description: _mountain!.description,
                      altitude: _mountain!.altitude,
                      location: _mountain!.location,
                      mountainImage: _mountain!.mountainImage,
                      countryFlagImage: _mountain!.countryFlagImage,
                    )
                  : Center(child: Text('No data found')),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MountainScreen(),
  ));
}
