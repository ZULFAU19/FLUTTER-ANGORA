import 'package:flutter/material.dart';

class HotelScreen extends StatelessWidget {
  const HotelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hotel"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.hotel,
              size: 100,
              color: Colors.green,
            ),
            SizedBox(height: 20),
            Text(
              "Welcome to the Hotel Screen",
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
