import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_repository.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/utils/weather_icons.dart';

class WeatherViewModel extends ChangeNotifier {
  final HttpWeatherRepository _repository;
  WeatherData? _weatherData;

  WeatherViewModel({required HttpWeatherRepository repository})
      : _repository = repository;

  WeatherData? get weatherData => _weatherData;

  Future<void> fetchWeather(String city) async {
    try {
      final response = await _repository.getWeather(city: city);
      _weatherData = _transformToWeatherData(response);
      notifyListeners();
    } catch (e) {
      // Handle error cases accordingly
    }
  }

  WeatherData _transformToWeatherData(WeatherResponse response) {
    const iconSize = 58.0;

    return WeatherData(
        location: response.name,
        date: DateTime.fromMillisecondsSinceEpoch(response.dt * 1000),
        icon: WeatherIcons.mapStringToIcon(response.weather[0].main, iconSize),
        highTemp: response.main.tempMax,
        lowTemp: response.main.tempMin,
        description: response.weather[0].description,
        temperature: response.main.temp,
        humidity: response.main.humidity,
        pressure: response.main.pressure,
        windSpeed: response.wind.speed,
        windDirection: response.wind.deg,
        sunrise: response.sys.sunrise,
        sunset: response.sys.sunset,
        feelsLike: response.main.feelsLike);
  }
}

class WeatherData {
  final String location;
  final DateTime date;
  final Icon icon;
  final double highTemp;
  final double lowTemp;
  final String description;
  final double temperature;
  final int sunrise;
  final int sunset;
  final double windSpeed;
  final int windDirection;
  final double feelsLike;
  final int pressure;
  final int humidity;

  WeatherData({
    required this.location,
    required this.date,
    required this.icon,
    required this.highTemp,
    required this.lowTemp,
    required this.description,
    required this.temperature,
    required this.sunrise,
    required this.sunset,
    required this.windSpeed,
    required this.windDirection,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
  });
}
