import 'dart:async';

import 'package:flutter/material.dart';
import 'package:samy/core/services/notification_services.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Map<String, dynamic>> notifications = [];
  late StreamSubscription notificationSubscription;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
    notificationSubscription = NotificationService.instance.notificationStream
        .listen(_onNotificationReceived);
  }

  void _onNotificationReceived(Map<String, dynamic> notification) {
    setState(() {
      notifications.insert(0, notification);
    });
  }

  Future<void> _loadNotifications() async {
    final loadedNotifications =
        await NotificationService.instance.getNotifications();
    setState(() {
      notifications = loadedNotifications;
    });
  }

  @override
  void dispose() {
    notificationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: notifications.isEmpty
          ? const Center(child: Text('No notifications'))
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(notification['title']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notification['message']),
                        Text(
                          DateTime.parse(notification['timestamp'])
                              .toLocal()
                              .toString(),
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
