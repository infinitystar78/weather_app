import 'package:flutter/material.dart';
import 'package:weather_app/models/cityweather.dart';
import 'package:weather_app/models/homescreen_model.dart';

class WeatherListView extends StatefulWidget {
  const WeatherListView({Key? key}) : super(key: key);

  @override
  WeatherListViewState createState() => WeatherListViewState();
}

class WeatherListViewState extends State<WeatherListView> {
  final HomeScreenViewModel viewModel = HomeScreenViewModel();
  List<CityWeatherViewModel?>? cities;

  @override
  void initState() {
    super.initState();
    _loadCities();
  }

  void _loadCities() async {
    print("Loading cities...");
    final fetchedCities = await viewModel.fetchWeatherForSavedCities();
    print("Cities fetched: $fetchedCities");
    setState(() {
      cities = fetchedCities; // Update cities once they're fetched.
    });
  }

  void _onCityTap(CityWeatherViewModel? cityWeather) {
    if (cityWeather != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CityDetailsView(weather: cityWeather, cityName: cityWeather.name),
        ),
      );
    }
  }

  bool _onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = cities!.removeAt(oldIndex);
    cities!.insert(newIndex, item);

    setState(() {});

    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (cities == null) {
      return Scaffold(
        backgroundColor: Colors.lightBlue[100],
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.red,
      body: ReorderableListView.builder(
        itemCount: cities!.length,
        onReorder: _onReorder,
        itemBuilder: (context, index) {
          final city = cities![index];
          return Dismissible(
            key: Key(city?.name ?? 'Unknown'),
            onDismissed: (direction) {
              viewModel.deleteCity(city?.name ?? '');
              setState(() {
                cities!.removeAt(index);
              });
            },
            child: InkWell(
              onTap: () => _onCityTap(city),
              child: Card(
                child: ListTile(
                  title: Text(city?.name ?? 'Unknown'),
                  subtitle: Text(city?.description ?? ''),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add city action
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CityDetailsView extends StatelessWidget {
  final CityWeatherViewModel? weather;
  final String? cityName;

  const CityDetailsView({Key? key, required this.weather, this.cityName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(cityName ?? 'City Details')),
      body: Column(
        children: [
          Text(cityName ?? 'Unknown'),
          // TODO: Add more weather details here
        ],
      ),
    );
  }
}
