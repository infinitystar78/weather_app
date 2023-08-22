import 'package:flutter/material.dart';

class WeatherModel {
  final String location;
  final DateTime date;
  final Icon icon; // this would be the name of the Material Design icon
  final double highTemp;
  final double lowTemp;
  final String description;

  WeatherModel({
    required this.location,
    required this.date,
    required this.icon,
    required this.highTemp,
    required this.lowTemp,
    required this.description,
  });
}
