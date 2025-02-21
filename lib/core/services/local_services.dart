import 'dart:async';
import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationService {
  static final LocationService instance = LocationService._internal();
  factory LocationService() => instance;
  LocationService._internal();

  final StreamController<LatLng> _locationController =
      StreamController<LatLng>.broadcast();

  Stream<LatLng> get locationStream => _locationController.stream;
  LatLng _lastLocation = const LatLng(30.0444, 31.2357); // Default location

  void updateLastLocation(LatLng location) {
    _lastLocation = location;
    _locationController.add(location);
    _saveLocation(location);
  }

  Future<void> _saveLocation(LatLng location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'last_location',
        json.encode({
          'latitude': location.latitude,
          'longitude': location.longitude,
        }));
  }

  Future<LatLng> getLastLocation() async {
    final prefs = await SharedPreferences.getInstance();
    String? locationStr = prefs.getString('last_location');
    if (locationStr != null) {
      Map<String, dynamic> location = json.decode(locationStr);
      return LatLng(location['latitude'], location['longitude']);
    }
    return _lastLocation;
  }
}
