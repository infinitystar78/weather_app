import 'package:app_settings/app_settings.dart';
import 'package:weather_app/models/weather.dart';
import '/services/location_service.dart';
import '/services/weather_repository.dart';
import '/services/citydata_service.dart';
import '/services/network_service.dart';
import 'package:flutter/material.dart';
import '/utils/api_keys.default.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/cityweather.dart';

class HomeScreenViewModel {
  List<CityWeatherViewModel> forecasts = [];

  final LocationService _locationService = LocationService();
  final HttpWeatherRepository _weatherRepository = HttpWeatherRepository(
    api: OpenWeatherMapAPI(APIKeys.openWeatherAPIKey),
    client: http.Client(),
  );

  final CityStorage _cityStorage = CityStorage();

  Future<List<String>> getAllSavedCities() async {
    List<dynamic> cities = await _cityStorage.getAllSavedCities();
    return cities.cast<String>();
  }

  //deleteCity
  Future<void> deleteCity(String city) async {
    await _cityStorage.deleteCity(city);
  }

  Future<LocationResult> fetchLocationAsync() {
    return _locationService.getCurrentLocation();
  }

  Future<void> fetchWeatherForLocation(LocationResult locationResult) async {
    if (!locationResult.isPermissionDenied &&
        locationResult.errorMessage == null &&
        locationResult.cityName != null) {
      WeatherResponse response =
          await _weatherRepository.getWeather(city: locationResult.cityName!);

      if (response.weather.isNotEmpty) {
        CityWeatherViewModel currentCityForecast = CityWeatherViewModel(
            temperature: response.main.temp.toString(),
            feelsLike: response.main.feelsLike.toString(),
            description: response.weather[0].description,
            icon: response.weather[0].icon,
            name: response.name);
        forecasts.insert(0,
            currentCityForecast); // Adds current location's forecast to the beginning.
      }
    }
  }

  Future<List<CityWeatherViewModel>> fetchWeatherForSavedCities() async {
    forecasts.clear();
    final cities = await _cityStorage.getAllSavedCities();
    print('60.saved.cities:,$cities');
    final savedCityResponses = await Future.wait(cities
        .map((city) => _weatherRepository.getWeather(city: city.toString())));

    for (WeatherResponse response in savedCityResponses) {
      if (response.weather.isNotEmpty) {
        CityWeatherViewModel cityForecast = CityWeatherViewModel(
            temperature: response.main.temp.toString(),
            feelsLike: response.main.feelsLike.toString(),
            description: response.weather[0].description,
            icon: response.weather[0].icon,
            name: response.name);
        forecasts.add(cityForecast);
      }
    }
    return forecasts;
  }

  void handleLocationResult(BuildContext context, LocationResult result) {
    if (result.isPermissionDenied) {
      _showLocationDeniedDialog(context);
    } else if (result.errorMessage != null) {
      // Handle other errors
    } else {
      // Use result.locationData
    }
  }

  void _showLocationDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Location Permission Denied"),
          content: const Text(
              "This app requires location permissions to function. Please open settings and grant permissions to continue."),
          actions: <Widget>[
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Open Settings"),
              onPressed: () {
                AppSettings.openAppSettings();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
