import 'package:flutter/material.dart';
import 'dart:math';

class WindTile extends StatelessWidget {
  final double windSpeed;
  final double windDirection; // In degrees

  const WindTile(
      {Key? key, required this.windSpeed, required this.windDirection})
      : super(key: key);

  String windDirectionToCompass(double degree) {
    if (degree >= 337.5 || degree < 22.5) {
      return "N";
    } else if (degree < 67.5) {
      return "NE";
    } else if (degree < 112.5) {
      return "E";
    } else if (degree < 157.5) {
      return "SE";
    } else if (degree < 202.5) {
      return "S";
    } else if (degree < 247.5) {
      return "SW";
    } else if (degree < 292.5) {
      return "W";
    } else {
      return "NW";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circle
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2.0),
              shape: BoxShape.circle,
            ),
          ),
          // Wind speed and direction
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${windDirectionToCompass(windDirection)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              Text(
                "$windSpeed kph",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
