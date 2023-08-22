import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_viewmodel.dart';

class WeatherCard extends StatelessWidget {
  final WeatherData weatherData;

  const WeatherCard({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: Colors.lightBlue[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: weatherData.icon,
                  ),
                ),
                const SizedBox(width: 16.0), // A spacing between icon and temperature
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${weatherData.temperature.toStringAsFixed(0)}°C',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.85),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'High ${weatherData.highTemp.toStringAsFixed(0)}°C , Low ${weatherData.lowTemp.toStringAsFixed(0)}°C',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.75),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              capitalize(weatherData.description),
              style:
                  TextStyle(fontSize: 22, color: Colors.blue.withOpacity(0.75)),
            ),
            Text(
              weatherData.location,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.75),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
