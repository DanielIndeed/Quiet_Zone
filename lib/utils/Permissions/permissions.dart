// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void mic_permission() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (await Permission.microphone.isPermanentlyDenied) {
    openAppSettings();
  } else if (await Permission.microphone.isDenied) {
    await Permission.microphone.request();
  }
}

Future<void> notif_request() async {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }