import 'package:hive/hive.dart';

class CityStorage {
  final String _boxName = 'citiesBox';
  final String _orderedCitiesKey = 'orderedCities';

  Future<Box<dynamic>> get _box async => await Hive.openBox<dynamic>(_boxName);

  Future<void> storeCity(String city) async {
    final box = await _box;
    if (!box.containsKey(city)) {
      box.put(city, city);
      // Add city to the ordered list
      var orderedCitiesDynamic = box.get(_orderedCitiesKey);
      List<String> orderedCities;
      if (orderedCitiesDynamic is List<String>) {
        orderedCities = orderedCitiesDynamic;
      } else {
        orderedCities = [];
      }
      orderedCities.add(city);
      box.put(_orderedCitiesKey, orderedCities);
    }
  }

  Future<dynamic> retrieveCity(String key) async {
    final box = await _box;
    return box.get(key);
  }

  Future<List<dynamic>> getAllSavedCities() async {
    final box = await _box;
    return (box.get(_orderedCitiesKey) as List?) ?? [];
  }

  Future<void> rearrangeCity(int oldIndex, int newIndex) async {
    final cities = await getAllSavedCities();
    final city = cities.removeAt(oldIndex);
    cities.insert(newIndex, city);
    final box = await _box;
    box.put(_orderedCitiesKey, cities);
  }

  Future<void> deleteCity(String city) async {
    final box = await _box;
    box.delete(city);
    // Remove city from the ordered list
    List<String>? orderedCities = box.get(_orderedCitiesKey) as List<String>?;
    orderedCities ??= [];
    orderedCities.remove(city);
    box.put(_orderedCitiesKey, orderedCities);
  }

  Future<void> clearAllCities() async {
    final box = await _box;
    box.clear();
  }

  //setup

  Future<void> setDefaultCities() async {
    final box = await _box;
    if (box.length == 0) {
      box.put('London', 'London');
      box.put('Birmingham', 'Birmingham');
      box.put('Glasgow', 'Glasgow');
      box.put('Liverpool', 'Liverpool');
      box.put('Bristol', 'Bristol');
      box.put('Manchester', 'Manchester');
      box.put('Leeds', 'Leeds');
      box.put('Belfast', 'Belfast');
      box.put('Edinburgh', 'Edinburgh');
      box.put('Cardiff', 'Cardiff');

      // Save the order of default cities
      box.put(_orderedCitiesKey, [
        'London',
        'Birmingham',
        'Glasgow',
        'Liverpool',
        'Bristol',
        'Manchester',
        'Leeds',
        'Belfast',
        'Edinburgh',
        'Cardiff'
      ]);
    }
  }
}
