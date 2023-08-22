import 'package:location/location.dart' as location_lib;
import 'package:geocoding/geocoding.dart';

class LocationService {
  final location_lib.Location location = location_lib.Location();

  Future<LocationResult> getCurrentLocation() async {
    bool serviceEnabled;
    location_lib.PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return LocationResult.failed("Service not enabled");
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == location_lib.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != location_lib.PermissionStatus.granted) {
        return LocationResult.permissionDenied();
      }
    }

    var loc = await location.getLocation();
    String? cityName = await _getCityNameFromLocation(loc);

    return LocationResult.success(loc, cityName);
  }

  Future<String?> _getCityNameFromLocation(
      location_lib.LocationData locationData) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        locationData.latitude!,
        locationData.longitude!,
      );
      if (placemarks.isNotEmpty && placemarks[0].locality != null) {
        return placemarks[0].locality;
      }
    } catch (e) {
      print("Error fetching city name: $e");
    }
    return null;
  }
}

class LocationResult {
  final location_lib.LocationData? locationData;
  final String? cityName;
  final String? errorMessage;
  final bool isPermissionDenied;

  LocationResult.success(this.locationData, this.cityName)
      : isPermissionDenied = false,
        errorMessage = null;

  LocationResult.failed(this.errorMessage)
      : isPermissionDenied = false,
        locationData = null,
        cityName = null;

  LocationResult.permissionDenied()
      : isPermissionDenied = true,
        locationData = null,
        cityName = null,
        errorMessage = null;
}
