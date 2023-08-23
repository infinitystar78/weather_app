import 'package:flutter/material.dart';
import 'package:weather_app/widgets/index.dart';
import 'package:weather_app/models/weather_viewmodel.dart';

class DetailPage extends StatelessWidget {
  final WeatherData weatherData;

  const DetailPage({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title: DefaultTextStyle(
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24.0, // Adjust the font size as needed
          ),
          child: Text(weatherData.location),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 105, 153),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20), // Space between the top and the title

          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              "5 Day Forecast",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 10), // Space between the title and the forecast

          // Place the FiveDayForecast just below the title
          FiveDayForecast(cityName: weatherData.location),

          // Make the rest of the content scrollable
          Expanded(
            child: GridView.count(
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
          ),
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
