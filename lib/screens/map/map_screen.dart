import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:samy/core/services/local_services.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? mapController;
  LatLng _lastKnownLocation = const LatLng(30.0444, 31.2357);
  late StreamSubscription<LatLng> _locationSubscription;

  @override
  void initState() {
    super.initState();
    _loadLastLocation();
    _locationSubscription =
        LocationService.instance.locationStream.listen((location) {
      setState(() {
        _lastKnownLocation = location;
        mapController?.animateCamera(
          CameraUpdate.newLatLng(_lastKnownLocation),
        );
      });
    });
  }

  Future<void> _loadLastLocation() async {
    final location = await LocationService.instance.getLastLocation();
    setState(() {
      _lastKnownLocation = location;
    });
  }

  @override
  void dispose() {
    _locationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location Tracking')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _lastKnownLocation,
          zoom: 15,
        ),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        markers: {
          Marker(
            markerId: const MarkerId('current_location'),
            position: _lastKnownLocation,
          ),
        },
      ),
    );
  }
}
