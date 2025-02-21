import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:samy/core/services/local_services.dart';
import 'package:samy/core/services/notification_services.dart';

class DeviceService {
  static final DeviceService instance = DeviceService._internal();
  factory DeviceService() => instance;
  DeviceService._internal();

  bool isConnected = false;

  final StreamController<double> _batteryLevelController =
      StreamController<double>.broadcast();
  Stream<double> get batteryLevelStream => _batteryLevelController.stream;

  // Simulate device connection
  Future<bool> connectToDevice() async {
    try {
      // Here you would implement your actual device connection logic
      isConnected = true;
      // Simulate battery updates
      Timer.periodic(const Duration(minutes: 1), (timer) {
        if (isConnected) {
          updateBatteryLevel(85.0);
        }
      });
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error connecting to device: $e');
      }

      isConnected = false;
      return false;
    }
  }

  void updateBatteryLevel(double level) {
    _batteryLevelController.add(level);
    if (level <= 10) {
      NotificationService.instance.addNotification(
        'Low Battery',
        'Device battery is at ${level.round()}%',
      );
    }
  }

  void simulateFallDetection() {
    if (isConnected) {
      NotificationService.instance.addNotification(
        'Fall Detected',
        'Fall detected at ${DateTime.now()}',
      );
      // Update location
      LocationService.instance.updateLastLocation(
        const LatLng(30.0444, 31.2357), // Example location
      );
    }
  }

  Future<void> disconnect() async {
    isConnected = false;
  }
}
