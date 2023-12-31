import 'package:flutter/material.dart';
import 'package:weather_app/models/forecastdata_model.dart';
import 'package:weather_app/models/forecastdata_viewmodel.dart';
import 'package:weather_app/widgets/forecast_tile.dart';
import 'package:weather_app/services/network_service.dart';
import 'package:weather_app/utils/api_keys.default.dart';

class FiveDayForecast extends StatefulWidget {
  final String cityName;

  const FiveDayForecast({super.key, required this.cityName});

  @override
  FiveDayForecastState createState() => FiveDayForecastState();
}

class FiveDayForecastState extends State<FiveDayForecast> {
  List<ForecastData>? forecastDataList;
  final api = OpenWeatherMapAPI(APIKeys.openWeatherAPIKey);
  final forecastVM =
      ForecastViewModel(api: OpenWeatherMapAPI(APIKeys.openWeatherAPIKey));

  @override
  void initState() {
    super.initState();
    fetchForecastData();
  }

  fetchForecastData() async {
    try {
      List<ForecastData> data =
          await forecastVM.fetchFiveDayForecast(widget.cityName);
      setState(() {
        forecastDataList = data;
      });
    } catch (error) {
      print("Error fetching forecast: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (forecastDataList == null && forecastVM.errorMessage == null) {
      return const LinearProgressIndicator();
    } else if (forecastVM.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.error, color: Colors.red, size: 50.0),
            const SizedBox(height: 10.0),
            Text(
              "Error fetching data:\n${forecastVM.errorMessage}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: forecastDataList!
              .map((data) => ForecastTile(data: data))
              .toList(),
        ),
      );
    }
  }
}
