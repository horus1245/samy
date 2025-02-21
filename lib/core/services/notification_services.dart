import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static final NotificationService instance = NotificationService._internal();
  factory NotificationService() => instance;
  NotificationService._internal();

  final StreamController<Map<String, dynamic>> _notificationController =
      StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get notificationStream =>
      _notificationController.stream;

  void addNotification(String title, String message) {
    final notification = {
      'title': title,
      'message': message,
      'timestamp': DateTime.now().toIso8601String(),
    };
    _notificationController.add(notification);
    _saveNotification(notification);
  }

  Future<void> _saveNotification(Map<String, dynamic> notification) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> notifications = prefs.getStringList('notifications') ?? [];
    notifications.add(json.encode(notification));
    await prefs.setStringList('notifications', notifications);
  }

  Future<List<Map<String, dynamic>>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> notifications = prefs.getStringList('notifications') ?? [];
    return notifications
        .map((String notification) =>
            json.decode(notification) as Map<String, dynamic>) // التعديل هنا
        .toList();
  }
}
