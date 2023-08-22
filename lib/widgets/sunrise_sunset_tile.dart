import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SunriseSunsetTile extends StatelessWidget {
  final int sunriseTimestamp; // in seconds since Unix epoch
  final int sunsetTimestamp; // in seconds since Unix epoch

  const SunriseSunsetTile(
      {super.key,
      required this.sunriseTimestamp,
      required this.sunsetTimestamp});

  @override
  Widget build(BuildContext context) {
    String sunriseTime = DateFormat.jm()
        .format(DateTime.fromMillisecondsSinceEpoch(sunriseTimestamp * 1000));
    String sunsetTime = DateFormat.jm()
        .format(DateTime.fromMillisecondsSinceEpoch(sunsetTimestamp * 1000));

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wb_sunny, size: 32.0, color: Colors.yellow),
          Text(sunriseTime,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.yellow)),
          const SizedBox(height: 16.0),
          const Icon(Icons.nights_stay, size: 32.0),
          Text(sunsetTime,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
        ],
      ),
    );
  }
}
