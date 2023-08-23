import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/models/weather_viewmodel.dart';
import 'package:weather_app/widgets/index.dart';
import 'package:weather_app/screens/home_screen.dart';

void main() {
  group('HomeScreen', () {
    late MockWeatherViewModel mockViewModel;

    setUp(() {
      mockViewModel = MockWeatherViewModel();
    });

    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<WeatherViewModel>.value(
            value: mockViewModel,
            child: HomeScreen(),
          ),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(ReorderableListView), findsOneWidget);
      expect(find.byType(WeatherCard),
          findsNWidgets(5)); // Assuming 5 cards based on cities list
    });

    // Add more tests here
  });
}

class MockWeatherViewModel implements WeatherViewModel, ChangeNotifier {
  @override
  WeatherData? get weatherData => null;

  @override
  set weatherData(WeatherData? value) {}

  @override
  Future<void> fetchWeather(String city) async {}

  @override
  void addListener(VoidCallback listener) {}

  @override
  void removeListener(VoidCallback listener) {}

  @override
  void notifyListeners() {}

  @override
  bool get hasListeners => false;

  @override
  void dispose() {}
}
