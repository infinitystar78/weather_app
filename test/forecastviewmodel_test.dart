import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/services/network_service.dart';
import 'package:weather_app/models/forecastdata_viewmodel.dart';
import 'dart:convert';

class MockClient extends Mock implements http.Client {}

class MockAPI extends Mock implements OpenWeatherMapAPI {
  @override
  Uri forecast(String city) => Uri.parse("https://api.mock/$city");
}

void main() {
  late MockClient mockClient;
  late MockAPI mockAPI;
  late ForecastViewModel viewModel;

  setUp(() {
    mockClient = MockClient();
    mockAPI = MockAPI();
    viewModel = ForecastViewModel(api: mockAPI);

    when(mockAPI.forecast(any as String)).thenReturn(Uri.parse(
        'https://mocked.com')); // This mock ensures the Uri method returns a valid Uri.
  });

  group('ForecastViewModel', () {
    test('fetchFiveDayForecast returns valid data', () async {
      final fakeResponse = {
        "list": [
          {
            "weather": [
              {"main": "Cloudy", "description": "cloudy weather"}
            ],
            "dt": 1632168800
          },
          // ... Other weather data here
        ]
      };

      when(mockClient.get(any as Uri)).thenAnswer(
          (_) async => http.Response(json.encode(fakeResponse), 200));

      final forecast = await viewModel.fetchFiveDayForecast('DummyCity');

      expect(forecast[0].weatherMain, "Cloudy");
      expect(forecast[0].weatherDescription, "cloudy weather");
      expect(forecast[0].day, isNotNull);
    });

    test('throws an exception when the fetch fails', () async {
      when(mockClient.get(any as Uri))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() async => await viewModel.fetchFiveDayForecast('DummyCity'),
          throwsA(isA<Exception>()));
    });
  });
}
