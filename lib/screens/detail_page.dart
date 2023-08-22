import 'package:flutter/material.dart';
import 'package:weather_app/widgets/index.dart';
import 'package:weather_app/models/weather_viewmodel.dart';

class DetailPage extends StatelessWidget {
  final WeatherData weatherData;

  const DetailPage({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey, // This will be replaced with gradient
      appBar: AppBar(
        title: Text(weatherData.location),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(8.0),
        crossAxisSpacing: 10, // adjust for desired spacing
        mainAxisSpacing: 10, // adjust for desired spacing
        children: [
          _buildTile(HumidityTile(humidity: weatherData.humidity)),
          _buildTile(PressureTile(pressure: weatherData.pressure)),
          _buildTile(SunriseSunsetTile(
              sunriseTimestamp: weatherData.sunrise,
              sunsetTimestamp: weatherData.sunset)),
          _buildTile(WindTile(
              windSpeed: weatherData.windSpeed,
              windDirection: weatherData.windDirection.toDouble())),
          // Add more tiles as needed
        ],
      ),
    );
  }

  Widget _buildTile(Widget tile) {
    return Card(
      elevation: 4, // adjust for desired elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // same borderRadius as tile
      ),
      child: tile,
    );
  }
}
