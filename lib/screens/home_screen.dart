import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_viewmodel.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/widgets/index.dart';
import './detail_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> cities = [
    'London',
    'Cardiff',
    'Leeds',
    'Edinburgh',
    'Belfast'
  ];
  List<WeatherData?> weatherDataList = [];

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  void _fetchWeatherData() {
    for (String city in cities) {
      final viewModel = context.read<WeatherViewModel>();
      viewModel.fetchWeather(city).then((_) {
        if (mounted) {
          // Check if the widget is still in the widget tree
          setState(() {
            weatherDataList.add(viewModel.weatherData);
          });
        }

        // Check for errors
        if (viewModel.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(viewModel.errorMessage!),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.lightBlue[50],
      ),
      child: Scaffold(
        backgroundColor: Colors.lightBlue[50],
        appBar: AppBar(
          title: const DateTimeDisplay(),
          backgroundColor: Colors.lightBlue[50],
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.lightBlue[50]!, Colors.lightBlue[300]!],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ReorderableListView(
              buildDefaultDragHandles: true,
              onReorder: _onReorder,
              children: List.generate(weatherDataList.length, (cardIndex) {
                return Dismissible(
                  key: Key(cities[cardIndex]),
                  onDismissed: (direction) {
                    setState(() {
                      weatherDataList.removeAt(cardIndex);
                      cities.removeAt(cardIndex);
                    });
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  DetailPage(
                                      weatherData: weatherDataList[cardIndex]!),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return ScaleTransition(
                                scale: animation, child: child);
                          },
                        ));
                      },
                      child:
                          WeatherCard(weatherData: weatherDataList[cardIndex]!),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final item = weatherDataList.removeAt(oldIndex);
      weatherDataList.insert(newIndex, item);

      final cityName = cities.removeAt(oldIndex);
      cities.insert(newIndex, cityName);
    });
  }
}
