import 'dart:async';

import 'package:flutter/material.dart';
import 'package:samy/core/services/device_services.dart';

class BatteryPage extends StatefulWidget {
  const BatteryPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BatteryPageState createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  double batteryLevel = 100.0;
  late StreamSubscription<double> _batterySubscription;

  @override
  void initState() {
    super.initState();
    _batterySubscription =
        DeviceService.instance.batteryLevelStream.listen((level) {
      setState(() {
        batteryLevel = level;
      });
    });
  }

  @override
  void dispose() {
    _batterySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Battery Status')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: ListTile(
                title: const Text('Device Connection'),
                trailing: StreamBuilder<bool>(
                  stream: Stream.periodic(const Duration(seconds: 1))
                      .map((_) => DeviceService.instance.isConnected),
                  initialData: false,
                  builder: (context, snapshot) {
                    return Switch(
                      value: snapshot.data ?? false,
                      onChanged: (value) async {
                        if (value) {
                          await DeviceService.instance.connectToDevice();
                        } else {
                          await DeviceService.instance.disconnect();
                        }
                        setState(() {});
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Battery Level',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: batteryLevel / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                batteryLevel > 20 ? Colors.green : Colors.red,
              ),
            ),
            Text('${batteryLevel.round()}%'),
          ],
        ),
      ),
    );
  }
}
