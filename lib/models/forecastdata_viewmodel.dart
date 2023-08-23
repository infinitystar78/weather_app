import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_app/services/network_service.dart';
import 'package:weather_app/models/forecastdata_model.dart';
import 'package:intl/intl.dart';

class ForecastViewModel {
  final OpenWeatherMapAPI api;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  ForecastViewModel({required this.api});

  Future<List<ForecastData>> fetchFiveDayForecast(String city) async {
    try {
      final response = await http.get(api.forecast(city));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final forecastList = jsonResponse['list'] as List;

        // Taking 5 distinct days data
        List<ForecastData> fiveDayForecast = [];
        for (int i = 0; i < 40 && fiveDayForecast.length < 5; i += 8) {
          final mainWeather = forecastList[i]['weather'][0]['main'] as String;
          final description =
              forecastList[i]['weather'][0]['description'] as String;

          // Extracting day from the timestamp
          final timestamp = forecastList[i]['dt'];
          final date =
              DateTime.fromMillisecondsSinceEpoch((timestamp as int) * 1000);
          final day = DateFormat('EEE').format(date);

          fiveDayForecast.add(
            ForecastData(
              weatherMain: mainWeather,
              weatherDescription: description,
              day: day,
            ),
          );
        }

        return fiveDayForecast;
      } else {
        _errorMessage = 'Failed to load forecast.';
        throw Exception('Failed to load forecast');
      }
    } catch (error) {
      _errorMessage = error.toString();
      throw Exception(_errorMessage);
    }
  }
}
