import 'package:flutter/material.dart';
import 'package:weather_app/models/forecastdata_model.dart';
import 'package:weather_app/utils/weather_icons.dart';

class ForecastTile extends StatelessWidget {
  final ForecastData data;

  const ForecastTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100, // Set desired width
      height: 150, // Set desired height
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data.day,
            style: const TextStyle(fontSize: 14.0),
            textAlign: TextAlign.center,
          ),
          WeatherIcons.mapStringToIcon(data.weatherMain, 50),
          Text(
            _capitalizeEachWord(data.weatherDescription),
            style: const TextStyle(fontSize: 12.0),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  String _capitalizeEachWord(String text) {
    if (text.isEmpty) {
      return text;
    }
    var words = text
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .toList();

    if (words.length == 2) {
      return words.join('\n'); // join the two words with a newline
    } else {
      return words.join(' ');
    }
  }
}
