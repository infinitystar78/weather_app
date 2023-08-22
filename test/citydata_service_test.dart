import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:weather_app/services/citydata_service.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() {
  CityStorage cityStorage = CityStorage();

  setUp(() async {
    // Initialize Hive in a test directory
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    Hive.init(appDocPath);
  });

  tearDown(() async {
    await Hive.deleteFromDisk(); // Clean up the storage after each test
  });

  test('Store and retrieve a city', () async {
    await cityStorage.storeCity('Test City');
    var city = await cityStorage.retrieveCity('Test City');
    expect(city, 'Test City');
  });

  test('Retrieve all cities', () async {
    await cityStorage.storeCity('Test City 1');
    await cityStorage.storeCity('Test City 2');
    var cities = await cityStorage.getAllSavedCities();
    expect(cities.length, 2);
  });

  test('Delete a city', () async {
    await cityStorage.storeCity('Test City');
    await cityStorage.deleteCity('Test City');
    var city = await cityStorage.retrieveCity('Test City');
    expect(city, null);
  });

  test('Clear all cities', () async {
    await cityStorage.storeCity('Test City 1');
    await cityStorage.storeCity('Test City 2');
    await cityStorage.clearAllCities();
    var cities = await cityStorage.getAllSavedCities();
    expect(cities.length, 0);
  });

  test('Set default cities when box is empty', () async {
    await cityStorage.clearAllCities();
    await cityStorage.setDefaultCities();
    var cities = await cityStorage.getAllSavedCities();
    expect(cities.length, 10);
    expect(cities[0], 'London');
  });
}
