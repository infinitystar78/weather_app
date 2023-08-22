import 'package:flutter/material.dart';

class HumidityTile extends StatelessWidget {
  final int humidity;

  const HumidityTile({super.key, required this.humidity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Humidity",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 12.0),
          Text(
            "$humidity%",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 32.0,
            ),
          ),
        ],
      ),
    );
  }
}
