import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:ui' as ui;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void notif() async {
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@drawable/required_icon');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

void notification_alert_required() async {
  notif();
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('your channel id', 'Earplugs are required',
          channelDescription:
              'If not available, withdrawal from the environment is also an option',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
          color: ui.Color.fromARGB(255, 255, 60, 0),
          icon: '@drawable/required_icon');

  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);

  await flutterLocalNotificationsPlugin.show(
      0, // notification id
      'Earplugs are required', // notification title
      'If not available, withdrawal from the environment is also an option', // notification body
      notificationDetails, // notification details
      payload: 'reminder' // optional payload

      );
}

void notification_alert_recommended() async {
  notif();
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('your channel id', 'Earplugs are recommended',
          channelDescription:
              'If not available, withdrawal from the environment is also an option',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
          color: ui.Color.fromARGB(255, 255, 60, 0),
          icon: '@drawable/required_icon');

  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);

  await flutterLocalNotificationsPlugin.show(
      0, // notification id
      'Earplugs are recommended', // notification title
      'If not available, withdrawal from the environment is also an option', // notification body
      notificationDetails, // notification details
      payload: 'reminder' // optional payload

      );
}
