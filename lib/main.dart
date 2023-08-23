import 'package:flutter/material.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/services/weather_repository.dart';
import 'package:weather_app/services/network_service.dart';
import 'package:weather_app/models/weather_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
// import './services/citydata_service.dart'; // Uncomment if you are using this
//import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Hive.initFlutter();
  //var cityStorage = CityStorage();

  // await cityStorage.setDefaultCities();  // Uncomment if you are using this
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<http.Client>(
          create: (_) => http.Client(),
        ),
        ProxyProvider<http.Client, HttpWeatherRepository>(
          update: (context, client, _) => HttpWeatherRepository(
            api: OpenWeatherMapAPI('a54141ff5d2576e2a3f102bce3667b47'),
            client: client,
          ),
        ),
        ChangeNotifierProxyProvider<HttpWeatherRepository, WeatherViewModel>(
          create: (context) => WeatherViewModel(
            repository: context.read<HttpWeatherRepository>(),
          ),
          update: (context, repository, viewModel) =>
              viewModel ?? WeatherViewModel(repository: repository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather Plus',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
